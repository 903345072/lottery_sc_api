import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/config/config.dart';

class mix extends StatefulWidget {
  Function callBack;

  Map games;
  String e2;
  int e;
  String zd_name;
  String kd_name;
  List spf;
  String p_goal;
  List rqspf;
  List crs_win;
  List ttg_odds;
  List half_odds;
  List p_status;

  mix(
      {Key key,
      this.callBack,
      this.games,
      this.e2,
      this.e,
      this.zd_name,
      this.kd_name,
      this.spf,
      this.rqspf,
      this.crs_win,
      this.ttg_odds,
      this.half_odds,
      this.p_goal,
      this.p_status,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildState();
  }
}

class _ChildState extends State<mix> {
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
                widget.zd_name,
                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(35),
                    right: ScreenUtil().setWidth(35)),
                child: Text(
                  "VS",
                  style: TextStyle(fontSize: ScreenUtil().setSp(16)),
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
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(20),
                          height: ScreenUtil().setHeight(40),
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Text(
                            "0",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          children: getFrqList_(),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(20),
                          height: ScreenUtil().setHeight(40),
                          decoration: BoxDecoration(color: Colors.orange),
                          child: Text(widget.p_goal,
                              style: TextStyle(color: Colors.white)),
                        ),
                        Row(
                          children: getrqList_(),
                        )
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, state) {
                            return Container(
                              child: Material(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                child: Center(
                                  child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      width: ScreenUtil().setWidth(370),
                                      height: ScreenUtil().setHeight(720),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(10),
                                                bottom: ScreenUtil()
                                                    .setHeight(100)),
                                            child: ListView(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(60),
                                                    left: ScreenUtil()
                                                        .setWidth(5),
                                                  ),
                                                  child: Wrap(
                                                    runSpacing: ScreenUtil()
                                                        .setHeight(30),
                                                    children: <Widget>[
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text(
                                                              "主队" +
                                                                  "【" +
                                                                  widget
                                                                      .zd_name +
                                                                  "】" +
                                                                  "让球  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            double.parse(widget
                                                                        .p_goal) >
                                                                    0
                                                                ? Text(
                                                                    widget
                                                                        .p_goal,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  )
                                                                : Text(
                                                                    widget
                                                                        .p_goal,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                color:
                                                                    Colors.blue,
                                                                height:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            60),
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            25),
                                                                child: Text(
                                                                  "非让",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: ScreenUtil()
                                                                    .setWidth(
                                                                        325),
                                                                child: Wrap(
                                                                  children:
                                                                      getFrqList(
                                                                          widget
                                                                              .e,
                                                                          widget
                                                                              .e2,
                                                                          state),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                color: Colors
                                                                    .orange,
                                                                height:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            60),
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            25),
                                                                child: Text(
                                                                  "让球",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: ScreenUtil()
                                                                    .setWidth(
                                                                        325),
                                                                child: Wrap(
                                                                  children: getRqList(

                                                                      widget.e,
                                                                      widget.e2,
                                                                      state),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            color: Colors.red,
                                                            height: ScreenUtil()
                                                                .setHeight(300),
                                                            width: ScreenUtil()
                                                                .setWidth(25),
                                                            child: Text(
                                                              "比分",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(325),
                                                            child: Wrap(
                                                              children:
                                                                  getScoreList(
                                                                      state),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            color: Color(
                                                                0xffbdecff),
                                                            height: ScreenUtil()
                                                                .setHeight(120),
                                                            width: ScreenUtil()
                                                                .setWidth(25),
                                                            child: Text(
                                                              "总进球",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(325),
                                                            child: Wrap(
                                                              children:
                                                                  getTotalList(state),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            color: Color(
                                                                0xffffc2eb),
                                                            height: ScreenUtil()
                                                                .setHeight(120),
                                                            width: ScreenUtil()
                                                                .setWidth(25),
                                                            child: Text(
                                                              "半全场",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: ScreenUtil()
                                                                .setWidth(325),
                                                            child: Wrap(
                                                              children:
                                                                  getHalfList(
                                                                      state),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            bottom: 0,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey),
                                                  child: MaterialButton(
                                                    splashColor: Colors.grey,
                                                    minWidth: ScreenUtil()
                                                        .setWidth(185),
                                                    height: ScreenUtil()
                                                        .setHeight(45),
                                                    child: new Text(
                                                      "取消",
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.red),
                                                  child: MaterialButton(
                                                    minWidth: ScreenUtil()
                                                        .setWidth(185),
                                                    height: ScreenUtil()
                                                        .setHeight(45),
                                                    child: new Text(
                                                      "确认",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {});
                                                      widget.callBack(widget.games);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(52),
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(widget.zd_name),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 20),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Icon(
                                                          const IconData(0xe606,
                                                              fontFamily:
                                                                  "iconfont"),
                                                          color: Colors.red,
                                                        ),
                                                        Positioned(
                                                          left: ScreenUtil()
                                                              .setWidth(4),
                                                          child: Text(
                                                            "主",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 25),
                                                    child: Text("VS"),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Text(widget.kd_name),
                                                  ),
                                                  Stack(
                                                    children: <Widget>[
                                                      Icon(
                                                        const IconData(0xe606,
                                                            fontFamily:
                                                                "iconfont"),
                                                        color: Colors.blue,
                                                      ),
                                                      Positioned(
                                                        left: ScreenUtil()
                                                            .setWidth(4),
                                                        child: Text(
                                                          "客",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            );
                          },
                        );
                      });
                },
                child: getText(widget.e, widget.e2),
              )
            ],
          ),
        )
      ],
    );
  }
  Widget getText(int e1, e2) {
    List check_info = widget.games[e2][e1]["check_info"];
    int i = 0;
    check_info.forEach((element) {
      List e = element["bet_way"];
      e.forEach((element1) {
        if (element1["color"] != "co") {
          i++;
        }
      });
    });
    if (i == 0) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("展开", style: TextStyle(color: Colors.grey)),
            Text("全部", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("已选", style: TextStyle(color: Colors.white)),
            Text(i.toString() + "个", style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }
  }



   getRqList(int e1, e2, state) {
    String status = widget.p_status[1];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(105*3),
        height: ScreenUtil().setHeight(60),
        child: Text("暂停销售",),
      )];
    }
    List rqspf_ = config.getrq();
    return widget.rqspf.asMap().keys.map((e) {
      return GestureDetector(
        onTap: () {
          Map checks = jsonDecode(widget.games[e2][e1]["checks"]);
          String mid = widget.games[e2][e1]["check_info"][1]["id"].toString();
          int id = widget.games[e2][e1]["check_info"][1]["bet_way"][e]["id"];
         if(checks[mid] != null){
           List attr = checks[mid];
           if(widget.games[e2][e1]["check_info"][1]["bet_way"][e]["color"] == "co"){

               attr.add(id.toString()+"-"+widget.rqspf[e]);


           }else{
             attr.remove(id.toString()+"-"+widget.rqspf[e]);
           }
           checks[mid] = attr;
         }else{
           List attr = [];
           attr.add(id.toString()+"-"+widget.rqspf[e]);
           checks[mid] = attr;
         }

          widget.games[e2][e1]["checks"] =  jsonEncode(checks);
          state(() {

            widget.games[e2][e1]["check_info"][1]["bet_way"][e]["color"] =
                widget.games[e2][e1]["check_info"][1]["bet_way"][e]["color"] ==
                        "co"
                    ? "red"
                    : "co";
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.games[e2][e1]["check_info"][1]["bet_way"][e]
                          ["color"] ==
                      "co"
                  ? Color(0xfffff5f8)
                  : Colors.red,
              border: Border(
                  right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          width: ScreenUtil().setWidth(105),
          height: ScreenUtil().setHeight(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  rqspf_[e],
                  style: TextStyle(
                      color: widget.games[e2][e1]["check_info"][1]["bet_way"][e]
                                  ["color"] ==
                              "co"
                          ? Colors.black
                          : Colors.white),
                ),
              ),
              Text(
                widget.rqspf[e],
                style: TextStyle(
                    color: widget.games[e2][e1]["check_info"][1]["bet_way"][e]
                                ["color"] ==
                            "co"
                        ? Colors.grey
                        : Colors.white,
                    fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

   getFrqList(int e1, e2, state) {

    String status = widget.p_status[0];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(105*3),
        height: ScreenUtil().setHeight(60),
        child: Text("暂停销售",),
      )];
    }
    List frqspf_ = config.getFrq();
    return widget.spf.asMap().keys.map((e) {

      return GestureDetector(
        onTap: () {
          Map checks = jsonDecode(widget.games[e2][e1]["checks"]);
          String mid = widget.games[e2][e1]["check_info"][0]["id"].toString();
          String id = widget.games[e2][e1]["check_info"][0]["bet_way"][e]["id"].toString();
          if(checks[mid] != null){
            List attr = checks[mid];
            if(widget.games[e2][e1]["check_info"][0]["bet_way"][e]["color"] == "co"){

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
          widget.games[e2][e1]["checks"] =  jsonEncode(checks);
          state(() {

            widget.games[e2][e1]["check_info"][0]["bet_way"][e]["color"] =
                widget.games[e2][e1]["check_info"][0]["bet_way"][e]["color"] ==
                        "co"
                    ? "red"
                    : "co";
          });


        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.games[e2][e1]["check_info"][0]["bet_way"][e]
                          ["color"] ==
                      "co"
                  ? Color(0xfffff5f8)
                  : Colors.red,
              border: Border(
                  right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          width: ScreenUtil().setWidth(105),
          height: ScreenUtil().setHeight(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  frqspf_[e],
                  style: TextStyle(
                      color: widget.games[e2][e1]["check_info"][0]["bet_way"][e]
                                  ["color"] ==
                              "co"
                          ? Colors.black
                          : Colors.white),
                ),
              ),
              Text(
                widget.spf[e],
                style: TextStyle(
                    color: widget.games[e2][e1]["check_info"][0]["bet_way"][e]
                                ["color"] ==
                            "co"
                        ? Colors.grey
                        : Colors.white,
                    fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

   getFrqList_() {
    String status = widget.p_status[0];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
           color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(240),
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
          width: ScreenUtil().setWidth(80),
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

   getrqList_() {
    String status = widget.p_status[1];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(240),
        height: ScreenUtil().setHeight(40),
        child: Text("暂停销售",),
      )];
    }
    List frqspf_ = config.getrq();
    return widget.rqspf.asMap().keys.map((e) {
      return GestureDetector(
        onTap: () {
          Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
          String mid = widget.games[widget.e2][widget.e]["check_info"][1]["id"].toString();
          String id = widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][e]["id"].toString();
          if(checks[mid] != null){
            List attr = checks[mid];
            if(widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][e]["color"] == "co"){

                attr.add(id+"-"+widget.rqspf[e]);

            }else{
              attr.remove(id+"-"+widget.rqspf[e]);
            }
            checks[mid] = attr;
          }else{
            List attr = [];
            attr.add(id+"-"+widget.rqspf[e]);
            checks[mid] = attr;
          }
          widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
          setState(() {
            widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][e]
                ["color"] = widget.games[widget.e2][widget.e]["check_info"][1]
                        ["bet_way"][e]["color"] ==
                    "co"
                ? "red"
                : "co";
          });
          widget.callBack(widget.games);
        },
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setHeight(40),
          decoration: BoxDecoration(
              color: widget.games[widget.e2][widget.e]["check_info"][1]
                          ["bet_way"][e]["color"] ==
                      "co"
                  ? Colors.white
                  : Colors.red,
              border: Border.all(width: 0.3, color: Colors.grey)),
          child: Text(
            frqspf_[e] + widget.rqspf[e],
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][1]
                            ["bet_way"][e]["color"] ==
                        "co"
                    ? Colors.grey
                    : Colors.white),
          ),
        ),
      );
    }).toList();
  }

   getHalfList(state) {
    String status = widget.p_status[4];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(64*5),
        height: ScreenUtil().setHeight(120),
        child: Text("暂停销售",),
      )];
    }
    List half_ = config.getHalf();
    return widget.half_odds.asMap().keys.map((e) {
      return GestureDetector(
        onTap: () {
          Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
          String mid = widget.games[widget.e2][widget.e]["check_info"][4]["id"].toString();
          String id = widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][e]["id"].toString();
          if(checks[mid] != null){
            List attr = checks[mid];
            if(widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][e]["color"] == "co"){

                attr.add(id+"-"+widget.half_odds[e]);

            }else{
              attr.remove(id+"-"+widget.half_odds[e]);
            }
            checks[mid] = attr;
          }else{
            List attr = [];
            attr.add(id+"-"+widget.half_odds[e]);
            checks[mid] = attr;
          }
          widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
          state(() {
            widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][e]
                ["color"] = widget.games[widget.e2][widget.e]["check_info"][4]
                        ["bet_way"][e]["color"] ==
                    "co"
                ? "red"
                : "co";
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.games[widget.e2][widget.e]["check_info"][4]
                          ["bet_way"][e]["color"] ==
                      "co"
                  ? Color(0xfffff5f8)
                  : Colors.red,
              border: Border(
                  right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          width: ScreenUtil().setWidth(64),
          height: ScreenUtil().setHeight(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  half_[e],
                  style: TextStyle(
                      color: widget.games[widget.e2][widget.e]["check_info"][4]
                                  ["bet_way"][e]["color"] ==
                              "co"
                          ? Colors.black
                          : Colors.white),
                ),
              ),
              Text(
                widget.half_odds[e],
                style: TextStyle(
                    color: widget.games[widget.e2][widget.e]["check_info"][4]
                                ["bet_way"][e]["color"] ==
                            "co"
                        ? Colors.grey
                        : Colors.white, fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

   getTotalList(state) {
    String status = widget.p_status[3];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
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
          String id =  widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"][e]["id"].toString();
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
          state(() {
            widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"][e]
            ["color"] = widget.games[widget.e2][widget.e]["check_info"][3]
            ["bet_way"][e]["color"] ==
                "co"
                ? "red"
                : "co";
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.games[widget.e2][widget.e]["check_info"][3]
              ["bet_way"][e]["color"] ==
                  "co"
                  ? Color(0xfffff5f8)
                  : Colors.red,
              border: Border(
                  right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          width: ScreenUtil().setWidth(80),
          height: ScreenUtil().setHeight(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(total_[e] + "球",style: TextStyle(color: widget.games[widget.e2][widget.e]["check_info"][3]
                ["bet_way"][e]["color"] ==
                    "co"
                    ? Colors.black
                    : Colors.white),),
              ),
              Text(
                widget.ttg_odds[e],
                style: TextStyle(
                    color: widget.games[widget.e2][widget.e]["check_info"][3]
                    ["bet_way"][e]["color"] ==
                        "co"
                        ? Colors.grey
                        : Colors.white, fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

   getScoreList(state) {
    String status = widget.p_status[2];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(45*7),
        height: ScreenUtil().setHeight(300),
        child: Text("暂停销售",),
      )];
    }
    List score_ = config.getScore();
    return widget.crs_win.asMap().keys.map((e) {
      int width_;
      if (e == 12 || e == 30) {
        width_ = 90;
      } else if (e == 17) {
        width_ = 135;
      } else {
        width_ = 45;
      }
      return GestureDetector(
        onTap: (){
          Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
          String mid = widget.games[widget.e2][widget.e]["check_info"][2]["id"].toString();
          String id = widget.games[widget.e2][widget.e]["check_info"][2]["bet_way"][e]["id"].toString();
          if(checks[mid] != null){
            List attr = checks[mid];
            if(widget.games[widget.e2][widget.e]["check_info"][2]["bet_way"][e]["color"] == "co"){
                attr.add(id+"-"+widget.crs_win[e]);
            }else{
              attr.remove(id+"-"+widget.crs_win[e]);
            }
            checks[mid] = attr;
          }else{
            List attr = [];
            attr.add(id+"-"+widget.crs_win[e]);
            checks[mid] = attr;
          }
          widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
          state(() {
            widget.games[widget.e2][widget.e]["check_info"][2]["bet_way"][e]
            ["color"] = widget.games[widget.e2][widget.e]["check_info"][2]
            ["bet_way"][e]["color"] ==
                "co"
                ? "red"
                : "co";
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.games[widget.e2][widget.e]["check_info"][2]
              ["bet_way"][e]["color"] ==
                  "co"
                  ? Color(0xfffff5f8)
                  : Colors.red,
              border: Border(
                  right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          width: ScreenUtil().setWidth(width_),
          height: ScreenUtil().setHeight(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(score_[e],style: TextStyle(
                    color: widget.games[widget.e2][widget.e]["check_info"][2]
                    ["bet_way"][e]["color"] ==
                        "co"
                        ? Colors.black
                        : Colors.white
                ),),
              ),
              Text(
                widget.crs_win[e],
                style: TextStyle(
                    color: widget.games[widget.e2][widget.e]["check_info"][2]
                    ["bet_way"][e]["color"] ==
                        "co"
                        ? Colors.grey
                        : Colors.white, fontSize: ScreenUtil().setSp(12)),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

}
