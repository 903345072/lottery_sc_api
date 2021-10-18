import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/config/config.dart';

class basketdxf extends StatefulWidget {

  Function callBack;
  Map games;
  String e2;
  int e;
  String zd_name;
  String kd_name;
  List dxf;
  List p_status;
  List p_goal;
  basketdxf(
      {Key key,
      this.callBack,
      this.games,
      this.e2,
      this.e,
      this.zd_name,
      this.kd_name,
      this.dxf,
      this.p_status,
      this.p_goal
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildState();
  }
}

class _ChildState extends State<basketdxf> {
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
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: <Widget>[
              Text(
                widget.kd_name+"(客)",
                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(35),
                    right: ScreenUtil().setWidth(35)),
                child: Text(
                  widget.p_goal[3],
                  style: TextStyle(fontSize: ScreenUtil().setSp(16),color: Colors.red),
                ),
              ),
              Text(
                widget.zd_name+"(主)",
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
                    child: Row(
                      children: getsfList(),
                    ),
                  ),
                ],
              ),

            ],
          ),
        )
      ],
    );
  }


getsfList(){

  String status = widget.p_status[3];
  if(status == "0"){
    return [Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey)),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(320),
      height: ScreenUtil().setHeight(40),
      child: Text("暂停销售",),
    )];
  }

  return [GestureDetector(
    onTap: () {
      Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
      String mid = widget.games[widget.e2][widget.e]["check_info"][4]["id"].toString();
      String id = widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][0]["id"].toString();
      if(checks[mid] != null){
        List attr = checks[mid];
        if(widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][0]["color"] == "co"){

            attr.add(id+"-"+widget.dxf[0]);


        }else{
          attr.remove(id+"-"+widget.dxf[0]);
        }
        checks[mid] = attr;
      }else{
        List attr = [];
        attr.add(id+"-"+widget.dxf[0]);
        checks[mid] = attr;
      }
      widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
      setState(() {
        widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][0]
        ["color"] = widget.games[widget.e2][widget.e]["check_info"][4]
        ["bet_way"][0]["color"] ==
            "co"
            ? "red"
            : "co";
      });
      widget.callBack(widget.games);

    },
    child: Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
          color: widget.games[widget.e2][widget.e]["check_info"][4]
          ["bet_way"][0]["color"] ==
              "co"
              ? Colors.white
              : Colors.red,
          border: Border(
              right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
              bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            "大分",
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][4]
                ["bet_way"][0]["color"] ==
                    "co"
                    ? Colors.grey
                    : Colors.white),
          ),
          Text(
            widget.dxf[0],
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][4]
                ["bet_way"][0]["color"] ==
                    "co"
                    ? Colors.grey
                    : Colors.white),
          )
        ],
      ),
    ),
  ),GestureDetector(
    onTap: () {
      Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
      String mid = widget.games[widget.e2][widget.e]["check_info"][4]["id"].toString();
      String id = widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][1]["id"].toString();
      if(checks[mid] != null){
        List attr = checks[mid];
        if(widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][1]["color"] == "co"){

            attr.add(id+"-"+widget.dxf[1]);


        }else{
          attr.remove(id+"-"+widget.dxf[1]);
        }
        checks[mid] = attr;
      }else{
        List attr = [];
        attr.add(id+"-"+widget.dxf[1]);
        checks[mid] = attr;
      }
      widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
      setState(() {
        widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][1]
        ["color"] = widget.games[widget.e2][widget.e]["check_info"][4]
        ["bet_way"][1]["color"] ==
            "co"
            ? "red"
            : "co";
      });
      widget.callBack(widget.games);

    },
    child: Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
          color: widget.games[widget.e2][widget.e]["check_info"][4]
          ["bet_way"][1]["color"] ==
              "co"
              ? Colors.white
              : Colors.red,
          border: Border(
              right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
              bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            "小分",
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][4]
                ["bet_way"][1]["color"] ==
                    "co"
                    ? Colors.grey
                    : Colors.white),
          ),
          Text(
            widget.dxf[1],
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][4]
                ["bet_way"][1]["color"] ==
                    "co"
                    ? Colors.grey
                    : Colors.white),
          )
        ],
      ),
    ),
  )];
}
}
