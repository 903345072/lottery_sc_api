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
import 'package:flutterapp2/pages/kaijiangdetail.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';
import 'package:url_launcher/url_launcher.dart';


class plkaijiang extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<plkaijiang> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  List list =[];
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
     ResultData res = await HttpManager.getInstance().get("getPlOpenGame",withLoading: false);

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
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                JumpAnimation().jump(kaijiangdetail(), context);
              },
              child: Container(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.show_chart),
              )
            )

          ],
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("排列3开奖详情",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            ListView(
            children: <Widget>[
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

    return list.asMap().keys.map((e){
      return GestureDetector(
        onTap: () async {
          String qh = list[e]["qh"];
          await launch("https://pdf.sporttery.cn/28200/$qh/$qh.pdf");
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(width: 0.2,color: Colors.grey))),
          child:Wrap(
            runSpacing: 15,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("第"+  list[e]["qh"]+"期"),
                  Text(list[e]["dtime"]+ "周"+list[e]["week"]),
                ],
              ),
              Wrap(
                spacing: 10,
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      width:25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow:( [
                            BoxShadow(
                                color: Colors.blue,
                                offset: Offset(30.0, 30.0), //阴影xy轴偏移量
                                blurRadius: 30.0, //阴影模糊程度
                                spreadRadius: 15.0 //阴影扩散程度
                            )
                          ]),
                        ),
                        child: Text(list[e]["value"][0].toString(),style: TextStyle(color: Colors.white,),),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Container(
                      width:25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow:( [
                            BoxShadow(
                                color: Colors.blue,
                                offset: Offset(30.0, 30.0), //阴影xy轴偏移量
                                blurRadius: 30.0, //阴影模糊程度
                                spreadRadius: 15.0 //阴影扩散程度
                            )
                          ]),
                        ),
                        child: Text(list[e]["value"][1].toString(),style: TextStyle(color: Colors.white,),),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Container(
                      width:25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow:( [
                            BoxShadow(
                                color: Colors.blue,
                                offset: Offset(30.0, 30.0), //阴影xy轴偏移量
                                blurRadius: 30.0, //阴影模糊程度
                                spreadRadius: 15.0 //阴影扩散程度
                            )
                          ]),
                        ),
                        child: Text(list[e]["value"][2].toString(),style: TextStyle(color: Colors.white,),),
                      ),
                    ),
                  )
                ],
              )
            ],
          ) ,
        ),
      );
    }).toList();
  }
}
