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

class exchange extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return exchange_();
  }
}

class exchange_ extends State<exchange> {
  double now_money = 0;
  String cash_money = "";
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    getUserInfo();
  }
  getUserInfo() async{
    ResultData res = await HttpManager.getInstance().get("userInfo",withLoading: false);
    setState(() {
      now_money = double.parse(res.data["award_amount"])>0?double.parse(res.data["award_amount"]):0;
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
          title: Text("账户划转",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
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
                              cash_money = e;
                            });
                          },
                          controller: TextEditingController.fromValue(

                              TextEditingValue(

                                  text:
                                  '${this.cash_money == null ? "" : this.cash_money}',
                                  selection: TextSelection.fromPosition(

                                      TextPosition(

                                          affinity: TextAffinity.downstream,
                                          offset: '${this.cash_money}'.length)))),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "请输入划转金额",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5,top: 10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        cash_money = now_money.toString();
                      });
                    },
                    child: Text("全部划转",style: TextStyle(color: Colors.blue),),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, top: 15, right: 5),
                  child: Text("当前可划转金额:  "+now_money.toString()),
                )

              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 25, right: 5),
              child: GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () async {
                    if (cash_money == null || cash_money =="" ) {
                      Toast.toast(context, msg: "请输入正确划转金额!");
                      return;
                    }else if(double.parse(cash_money) <=0){
                      Toast.toast(context, msg: "请输入正确划转金额!");
                      return;
                    }else if(double.parse(cash_money) > now_money){
                      Toast.toast(context, msg: "可划转余额不足!");
                      return;
                    }

                    ResultData result = await HttpManager.getInstance().post(
                        "user/exchange",
                        params: {"money":cash_money},
                        withLoading: true);
                    if (result.code == 200) {
                      Toast.toast(context, msg: "划转成功");
                      setState(() {
                       now_money -= double.parse(cash_money);
                      });
                    } else {
                      Toast.toast(context, msg: result.msg);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    decoration:
                        BoxDecoration(color: Color(0xfffa2020), boxShadow: []),
                    child: Text(
                      "确认",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
