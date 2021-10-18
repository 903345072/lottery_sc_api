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
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class applyDaShen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<applyDaShen> {
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
  applyDaShen_() async{
    ResultData res = await HttpManager.getInstance().post("applydashen");
    if(res.code != 200){
      Toast.toast(context,msg: res.data["msg"]);
    }else{
      Toast.toast(context,msg: "申请成功");
    }
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
          title: Text("大神",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Image.asset("img/sw3.jpg",fit: BoxFit.fill),
            Stack(
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(left: 5,top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("申请条件:",style: TextStyle(fontSize: 16),),
                      Text("1、 平台累计购买3单以上",style: TextStyle(fontSize: 16),),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("备注:"),
                            Text("·申请提交后，工作人员会在1-3个工作日内进行审核;"),
                            Text("·跟单大厅禁止同一场比赛在两单内出现，多次违规将取消发单权限;"),
                            Text("·若有疑问，请联系QQ客服;"),
                          ],
                        ),
                      ),
                      Container(

                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(200)),
                        child: MaterialButton(
                          minWidth: ScreenUtil().setWidth(380),
                          color: Colors.red,
                          onPressed: (){
                            applyDaShen_();
                          },
                          child: Text("立即申请",style: TextStyle(color: Colors.white),),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}
