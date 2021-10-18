import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/pages/IndexBack.dart';

import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/basketball.dart';
import 'package:flutterapp2/pages/football.dart';
import 'package:flutterapp2/pages/orderdetail.dart';
import 'package:flutterapp2/pages/pailie/plorderdetail.dart';

import 'package:flutterapp2/utils/JumpAnimation.dart';

import 'package:flutterapp2/utils/Toast.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class success extends StatefulWidget {
  Map data;
  String type;
  success(this.data,this.type);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<success> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("付款成功",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(

                child: ClipOval(
                    child: Image.asset(
                      "img/success.jpeg",
                      fit: BoxFit.fill,
                      width: ScreenUtil().setWidth(120),
                      height: ScreenUtil().setWidth(120),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30,top: 10),
              child: Container(
                child: Wrap(

                  direction: Axis.vertical,
                  alignment: WrapAlignment.start,
                  spacing: 40,
                  children: <Widget>[
                    Text("您已成功付款,敬请关注方案详情",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    Wrap(
                      crossAxisAlignment:WrapCrossAlignment.center,
                      children: <Widget>[
                        Text("金额消费:  "),
                        Text(widget.data["use_money"].toString(),style: TextStyle(color: Colors.red),),
                        Text("  元")

                      ],
                    ),
                    Wrap(
                      crossAxisAlignment:WrapCrossAlignment.center,
                      children: <Widget>[
                        Text("剩余余额:  "),
                        Text(widget.data["now_money"].toString(),style: TextStyle(color: Colors.red),),
                        Text("  元")

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 5),
              padding: EdgeInsets.only(left: 30,right: 30),
              child: MaterialButton(
                color: Color(0xfffa2020),
                onPressed: (){

                  JumpAnimation().jump(widget.type=="pl"?plorderdetail(int.parse(widget.data["id"]),widget.data["mode"],widget.type):orderdetail(int.parse(widget.data["id"]),widget.data["mode"],widget.type), context);
                },
                child: Text("查看投注详情",style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.only(left: 30,right: 30),
              child: MaterialButton(
                color: Color(0xfffa2020),
                onPressed: (){
                     Navigator.pop(context);
                },
                child: Text("继续投注",style: TextStyle(color: Colors.white),),
              ),
            ),
            Container(

              padding: EdgeInsets.only(left: 30,right: 30),
              child: MaterialButton(
                color: Color(0xfffa2020),
                onPressed: (){
                  JumpAnimation().jump(IndexBack(), context);
                },
                child: Text("返回首页",style: TextStyle(color: Colors.white),),
              ),
            )

          ],
        ),
      ),
    );
  }
}
