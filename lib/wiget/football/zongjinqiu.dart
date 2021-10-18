import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/config/config.dart';

class zongjinqiu extends StatefulWidget {
  Function callBack;
  Map games;
  String e2;
  int e;
  String zd_name;
  String kd_name;

  List p_status;

  List ttg_odds;
  zongjinqiu(
      {Key key,
      this.callBack,
      this.games,
      this.e2,
      this.e,
      this.zd_name,
      this.kd_name,
      this.ttg_odds,
      this.p_status,

      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildState();
  }
}

class _ChildState extends State<zongjinqiu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    return Column(

      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
          child: Row(
            children: <Widget>[
              Text(
                widget.zd_name,
                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(35),
                    right: ScreenUtil().setWidth(35)),
                child: Text(
                  "VS",
                  style: TextStyle(color: Colors.black ,fontSize: ScreenUtil().setSp(16)),
                ),
              ),
              Text(
                widget.kd_name,
                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[

                  Container(
                    width: ScreenUtil()
                        .setWidth(325),
                    child: Wrap(
                      children:
                      getTotalList(),
                    ),
                  )
                ],
              ),

            ],
          ),
        )
      ],
    );
  }
  getTotalList() {
    String status = widget.p_status[3];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(120),
        height: ScreenUtil().setHeight(120),
        child: Text("暂停销售",),
      )];
    }
    List total_ = config.getTotal();
    return widget.ttg_odds.asMap().keys.map((e) {
      return GestureDetector(
        onTap: (){
          Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
          String mid = widget.games[widget.e2][widget.e]["check_info"][3]["id"].toString();
          String id = widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"][e]["id"].toString();
          if(checks[mid] != null){
            List attr = checks[mid];
            if(widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"][e]["color"] == "co"){
                attr.add(id+"-"+widget.ttg_odds[e]);

            }else{
              attr.remove(id+"-"+widget.ttg_odds[e]);
            }
            checks[mid] = attr;
          }else{
            List attr = [];
            attr.add(id+"-"+widget.ttg_odds[e]);
            checks[mid] = attr;
          }
          widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
          setState(() {
            widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"][e]
            ["color"] = widget.games[widget.e2][widget.e]["check_info"][3]
            ["bet_way"][e]["color"] ==
                "co"
                ? "red"
                : "co";
          });
          widget.callBack(widget.games);
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.games[widget.e2][widget.e]["check_info"][3]
              ["bet_way"][e]["color"] ==
                  "co"
                  ? Color(0xfffff5f8)
                  : Colors.red,
              border: Border(
                  top: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  left: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5,bottom: 5,right: 8),

                decoration: BoxDecoration(border: Border(
                    right: BorderSide(width: 1, color: Color(0xfff2f2f2)),)
                ),
                margin: EdgeInsets.only(bottom: 2),
                child: Text(total_[e] ,style: TextStyle(color: widget.games[widget.e2][widget.e]["check_info"][3]
                ["bet_way"][e]["color"] ==
                    "co"
                    ? Colors.red
                    : Colors.white),),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  widget.ttg_odds[e],
                  style: TextStyle(
                      color: widget.games[widget.e2][widget.e]["check_info"][3]
                      ["bet_way"][e]["color"] ==
                          "co"
                          ? Colors.grey
                          : Colors.white, fontSize: ScreenUtil().setSp(12)),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }



}
