import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CommonWiget{
  Widget getTaiTou(String title){
    return Container(
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(width: 6, color: Color(0xffebebeb),))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 15),
            height: ScreenUtil().setHeight(25),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 3, color: Colors.red))),
          ),
          Text(title)
        ],
      ),
    );
  }

}