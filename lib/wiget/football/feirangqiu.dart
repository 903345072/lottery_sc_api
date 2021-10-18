import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/config/config.dart';

class feirangqiu extends StatefulWidget {
  Function callBack;
  Map games;
  String e2;
  int e;
  String zd_name;
  String kd_name;
  List spf;
  List p_status;
  String p_goal;
  feirangqiu(
      {Key key,
      this.callBack,
      this.games,
      this.e2,
      this.e,
      this.zd_name,
      this.kd_name,
      this.spf,
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

class _ChildState extends State<feirangqiu> {
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
                    child: Row(
                      children: getrqList_(),
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
   getrqList_() {
    String status = widget.p_status[0];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(300),
        height: ScreenUtil().setHeight(40),
        child: Text("暂停销售",),
      )];
    }
    List frqspf_ = config.getFrq();
    return widget.spf.asMap().keys.map((e) {
      return GestureDetector(
        onTap: () {
          Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
          String mid = widget.games[widget.e2][widget.e]["check_info"][0]["id"].toString();
          String id = widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][e]["id"].toString();
          if(checks[mid] != null){
            List attr = checks[mid];
            if(widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][e]["color"] == "co"){

                attr.add(id+"-"+widget.spf[e]);


            }else{
              attr.remove(id+"-"+widget.spf[e]);
            }
            checks[mid] = attr;
          }else{
            List attr = [];
            attr.add(id+"-"+widget.spf[e]);
            checks[mid] = attr;
          }
          widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
          setState(() {
            widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][e]
                ["color"] = widget.games[widget.e2][widget.e]["check_info"][0]
                        ["bet_way"][e]["color"] ==
                    "co"
                ? "red"
                : "co";
          });
          widget.callBack(widget.games);
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(105),
          height: ScreenUtil().setHeight(40),
          decoration: BoxDecoration(
              color: widget.games[widget.e2][widget.e]["check_info"][0]
                          ["bet_way"][e]["color"] ==
                      "co"
                  ? Colors.white
                  : Colors.red,
              border: Border.all(width: 0.3, color: Colors.grey)),
          child: Text(
            frqspf_[e] + widget.spf[e],
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][0]
                            ["bet_way"][e]["color"] ==
                        "co"
                    ? Colors.grey
                    : Colors.white),
          ),
        ),
      );
    }).toList();
  }



}
