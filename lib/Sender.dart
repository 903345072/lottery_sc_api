import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/pages/flowdetail.dart';
import 'package:flutterapp2/pages/orderdetail.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/wiget/flowlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Sender extends StatefulWidget {
  int uid;
  Sender({this.uid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<Sender> {
  List<String> containers = ["近期关注","历史红单"];
  int page = 0;

 String img = "http://kaifa.crmeb.net/uploads/attach/2019/08/20190807/723adbdd4e49a0f9394dfc700ab5dba3.png";
 String nickname = "--";
 String target = "1";
 String sl = "0";
 List data = [];
 String order_num = "10";
 int fans_count;
 int win_rate;
  List data1 = [];
  double fans_award;
  List near_five;
 bool is_flow = false;
  PageController controller;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new PageController(initialPage: this.page);
    getSender();
  }

  getSender() async {
    ResultData res = await HttpManager.getInstance().get("getSender",params: {"uid":widget.uid},withLoading: false);

   setState(() {
     data = res.data["data"];
     sl = res.data["sl"].toString();
     target = res.data["target"].toString();
     img = res.data["avatar"];
     nickname = res.data["nickname"];
     order_num = res.data["order_num"].toString();
     is_flow = res.data["is_flow"];
      fans_count = res.data["fans_count"];
      win_rate = res.data["win_rate"];
      data1  = res.data["data1"];
     fans_award = res.data["fans_award"]>0?res.data["fans_award"]:0.0;
     near_five =res.data["near_five"].length>0? res.data["near_five"]:[];
   });

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return MediaQuery.removePadding(removeTop: true,context:context,child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 190,left: 10,right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 5,
                      height: 15,
                      color: Colors.red,
                    ),
                    Text("近10单战绩")
                  ],
                ),
                Divider(),
                Container(
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[


                      Column(
                        children: <Widget>[
                          Text(win_rate.toString()+"%",style: TextStyle(color: Colors.red),),
                          Text("盈利率")
                        ],
                      ),
                      SizedBox(
                        width: 0.5,
                        height: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey),
                        ),
                      ),

                      Column(
                        children: <Widget>[
                          Text(order_num+"中"+target,style: TextStyle(color: Colors.red),),
                          Text("命中率")
                        ],
                      ),
                      SizedBox(
                        width: 0.5,
                        height: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(formatNum(fans_award, 1),style: TextStyle(color: Colors.red),),
                          Text("推荐中奖(元)")
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 5,
                      height: 15,
                      color: Colors.red,
                    ),
                    Text("近五期走势"),
                    near_five != null? Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Wrap(
                        spacing: 20,
                        children: near_five.asMap().keys.map((e){
                          return Container(
                            alignment:Alignment.center,
                            padding:EdgeInsets.only(top: 1,bottom: 2,left: 3,right: 3),
                            decoration:BoxDecoration(color: near_five[e]["state"]==2?Colors.red:Colors.grey,borderRadius: BorderRadius.all(Radius.circular(3))),
                            child: Text(near_five[e]["state"]==2?"红":"未",style: TextStyle(color: Colors.white),),
                          );
                        }).toList(),
                      ),
                    ):Container(),

                  ],
                ),
              ],
            ),
          ),
          Container(

            width: double.infinity,

            child: Stack(
              children: <Widget>[
                Image.asset("img/money.jpg",fit: BoxFit.fill,width: double.infinity,height: 170,),
               Positioned(

                 bottom: 20,
                left: 15,
                child:   Container(
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,

                    children: <Widget>[
                      ClipOval(
                          child: Image.network(
                            img,
                            fit: BoxFit.fill,
                            width: ScreenUtil().setWidth(75),
                            height: ScreenUtil().setWidth(75),
                          )),
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 5,
                        children: <Widget>[
                          Text(nickname),
                          Text("粉丝:"+fans_count.toString())
                        ],
                      ),
                    ],
                  ),
                ),
              )
              ],
            ),
          ),



          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView(
                    physics: new NeverScrollableScrollPhysics(),
                    controller: controller,
                    onPageChanged: onPageChanged,
                    children: <Widget>[
                      flowlist().get(data, context),
                      flowlist().get(data1, context),

                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(top: 30,left: 15),
              child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
            ),
          ),
          Positioned(
            right: 0,
            top: 136,
            child: GestureDetector(
              onTap: () async {
                ResultData res = await HttpManager.getInstance().get("flow",params: {"uid":widget.uid},withLoading: false);
                setState(() {
                  is_flow = is_flow?false:true;
                  fans_count = is_flow?fans_count+1:fans_count-1;
                });
              },
              child: !is_flow? Container(
                padding: EdgeInsets.only(left: 6,right: 5,top: 3,bottom: 3),
                decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)) ),
                child: Text("+ 关注",style: TextStyle(color: Colors.red),),
              ):Container(
                padding: EdgeInsets.only(left: 6,right: 5,top: 3,bottom: 3),
                decoration: BoxDecoration(borderRadius:BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),border: Border.all(width: 0.4,color: Colors.white) ),
                child: Text("已关注",style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 310),
            child: Column(
              children: <Widget>[
                Container(

                  color: Colors.white,
                  child: Row(
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
                          controller.jumpToPage(this.page);
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
                ),

              ],
            ),
          ),



        ],
      ),
    ),);
  }
  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
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
