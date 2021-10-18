import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/mycash.dart';
import 'package:flutterapp2/pages/myorder.dart';
import 'package:flutterapp2/pages/pailie/direct.dart';
import 'package:flutterapp2/pages/pailie/zu3.dart';
import 'package:flutterapp2/pages/pailie/zu6.dart';
import 'package:flutterapp2/utils/request.dart';

import 'ChildItemView.dart';
class pailie extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new hangqing_();
  }

}
class hangqing_ extends State<pailie>{
  List<String> containers = ["直选","组三","组六"];
  int page = 0;
  List<TextStyle> ts = [TextStyle()];
  @override
  void initState() {
    super.initState();
    controller = new PageController(initialPage: this.page);
  }
  TextStyle checked_text_style =
  TextStyle(color: Color(0xfffa2020));
  TextStyle unchecked_text_style = null;
  BoxDecoration checked_border_style = BoxDecoration(
      border: Border(
          top: BorderSide(
            // 设置单侧边框的样式
              color: Color(0xfffa2020),
              width: 1.5,
              style: BorderStyle.solid)));
  BoxDecoration unchecked_border_style = null;
  PageController controller;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("排列三",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        backgroundColor: Color(0xfffa2020),
      ),

      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: containers.asMap().keys.map((e) {
                TextStyle cur_ts;
                BoxDecoration cur_bd;
                if(e == page){
                  cur_ts = checked_text_style;
                  cur_bd = checked_border_style;
                }else{
                  cur_ts = unchecked_text_style;
                  cur_bd = unchecked_border_style;
                }
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      this.page = e;
                    });
                    controller.jumpToPage(this.page);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 7,right: 5),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:EdgeInsets.all(5),
                          child: Text(containers[e],style: cur_ts,),),
                        Container(
                          margin: EdgeInsets.only(top: 7),
                          decoration: cur_bd,width: 60,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: onPageChanged,
              children: <Widget>[
                direct(),
                zu3(),
                zu6(),
              ],
            ),
          )
        ],
      ),
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}