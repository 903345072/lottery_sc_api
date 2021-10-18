import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/flowdetail.dart';
import 'package:flutterapp2/pages/pailie/plflowdetail.dart';
import 'package:flutterapp2/pages/search.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Sender.dart';
import 'flow.dart';
import 'package:flutterapp2/utils/freshStyle.dart';
class floworder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<floworder> {
  Future _future;
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  List list = [];
  List dashen = [];
  List zhongjiang = [];
  Map uids = {};
  int page = 1;
  int index = 1;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    _future = getList(1);

  }
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  getMore() async {
    ResultData res = await HttpManager.getInstance().get("getMore",params:{"page":page,"index":index},withLoading: false);
    setState(() {
      if(res.data != null){
        if(res.data["data"] != null){
          List list2 = res.data["data"];
          list.addAll(list2);
        }
      }
    });
  }
  getList(index) async {
   ResultData res = await HttpManager.getInstance().get("getFlowOrder",params: {"index":index},withLoading: false);
   ResultData res1 = await HttpManager.getInstance().get("zhongjiang",withLoading: false);
   setState(() {
     page = 1;
      if(res.data["data"] != null){
        list = res.data["data"];
      }
     if(res.data["dashen"] != null){
       dashen = res.data["dashen"];
     }else{
       dashen = [];
     }
     uids = res.data["uids"];

     zhongjiang = res1.data["data"];
   });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(


        backgroundColor: Colors.white,
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            child:

            FutureBuilder(
                future: _future,
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return  Center(child: CircularProgressIndicator());

                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text('网络请求出错'),
                        );
                      }

                      return Center(
                        child: EasyRefresh(
                        
                          refreshFooter: freshStyle.getFooter(_footerKey),
                          child:  ListView(
                            children: <Widget>[
                              Column(

                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[

                                      Container(
                                        height: 250,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFC0CB),
                                        ),
                                      ),


                                      Positioned(

                                        child: Container(

                                          margin: EdgeInsets.only(top: 20),
                                          child: Image.asset("img/banjiang.png",fit: BoxFit.fill,),
                                        ),
                                      ),
                                      Container(

                                        child: GestureDetector(
                                          child: Container(

                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: (){
                                                    JumpAnimation().jump(Sender(uid: dashen[1]["uid"],), context);
                                                  },
                                                  child: Container(

                                                    margin: EdgeInsets.only(top: 30),
                                                    child: Column(
                                                      children: <Widget>[

                                                        Stack(
                                                          children: <Widget>[
                                                            Image.asset("img/number2.png",width: 80,height: 80,),
                                                            Positioned(
                                                              bottom: 16,
                                                              left: 16,
                                                              child: ClipOval(

                                                                  child: Image.network(

                                                                    dashen[1]["avatar"],
                                                                    fit: BoxFit.fill,
                                                                    width: ScreenUtil().setWidth(55),
                                                                    height: ScreenUtil().setWidth(55),
                                                                  )),
                                                            )

                                                          ],
                                                        ),
                                                        Container(
                                                          child: Text(dashen[1]["nickname"].toString().length>4?dashen[1]["nickname"].toString().substring(0,4):dashen[1]["nickname"].toString(),),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    JumpAnimation().jump(Sender(uid: dashen[0]["uid"],), context);
                                                  },
                                                  child: Container(

                                                    margin: EdgeInsets.only(left: 10,right: 10),
                                                    child: Column(
                                                      children: <Widget>[

                                                        Stack(
                                                          children: <Widget>[
                                                            Image.asset("img/number1.png",width: 80,height: 80,),
                                                            Positioned(
                                                              bottom: 16,
                                                              left: 16,
                                                              child: ClipOval(

                                                                  child: Image.network(

                                                                    dashen[0]["avatar"],
                                                                    fit: BoxFit.fill,
                                                                    width: ScreenUtil().setWidth(55),
                                                                    height: ScreenUtil().setWidth(55),
                                                                  )),
                                                            )

                                                          ],
                                                        ),
                                                        Container(
                                                          child: Text(dashen[0]["nickname"].toString().length>4?dashen[0]["nickname"].toString().substring(0,4):dashen[0]["nickname"].toString(),),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    JumpAnimation().jump(Sender(uid: dashen[2]["uid"],), context);
                                                  },
                                                  child:  Container(
                                                    margin: EdgeInsets.only(top: 40,right: 5),
                                                    child: Column(
                                                      children: <Widget>[

                                                        Stack(
                                                          children: <Widget>[
                                                            Image.asset("img/number3.png",width: 80,height: 80,),
                                                            Positioned(
                                                              bottom: 16,
                                                              left: 16,
                                                              child: ClipOval(
                                                                  child: Image.network(
                                                                    dashen[2]["avatar"],
                                                                    fit: BoxFit.fill,
                                                                    width: ScreenUtil().setWidth(55),
                                                                    height: ScreenUtil().setWidth(55),
                                                                  )),
                                                            )

                                                          ],
                                                        ),
                                                        Container(
                                                          child: Text(dashen[2]["nickname"].toString().length>4?dashen[2]["nickname"].toString().substring(0,4):dashen[2]["nickname"].toString(),),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 25,
                                        top: 40,
                                        child: GestureDetector(
                                          onTap: (){
                                            JumpAnimation().jump(flow(), context);
                                          },
                                          child: Text("关注",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                                                    child: Image.asset("img/dashen.png",color:Colors.deepOrange,width: ScreenUtil().setWidth(70),fit: BoxFit.fill,),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(3),right:ScreenUtil().setWidth(3), ),
                                                    child: Image.asset("img/tuijian.jpg",width: ScreenUtil().setWidth(20),fit: BoxFit.fill,),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(Icons.star,color: Colors.yellow,size: 10,),
                                                      Icon(Icons.star,color: Colors.yellow,size: 10,),
                                                      Icon(Icons.star,color: Colors.yellow,size: 10,),
                                                      Icon(Icons.star,color: Colors.yellow,size: 10,),
                                                      Icon(Icons.star,color: Colors.yellow,size: 10,),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              GestureDetector(
                                                onTap: (){
                                                  JumpAnimation().jump(search(), context);
                                                },
                                                child: Icon(Icons.search,color: Colors.grey,size: 25,),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: GridView.count(
                                            padding: EdgeInsets.only(left: 5),
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                            shrinkWrap: true,
                                            crossAxisCount: 4,
                                            children: dashen.asMap().keys.map((e) {
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: (){
                                                      JumpAnimation().jump(Sender(uid: dashen[e]["uid"],), context);
                                                    },
                                                    child: uids[dashen[e]["uid"].toString()] != null && uids[dashen[e]["uid"].toString()].length>0? Stack(
                                                      children: <Widget>[
                                                        Container(

                                                          margin:EdgeInsets.only(left: 10),
                                                          decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.yellow),borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(55)))),
                                                          child: ClipOval(
                                                              child: Image.network(
                                                                dashen[e]["avatar"],
                                                                fit: BoxFit.fill,
                                                                width: ScreenUtil().setWidth(55),
                                                                height: ScreenUtil().setWidth(55),
                                                              )),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(left: 45),

                                                          child: ClipOval(
                                                            child: Container(
                                                              width:17,
                                                              height: 17,
                                                              alignment: Alignment.center,

                                                              color:Colors.red,
                                                              child: Text(uids[dashen[e]["uid"].toString()].length.toString(),style: TextStyle(color: Colors.white),),
                                                            ),
                                                          ),
                                                        ),
                                                        dashen[e]["lian_hong"]>0? Container(
                                                          margin: EdgeInsets.only(top: 45,left: 20),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets.only(left: 3,right: 3),
                                                                alignment: Alignment.center,
                                                                height:17,
                                                                decoration:BoxDecoration(
                                                                    color: Colors.red,
                                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),topLeft: Radius.circular(12))
                                                                ),
                                                                child: Text(dashen[e]["lian_hong"].toString(),style: TextStyle(color: Colors.white,fontSize: 11),),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(left: 2,right: 2),
                                                                alignment: Alignment.center,
                                                                height:17,
                                                                decoration:BoxDecoration(
                                                                    border: Border.all(color: Colors.red,width: 0.1),
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topRight: Radius.circular(15))
                                                                ),
                                                                child: Text("连红",style: TextStyle(color: Colors.red,fontSize: 11),),
                                                              )
                                                            ],
                                                          ),
                                                        ):Container(),

                                                      ],
                                                    ):Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          margin:EdgeInsets.only(left: 10),
                                                          decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.yellow),borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(55)))),
                                                          child: ClipOval(
                                                              child: Image.network(
                                                                dashen[e]["avatar"],
                                                                fit: BoxFit.fill,
                                                                width: ScreenUtil().setWidth(55),
                                                                height: ScreenUtil().setWidth(55),
                                                              )),
                                                        ),

                                                        dashen[e]["lian_hong"]>0? Container(
                                                          margin: EdgeInsets.only(top: 45,left: 20),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets.only(left: 3,right: 3),
                                                                alignment: Alignment.center,
                                                                height:17,
                                                                decoration:BoxDecoration(
                                                                    color: Colors.red,
                                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),topLeft: Radius.circular(12))
                                                                ),
                                                                child: Text(dashen[e]["lian_hong"].toString(),style: TextStyle(color: Colors.white,fontSize: 11),),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(left: 2,right: 2),
                                                                alignment: Alignment.center,
                                                                height:17,
                                                                decoration:BoxDecoration(
                                                                    border: Border.all(color: Colors.red,width: 0.1),
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topRight: Radius.circular(15))
                                                                ),
                                                                child: Text("连红",style: TextStyle(color: Colors.red,fontSize: 11),),
                                                              )
                                                            ],
                                                          ),
                                                        ):Container(),



                                                      ],
                                                    ),
                                                  ),
                                                  Text(dashen[e]["nickname"].toString().length>4?dashen[e]["nickname"].toString().substring(0,4):dashen[e]["nickname"].toString())
                                                ],
                                              );
                                            }).toList(),),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          height: ScreenUtil().setHeight(35),
                                          width: double.infinity,
                                          child: Row(
                                            children: <Widget>[
                                              Container(

                                                child: Image.asset("img/toutiao.png",fit: BoxFit.fill,width: ScreenUtil().setWidth(70),),
                                              ),
                                              Container(
                                                color: Color(0xffebebeb),
                                                width: ScreenUtil().setWidth(335),
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 5),
                                                  height: ScreenUtil().setHeight(35),
                                                  child: Swiper(
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
                                                            Text(formatNum(zhongjiang[index]["award_money"], 1).toString(),style: TextStyle(color: Colors.red),),
                                                            Text("元",style: TextStyle(color: Color(0xff575757)))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 7),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: 5, right: 5),
                                                height: ScreenUtil().setHeight(25),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(width: 3, color: Colors.red))),
                                               ),
                                              Text("热门红单")
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 7),
                                         decoration: index==1? BoxDecoration(border: Border(bottom: BorderSide(color: Colors.red,width: 2))):null,
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                index = 1;
                                              });
                                              getList(1);
                                            },
                                            child: Text("金额"),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 7),
                                          decoration: index==2? BoxDecoration(border: Border(bottom: BorderSide(color: Colors.red,width: 2))):null,
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                index = 2;
                                              });
                                              getList(2);
                                            },
                                            child: Text("人气"),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 7),
                                          decoration: index==3? BoxDecoration(border: Border(bottom: BorderSide(color: Colors.red,width: 2))):null,
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                index = 3;
                                              });
                                              getList(3);
                                            },
                                            child: Text("命中"),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 7),
                                          decoration: index==4? BoxDecoration(border: Border(bottom: BorderSide(color: Colors.red,width: 2))):null,
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                index = 4;
                                              });
                                              getList(4);
                                            },
                                            child: Text("关注"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(height: 10,),
                                  Column(
                                    children: getOrder(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          loadMore: ()async{
                            setState(() {
                              page++;
                            });
                            getMore();
                          },
                        ),
                      ) ;
                  }
                  return null;
                }
            )
        ),
      ),
    );
  }
  List getOrder(){

    return list.asMap().keys.map((e){
      return Container(
        margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        JumpAnimation().jump(Sender(uid: list[e]["uid"],), context);
                      },
                      child: ClipOval(
                          child: Image.network(
                            list[e]["avatar"],
                            fit: BoxFit.fill,
                            width: ScreenUtil().setWidth(45),
                            height: ScreenUtil().setWidth(45),
                          )),
                    ),
                    Text(list[e]["nickname"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                          decoration: BoxDecoration(color: Colors.red),
                          child: Text(list[e]["lian_hong"].toString()+"连红",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 0.2)),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                          child: Text(list[e]["all_count"].toString()+"中"+list[e]["win_count"].toString(),style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.bold),),
                        ),
                        list[e]["flag"]=="ball"?Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 0.2)),
                          padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                          child: Text("保"+list[e]["min_pl"].toString(),style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.bold),),
                        ):Container(

                        )
                      ],
                    )


                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("胜率 : "),
                    Text(list[e]["sl"].toString(),style: TextStyle(color: Colors.red),)
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(list[e]["plan_title"].toString()!=""?list[e]["plan_title"].toString():"跟我一起中大奖"),
            ),
            Divider(
              height: 25,
            ),
             Container(
               width: double.maxFinite,
               margin: EdgeInsets.only(top: 5),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Container(
                     width: 260,
                     child: Row(

                       mainAxisAlignment: MainAxisAlignment.spaceBetween,

                       children: <Widget>[
                         Column(
                           children: <Widget>[
                             Text("类型"),
                             Text(list[e]["flag"]=="pl"?"排列三":list[e]["type"]=="f"?"竞彩足球":"竞彩篮球",style: TextStyle(color: Colors.red),),
                           ],
                         ),
                         SizedBox(
                           width: 0.2,
                           height: 20,
                           child: DecoratedBox(
                             decoration: BoxDecoration(color: Colors.grey),
                           ),
                         ),
                         Column(
                           children: <Widget>[
                             Text("自购金额"),
                             Text(list[e]["amount"],style: TextStyle(color: Colors.red),),                           ],
                         ),
                         SizedBox(
                           width: 0.2,
                           height: 20,
                           child: DecoratedBox(
                             decoration: BoxDecoration(color: Colors.grey),
                           ),
                         ),
                         Column(
                           children: <Widget>[
                             Text("单倍金额"),
                             Text((list[e]["num"]*2).toString(),style: TextStyle(color: Colors.red),),                           ],
                         ),
                       ],
                     ),
                   ),
                   Container(


                     margin: EdgeInsets.only(left: 5),
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(80),
                     child: RaisedButton(
                       color: Colors.deepOrange,
                       onPressed: () {
                         if(list[e]["flag"] == "pl"){
                           JumpAnimation().jump( plflowdetail(list[e]), context);
                         }else{
                           JumpAnimation().jump( flowdetail(list[e]), context);
                         }

                       },
                       child: Text('跟单',style: TextStyle(fontSize: 12.0,color: Colors.white),),
                       ///圆角
                       shape: RoundedRectangleBorder(
                           side: BorderSide.none,
                           borderRadius: BorderRadius.all(Radius.circular(15))
                       ),
                     )
                     ,
                   )
                 ],
               ),
             ),
            Container(
              margin:EdgeInsets.only(top: 5),
              alignment: Alignment.bottomRight,
              width: double.infinity,
              child: Text("截止:"+list[e]["dtime"]),
            ),
             Divider(
               height: 25,
             ),

          ],
        ),
      );
    }).toList();
  }
  getZhongJiang(){
    String str = "";
    String type = "";
    zhongjiang.forEach((element) {
      if(element["type"] == "f"){
        type = "竞彩足球";
      }else{
        type = "竞彩篮球";
      }
      str+= "恭喜 " +element["nickname"]+" "+"喜中"+type+element["award_money"].toString()+"元";
      str += "                      ";
    });
    return str;
  }
  String formatNum(num num,int postion){
    if(num ==0){
      return "0";
    }
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }else{
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }
  }
}
