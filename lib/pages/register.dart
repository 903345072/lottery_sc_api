import 'dart:async';
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
import 'package:flutterapp2/pages/Login.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/pages/agreement.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<register> {
  String phone;
  String pwd;
  String re_pwd;
  String nickname;
  String invite_code;
  String validate_code;
  String key = "";
  String buttonText = "获取验证码";
  bool enabled = true;

  Timer _timer;
  int _timeCount = 60;
  static TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = "";
    getKey();
  }
  @override
  void dispose(){
    this._timer.cancel();
  }
  getKey() async {
   ResultData res =  await HttpManager.getInstance().get("verify_code",withLoading: false);
   if(res.code == 200){
     setState(() {
       key = res.data["key"];
     });
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
          title: Text("手机号注册",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
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
                          keyboardType: TextInputType.number,
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
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "请输入手机号",
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
                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onChanged: (e) {
                            setState(() {
                              nickname = e;

                            });
                          },
                          controller: _controller,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "请输入昵称",
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
                    children: <Widget>[

                      Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged: (e) {
                            setState(() {
                              pwd = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                      '${this.pwd == null ? "" : this.pwd}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.pwd}'.length)))),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            hintText: "请输入密码",
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
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

                    children: <Widget>[

                      Expanded(
                        child: TextField(
                          obscureText: true,
                          onChanged: (e) {
                            setState(() {
                              re_pwd = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                  '${this.re_pwd == null ? "" : this.re_pwd}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.re_pwd}'.length)))),
                          decoration: InputDecoration(

                            hintText: "再次输入密码",

                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),

                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),

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

                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onChanged: (e) {
                            setState(() {
                              invite_code = e;
                            });
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text:
                                  '${this.invite_code == null ? "" : this.invite_code}',
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset: '${this.invite_code}'.length)))),
                          decoration: InputDecoration(

                            hintText: "请输入邀请码",

                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),

                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),

                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 25, right: 5),

                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[

                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (e) {
                                setState(() {
                                  validate_code = e;
                                });
                              },
                              controller: TextEditingController.fromValue(
                                  TextEditingValue(
                                      text:
                                      '${this.validate_code == null ? "" : this.validate_code}',
                                      selection: TextSelection.fromPosition(
                                          TextPosition(
                                              affinity: TextAffinity.downstream,
                                              offset: '${this.validate_code}'.length)))),
                              decoration: InputDecoration(


                                hintText: "请输入验证码",
                                hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 10),

                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        height: ScreenUtil().setHeight(50),
                        top: 0,
                        right: 0,
                        child: MaterialButton(

                          disabledColor: Colors.grey,
                          color: Colors.orange,
                          onPressed: enabled ? ontap : null,
                          splashColor: Colors.grey,
                          child: Text(buttonText,style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 25, right: 5),
              child: GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () async {
                    if (!checkExist(phone) ||
                        !checkExist(nickname) ||
                        !checkExist(pwd) ||
                        !checkExist(re_pwd) ||
                        !checkExist(invite_code) ||
                        !checkExist(validate_code)) {
                      Toast.toast(context, msg: "请输入完整信息");
                      return;
                    }
                    if(pwd != re_pwd){
                      Toast.toast(context, msg: "两次输入密码不一致!");
                    }
                    ResultData result = await HttpManager.getInstance().post(
                        "register",
                        params: {"password": pwd,"invite_code":invite_code,"account":phone,"captcha":validate_code,"nickname":nickname},
                        withLoading: true);
                    if (result.code == 200) {
                      Toast.toast(context, msg: "注册成功");
                      JumpAnimation().jump(Login(), context);
                    } else {
                      Toast.toast(context, msg: result.msg);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration:
                        BoxDecoration(color: Color(0xfffa2020), boxShadow: []),
                    child: Text(
                      "完成注册",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("注册即表示同意"),
                GestureDetector(
                  onTap: (){
                    JumpAnimation().jump(agreement(), context);
                  },
                  child: Text("《精彩世界软件用户注册协议》",style: TextStyle(color: Colors.pinkAccent),),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
  static bool checkExist(value) {
    if (value == null || value == "") {
      return false;
    }
    return true;
  }
  static bool isChinaPhoneLegal(String str) {

    return true;
  }
  void ontap() async{
    if(!checkExist(phone)){
      Toast.toast(context,msg: "请输入手机号");
      return ;
    }
    if(!isChinaPhoneLegal(phone) ){
      Toast.toast(context,msg: "请输入正确手机号");
      return;
    }
    ResultData res_ = await HttpManager.getInstance().post("register/verify",params: {"phone":phone,"type":"register","key":key});
    if(res_.code == 200){
      Toast.toast(context,msg: "发送成功");
     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) => {
        setState(() {
          if(_timeCount <= 0){
            setState(() {
              enabled = true;
            });
            buttonText = '重新获取';
            _timer.cancel();
            _timeCount = 60;
          }else {
            setState(() {
              enabled = false;
            });
            _timeCount -= 1;
            buttonText = "$_timeCount" + 's';
          }
        })
      });
    }else{
      Toast.toast(context,msg: res_.msg);
    }
  }
}
