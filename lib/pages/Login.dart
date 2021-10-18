import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';

import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexBack.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/pages/forgetPassword.dart';
import 'package:flutterapp2/pages/register.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<Login> {
  String phone;
  String password;
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
                    "登录",
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(20)),
                  ),
                ),
              ),
            ),
            preferredSize: Size(double.infinity, ScreenUtil().setHeight(60))),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 25, right: 5),

                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11)
                          ],
                          //限制长度],//只允许输入数字
                          onChanged: (e) {
                            setState(() {
                              phone = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                      '${this.phone == null ? "" : this.phone}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.phone}'.length)))),

                          //键盘类型，数字键盘

                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "手机号",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xffe3e3e3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 25, right: 5),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(

                          obscureText: true,
                          onChanged: (e) {
                            setState(() {
                              password = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                      '${this.password == null ? "" : this.password}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.password}'.length)))),
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "密码",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xffe3e3e3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 0, top: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: check,
                            activeColor: Colors.blue,
                            onChanged: (bool val) {
                              // val 是布尔值
                              this.setState(() {
                                this.check = !this.check;
                              });
                            },
                          ),
                          Text("记住密码")
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          JumpAnimation().jump(forgetPassword(), context);
                        },
                        child: Text("忘记密码",style: TextStyle(color: Colors.red),),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 25, right: 5),
              child: GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () async {
                    if (phone == null || password == null) {
                      Toast.toast(context, msg: "请输入完整信息");
                      return;
                    }

                    ResultData result = await HttpManager.getInstance().post(
                        "login",
                         params: {"account": phone, "password": password},
                         withLoading: true);

                    if (result.code == 200) {
                      String token = "Bearer "+result.data["token"];
                      TokenStore().setToken("token", token);
                      TokenStore().setToken("is_login", "1");
                      JumpAnimation().jump(IndexBack(), context);
                    } else{
                      Toast.toast(context, msg: result.msg);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    decoration:
                        BoxDecoration(color: Color(0xfffa2020), boxShadow: [
                    ]),
                    child: Text(
                      "登录",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(35)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("还没有精彩世界账号?"),
                  GestureDetector(
                    onTap: (){
                      JumpAnimation().jump(register(), context);
                    },
                    child: Text("立即注册",style: TextStyle(color: Colors.red),),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
