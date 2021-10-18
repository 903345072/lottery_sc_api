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
import 'package:flutterapp2/pages/applyDaShen.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class zuqiukaijiang extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<zuqiukaijiang> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  Map list = {};
  Map num_to_cn = {"1":"一","2":"二","3":"三","4":"四","5":"五","6":"六","7":"末"};

  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    getFootBall();
  }
   getFootBall() async {
     ResultData res = await HttpManager.getInstance().get("getFootOpenGame",withLoading: false);

     setState(() {
       list =res.data[0];
     });
   }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(

          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("竞彩足球开奖详情",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 5),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("赛事",style: TextStyle(color: Colors.red,fontSize: 15),),
                    Text("对阵",style: TextStyle(color: Colors.red,fontSize: 15),),
                    Text("赛果",style: TextStyle(color: Colors.red,fontSize: 15),),
                  ],
                ),
              ),
              Column(
                children: getList(),
              ),
            ],
          ),
            
          ],
        ),
      ),
    );
  }

  List<Widget> getList(){

    return list.keys.map((e){
      List l = list[e];
      return Container(
        decoration: BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(width: 0.2,color: Colors.grey))),

        child:ExpansionTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(e),
                    Text("(周"+num_to_cn[list[e][0]["num"].toString().substring(0,1)]+")")
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(list[e].length.toString()),
                  Text("场比赛已开奖"),
                ],
              )
            ],
          ),
          children: l.asMap().keys.map((e1){
            return Container(
              decoration: BoxDecoration( color: Color(0xfffff5f8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(

                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1),right: BorderSide(color: Color(0xfff2f2f2),width: 1))),
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(139),
                    height: ScreenUtil().setHeight(180),
                    child: Wrap(
                      spacing: 3,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: <Widget>[
                        Text(l[e1]["l_cn_a"]),
                        Text("周"+num_to_cn[l[e1]["num"].toString().substring(0,1)]+l[e1]["num"].toString().substring(1,4)),
                        Text(l[e1]["dtime"].toString().substring(11,16))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1),right: BorderSide(color: Color(0xfff2f2f2),width: 1))),

                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(139),
                    height: ScreenUtil().setHeight(180),
                    child: Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: <Widget>[
                        Text(l[e1]["h_cn_a"]),
                        Wrap(
                          spacing: 15,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Text(l[e1]["qcbf"],style: TextStyle(color: Colors.red),),
                            Text("半"+l[e1]["bcbf"])
                          ],
                        ),
                        Text(l[e1]["a_cn_a"]),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1))),

                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(139),

                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.vertical,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(36),
                          width: ScreenUtil().setWidth(139),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1))),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 25,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Text(l[e1]["g1"]["res"]),
                              Text(l[e1]["g1"]["pl"]),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(36),
                          width: ScreenUtil().setWidth(139),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1))),

                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 25,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Text(l[e1]["g2"]["res"]),
                              Text(l[e1]["g2"]["pl"]),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(36),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1))),
                          width: ScreenUtil().setWidth(139),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 25,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Text(l[e1]["g3"]["res"]),
                              Text(l[e1]["g3"]["pl"]),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(36),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1))),
                          width: ScreenUtil().setWidth(139),

                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 25,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Text(l[e1]["g4"]["res"]),
                              Text(l[e1]["g4"]["pl"]),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(36),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1))),
                          width: ScreenUtil().setWidth(139),

                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 25,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Text(l[e1]["g5"]["res"]),
                              Text(l[e1]["g5"]["pl"]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ) ,
      );
    }).toList();
  }
}
