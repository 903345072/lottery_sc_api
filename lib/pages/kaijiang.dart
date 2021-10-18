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
import 'package:flutterapp2/pages/lanqiukaijiang.dart';
import 'package:flutterapp2/pages/plkaijiang.dart';
import 'package:flutterapp2/pages/zuqiukaijiang.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class kaijiang extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<kaijiang> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  Map foot = {} ;
  Map basket= {} ;
  Map pl= {} ;
  Map num_to_cn = {"1":"一","2":"二","3":"三","4":"四","5":"五","6":"六","7":"末"};
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    getGameInfo();
  }
getGameInfo() async {
  ResultData res = await HttpManager.getInstance().get("getGameInfo",withLoading: false);
  setState(() {
    foot = res.data["foot"];
    basket = res.data["basket"];
    pl = res.data["pl"];
  });
}
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(
          leading: Text(''),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("开奖公告",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                JumpAnimation().jump(zuqiukaijiang(), context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10,right: 10),
                child: Wrap(


                  alignment: WrapAlignment.start,
                  spacing: 20,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(

                          margin: EdgeInsets.only(left: 15,top: 15),
                          child: Wrap(
                            spacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: <Widget>[
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 15,
                                children: <Widget>[
                                  Text("竞彩足球",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                  foot.length>0?Text("比赛日："+ foot["dtime"].toString().substring(0,10)+ "(周"+foot["week"].toString()+")"):Text("--")
                                ],
                              ),
                              Container(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(300),
                                      height: ScreenUtil().setHeight(50),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(25)) ),
                                      child: foot.length>0?Text(foot["h_name"]  +"  "+  foot["bf"]+ "  "+  foot["a_name"]):Text("--"),
                                    ),
                                    Positioned(
                                      left: -3,
                                      top: -4,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusDirectional.circular(21)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.asset(
                                          "img/football.png",
                                          fit: BoxFit.fill,
                                          width: ScreenUtil().setWidth(42),
                                          height: ScreenUtil().setWidth(42),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    )



                  ],
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: (){
                JumpAnimation().jump(lanqiukaijiang(), context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10,right: 10),
                child: Wrap(


                  alignment: WrapAlignment.start,
                  spacing: 20,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(

                          margin: EdgeInsets.only(left: 15,top: 15),
                          child: Wrap(
                            spacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: <Widget>[
                              Wrap(

                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 15,
                                children: <Widget>[
                                  Text("竞彩篮球",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                  foot.length>0? Text("比赛日："+ foot["dtime"].toString().substring(0,10)+ "(周"+foot["week"].toString()+")"):Text("--")
                                ],
                              ),
                              Container(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(300),
                                      height: ScreenUtil().setHeight(50),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.orangeAccent,borderRadius: BorderRadius.all(Radius.circular(25)) ),
                                      child: basket.length>0?Text(basket["a_name"]  +"  "+  basket["bf"]+ "  "+  basket["h_name"]):Text("--"),
                                    ),
                                    Positioned(
                                      left: -3,
                                      top: -4,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusDirectional.circular(21)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.asset(
                                          "img/basketball.png",
                                          fit: BoxFit.fill,
                                          width: ScreenUtil().setWidth(42),
                                          height: ScreenUtil().setWidth(42),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    )



                  ],
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: (){
                JumpAnimation().jump(plkaijiang(), context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10,right: 10),
                child: Wrap(


                  alignment: WrapAlignment.start,
                  spacing: 20,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(

                          margin: EdgeInsets.only(left: 15,top: 15),
                          child: Wrap(
                            spacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: <Widget>[
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 15,
                                children: <Widget>[
                                  Text("排列三",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                  pl.length>0? Text("开奖："+ pl["dtime"].toString().substring(0,10)+ "(周"+pl["week"].toString()+")"):Text("--")
                                ],
                              ),
                              Container(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenUtil().setWidth(300),
                                      height: ScreenUtil().setHeight(50),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(25)) ),
                                      child:pl.length>0? Container(

                                        child: Wrap(
                                          spacing: 13,
                                          children: <Widget>[
                                            ClipOval(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width:25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                  ),
                                                  child: Text(pl["value"][0].toString(),style: TextStyle(color: Colors.white),),
                                                )
                                            ),
                                            ClipOval(
                                                child: Container(

                                                  alignment: Alignment.center,
                                                  width:25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                  ),
                                                  child: Text(pl["value"][1].toString(),style: TextStyle(color: Colors.white),),
                                                )
                                            ),
                                            ClipOval(
                                                child: Container(

                                                  alignment: Alignment.center,
                                                  width:25,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                  ),
                                                  child: Text(pl["value"][2].toString(),style: TextStyle(color: Colors.white),),
                                                )
                                            )
                                          ],
                                        ),
                                      ):Container(),
                                    ),
                                    Positioned(
                                      left: -4,
                                      top: -4,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusDirectional.circular(21)),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.asset(
                                          "img/pl3.jpg",
                                          fit: BoxFit.fill,
                                          width: ScreenUtil().setWidth(42),
                                          height: ScreenUtil().setWidth(42),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    )



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
