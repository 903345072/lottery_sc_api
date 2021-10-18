import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
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

class article extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
  int id = 0;
  int index ;
  article({this.id,this.index});
}

class Login_ extends State<article> {
  Future _future;
  int id;
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  FocusNode _commentFocus;
  String article = "";
  String title = "";
  String date = "";
  String count = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    _future = getArticle();
  }

 Future getArticle() async {
   ResultData res = await HttpManager.getInstance().get("article",params: {"id":widget.id},withLoading: false);
   setState(() {
     article = res.data["article"]["content"].toString();
     title = res.data["article"]["title"].toString();
     date = res.data["article"]["date"].toString();
     count = res.data["count"].toString();
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
          title: Text("资讯详情",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot){
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                          return  Container(
                            
                            margin: EdgeInsets.only(top: ScreenUtil().setHeight(380),left: ScreenUtil().setWidth(208)),
                              child: Text('加载中...'),
                            );

                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('网络请求出错'),
                              );
                            }
                            return Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: ScreenUtil().setSp(17),fontWeight: FontWeight.bold),),
                                      Container(
                                        margin: EdgeInsets.only(top: 15),
                                        child: Text(date,style: TextStyle(color: Colors.grey),),
                                      )
                                    ],
                                  ),
                                  Divider(color: Colors.grey),
                                  Container(
                                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(50)),
                                    child: Html(
                                      data: article,
                                    ),
                                  )
                                ],
                              ),
                            );
                        }
                        return null;
                      }
                  ),
                )

              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                height: ScreenUtil().setHeight(50),
                decoration: BoxDecoration(color: Colors.black87),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    GestureDetector(

                      onTap: (){
                        if(widget.index > 1){
                          widget.id += 1;
                          getArticle();
                          setState(() {
                            widget.index--;
                            if(widget.index == 0){
                              widget.index = 1;
                            }
                          });
                        }
                      },
                      child: Text("上一条",style: TextStyle(color: Colors.white),),
                    ),
                    Text(widget.index.toString()+"/"+count,style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: (){
                        if(widget.index < int.parse(count)){
                          widget.id -= 1;
                          getArticle();
                          setState(() {
                            widget.index++;
                          });
                        }
                      },
                      child: Text("下一条",style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
