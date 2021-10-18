import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/applyDaShen.dart';
import 'package:flutterapp2/pages/article.dart';
import 'package:flutterapp2/pages/lanqiukaijiang.dart';
import 'package:flutterapp2/pages/orderdetail.dart';
import 'package:flutterapp2/pages/zuqiukaijiang.dart';
import 'package:flutterapp2/pages/pailie.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/wiget/CommonWiget.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

import 'basketball.dart';
import 'football.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPage createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage> with AutomaticKeepAliveClientMixin {
  ScrollController _controller;
  Timer _timer;
  int page = 0;
  TextStyle checked_text_style =
  TextStyle(color: Color(0xfffa2020));
  TextStyle unchecked_text_style = null;
  BoxDecoration checked_border_style = BoxDecoration(
      border: Border(
          top: BorderSide(
            // 设置单侧边框的样式
              color: Color(0xfffa2020),
              width: 1.5,
              style: BorderStyle.solid)));
  BoxDecoration unchecked_border_style = null;
  PageController controller;
  double _offset = 0.0;
  List<String> containers = ["每日神单","资讯"];
  List newsContainer ;
  List news;
  List dashen;
  List zhongjiang = [];
  void initState() {
    super.initState();
    news = [];
    newsContainer= [];
    controller = new PageController(initialPage: this.page);
    loadNews();
  }
  loadNews() async {
   ResultData res = await HttpManager.getInstance().get("news",withLoading: false);
   ResultData res1 = await HttpManager.getInstance().get("zhongjiang",withLoading: false);

   setState(() {
     news = res.data["news"];
     dashen = res.data["dashen"];
    zhongjiang = res1.data["data"];
   });
  }

  List getDashen(){
    if(dashen != null){
      return dashen.asMap().keys.map((e){
        return GestureDetector(
          onTap: (){
            JumpAnimation().jump(orderdetail(int.parse(dashen[e]["id"].toString()),int.parse(dashen[e]["mode"]),dashen[e]["type"]), context);
          },
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15,right: 5,  top: 5, bottom: 5),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing:10,
                          children: <Widget>[
                            ClipOval(
                                child: Image.network(
                                  dashen[e]["avatar"],
                                  fit: BoxFit.fill,
                                  width: ScreenUtil().setWidth(55),
                                  height: ScreenUtil().setWidth(55),
                                )
                            ),
                            Container(
                              child: Text(dashen[e]["real_name"]),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                              color: Colors.red,
                              child: Text(dashen[e]["lian_hong"].toString()+"连红",style: TextStyle(color: Colors.white,fontSize: 10),),
                            )
                          ],
                        ),
                       Container(
                         child:  Wrap(
                           crossAxisAlignment: WrapCrossAlignment.center,
                           direction: Axis.vertical,
                           spacing: 5,
                           children: <Widget>[
                             Text(dashen[e]["award_money"].toString(),style: TextStyle(color: Colors.red,fontSize: 17,fontWeight: FontWeight.bold),),
                             Text("中奖金额",style: TextStyle(color: Colors.grey),)
                           ],
                         ),
                       )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      }).toList();
    }else{
      List<Widget> list = [];
      list.add(Text("暂无数据"));
      return list;
    }
  }
  List getNews(){
    if(news != null){
      return news.asMap().keys.map((e){
        return GestureDetector(
          onTap: (){
            JumpAnimation().jump(article(id: news[e]["id"],index: e+1,), context);
          },
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),

                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.network(news[e]["img"],fit: BoxFit.fill,width: ScreenUtil().setWidth(130),height: ScreenUtil().setHeight(76),),
                        Wrap(
                          spacing: 13,
                          direction: Axis.vertical,
                          children: <Widget>[
                            Container(
                              width:ScreenUtil().setWidth(232),
                              child: Text(news[e]["title"],maxLines: 1,
                                overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Text(news[e]["date"])
                          ],
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      }).toList();
    }else{
      List<Widget> list = [];
      list.add(Text("暂无数据"));
      return list;
    }
  }


  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  @override
  bool get wantKeepAlive => true;
  List img_url = [
    "img/d1.png",
    "img/d2.png",
    "img/d3.png",

  ];
  List texts = [
    {"name": "上证指数", "value": "2268.1 2.1%"},
    {"name": "深圳成指", "value": "5123.3 24.1%"}
  ];
  double appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(_style);
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);
    return Scaffold(
        appBar: PreferredSize(
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfffa2020),
              ),
              child: Center(
                child: SafeArea(
                  child: Text(
                    "精彩世界",
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(20)),
                  ),
                ),
              ),
            ),
            preferredSize: Size(double.infinity, ScreenUtil().setHeight(60))),
        body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(175),
                child: Swiper(
                  itemCount: img_url.length,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return index !=3?Image.asset(
                      img_url[index],
                      fit: BoxFit.fill,
                    ):GestureDetector(
                      onTap: (){
                        JumpAnimation().jump(applyDaShen(), context);
                      },
                      child: Image.asset(
                        img_url[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(right: 15),
                      builder: DotSwiperPaginationBuilder(
                          color: Color.fromRGBO(200, 200, 200, 0.5),
                          size: 8.0,
                          activeSize: 5.0)),
                ),
              ),
              Container(

                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Color(0xffebebeb)),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.notifications,color: Colors.orange,),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: ScreenUtil().setWidth(350),
                      height: ScreenUtil().setHeight(35),
                      child:  zhongjiang.length>0?Swiper(
                        itemCount: zhongjiang.length,
                        scrollDirection: Axis.vertical,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("恭喜 ",style: TextStyle(color: Color(0xff575757)),),
                                Text(zhongjiang[index]["nickname"]+" ",style: TextStyle(color: Color(0xff575757))),
                                Text("喜中",style: TextStyle(color: Color(0xff575757))),
                                zhongjiang[index]["type"] =="f"? Text("竞彩足球",style: TextStyle(color: Color(0xff575757))):Text("竞彩篮球",style: TextStyle(color: Color(0xff575757))),
                                Text(formatNum(zhongjiang[index]["award_money"], 1),style: TextStyle(color: Colors.red),),
                                Text("元",style: TextStyle(color: Color(0xff575757)))
                              ],
                            ),
                          );
                        },
                      ):Container(),
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(45),
                margin: EdgeInsets.only(top: 2),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 15),
                      height: ScreenUtil().setHeight(25),
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(width: 3, color: Colors.red))),
                    ),
                    Text("热门彩票")
                  ],
                ),
              ),

              Divider(
                height: 7,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Ink(
                      child: InkWell(

                        splashColor: Colors.black26,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadiusDirectional.circular(16)),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                "img/football.png",
                                fit: BoxFit.fill,
                                width: ScreenUtil().setWidth(55),
                                height: ScreenUtil().setWidth(55),
                              ),
                            ),

                            Container(
                              height: ScreenUtil().setWidth(55),
                              child: Wrap(
                                direction: Axis.vertical,
                                alignment: WrapAlignment.spaceAround,
                                children: <Widget>[Text("竞彩足球"), Text("五大联赛",style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)))],
                              ),
                            ),

                          ],
                        ),
                        onTap: () {
                          JumpAnimation().jump(football(), context);
                        },
                      ),
                    ),
                    Ink(
                      child: InkWell(
                        splashColor: Colors.black26,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadiusDirectional.circular(16)),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                "img/basketball.png",
                                fit: BoxFit.fill,
                                width: ScreenUtil().setWidth(55),
                                height: ScreenUtil().setWidth(55),
                              ),
                            ),
                            Container(
                              height: ScreenUtil().setWidth(55),
                              child: Wrap(
                                direction: Axis.vertical,
                                alignment: WrapAlignment.spaceAround,
                                children: <Widget>[Text("竞彩篮球"), Text("美职女篮开赛",style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)),)],
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          JumpAnimation().jump(basketball(), context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,top: 10,bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Ink(
                      child: InkWell(
                        splashColor: Colors.black26,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadiusDirectional.circular(16)),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                "img/pl3.jpg",
                                fit: BoxFit.fill,
                                width: ScreenUtil().setWidth(55),
                                height: ScreenUtil().setWidth(55),
                              ),
                            ),
                            Container(
                              height: ScreenUtil().setWidth(55),
                              child: Wrap(
                                direction: Axis.vertical,
                                alignment: WrapAlignment.spaceAround,
                                children: <Widget>[Text("排列三"), Text("排列三开售中",style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)),)],
                              ),
                            ),

                          ],
                        ),
                        onTap: () {
                          JumpAnimation().jump(pailie(), context);
                        },
                      ),
                    ),
                    Ink(
                      child: InkWell(
                        splashColor: Colors.black26,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadiusDirectional.circular(16)),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                "img/renjiu.png",
                                fit: BoxFit.fill,
                                width: ScreenUtil().setWidth(60),
                                height: ScreenUtil().setWidth(60),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 35),
                              height: ScreenUtil().setWidth(55),
                              child: Wrap(
                                direction: Axis.vertical,
                                alignment: WrapAlignment.spaceAround,
                                children: <Widget>[Text("任选9"), Text("即将开售",style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(12)),)],
                              ),
                            ),

                          ],
                        ),
                        onTap: () {
                          Toast.toast(context,msg: "即将开放");
                        },
                      ),
                    )
                  ],
                ),
              ),

              CommonWiget().getTaiTou("比分"),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        JumpAnimation().jump(zuqiukaijiang(), context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadiusDirectional.circular(5)),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          "img/swiper3.jpg",
                          fit: BoxFit.fill,
                          width: ScreenUtil().setWidth(180),
                          height: ScreenUtil().setHeight(105),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        JumpAnimation().jump(lanqiukaijiang(), context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadiusDirectional.circular(5)),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          "img/swiper2.jpg",
                          fit: BoxFit.fill,
                          width: ScreenUtil().setWidth(180),
                          height: ScreenUtil().setHeight(105),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(

                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: containers.asMap().keys.map((e) {
                        TextStyle cur_ts;
                        BoxDecoration cur_bd;
                        if(e == page){
                          cur_ts = checked_text_style;
                          cur_bd = checked_border_style;
                        }else{
                          cur_ts = unchecked_text_style;
                          cur_bd = unchecked_border_style;
                        }
                        return GestureDetector(
                          onTap: (){

                            setState(() {
                              this.page = e;

                            });

                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 7),
                            child: Column(
                              children: <Widget>[
                                Container(child: Text(containers[e],style: cur_ts,),),
                                Container(
                                  margin: EdgeInsets.only(top: 7),
                                  decoration: cur_bd,width: 160,
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                   Visibility(

                     visible: this.page==1,
                     child: Container(
                       margin: EdgeInsets.only(top: 15),
                       child: Column(
                         children:  getNews(),
                       ),
                     ),
                   ),
                Visibility(

                  visible: this.page==0,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Column(
                      children:  getDashen(),
                    ),
                  ),
                ),
                  ],
                ),
              ),


            ],
          ),
        ));
  }
  String formatNum(num num,int postion){
    if(num ==0){
      return "0";
    }
    List l = num.toString().split(".");
    if(l != null){
      if(l.length>1){
        if(l[1].toString().length==1){
          return num.toString();
        }
      }
    }
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }else{
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }
  }

}
