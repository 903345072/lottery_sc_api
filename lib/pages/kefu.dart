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
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';
import 'package:flutter/services.dart';

class kefu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<kefu> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  String version;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    getVersion();
  }
getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  setState(() {
    version = packageInfo.version;
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
          title: Text("客服",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 70),
              child: Center(
                child: Wrap(

                  direction: Axis.vertical,
                  alignment: WrapAlignment.start,
                  spacing: 23,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                       Future res = Clipboard.setData(ClipboardData(text: '1195268199'));
                       res.whenComplete(() =>Toast.toast(context,msg: "复制成功"));
                      },
                      child: Container(

                        child:Image.asset("img/kefu.jpg",fit: BoxFit.fill,width: 350,),

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                      child: Wrap(
                        direction: Axis.vertical,
                        spacing: 25,
                        children: <Widget>[
                          Wrap(
                            spacing: 15,
                            crossAxisAlignment:WrapCrossAlignment.center,
                            children: <Widget>[
                              Text("在线时间:"),
                              Text("13:00~22:00"),

                            ],
                          ),
                          Wrap(

                            spacing: 15,
                            crossAxisAlignment:WrapCrossAlignment.center,
                            children: <Widget>[
                              Text("当前版本:"),
                              Text(version),

                            ],
                          ),
                          Wrap(

                            spacing: 15,
                            crossAxisAlignment:WrapCrossAlignment.center,
                            children: <Widget>[
                              Text("版权所有:"),
                              Text("精彩世界"),

                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
