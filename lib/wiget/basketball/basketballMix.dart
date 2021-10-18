import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/config/config.dart';

class basketballMix extends StatefulWidget {
  Function callBack;

  Map games;
  String e2;
  int e;
  String zd_name;
  String kd_name;
  List sf;
  List p_goal;
  List rfsf = ["0","0"];
  List zs_sfc;
  List ks_sfc;
  List dxf;
  String dafen;
  List p_status;

  basketballMix(
      {Key key,
      this.callBack,
      this.games,
      this.e2,
      this.e,
      this.zd_name,
      this.kd_name,
      this.sf,
      this.rfsf,
      this.zs_sfc,
      this.ks_sfc,
      this.dxf,
      this.p_goal,
      this.p_status,
      this.dafen
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildState();
  }
}

class _ChildState extends State<basketballMix> {
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
                  "VS",
                  style: TextStyle(fontSize: ScreenUtil().setSp(16)),
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
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(20),
                          height: ScreenUtil().setHeight(48),
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Text(
                            "让分",
                            style: TextStyle(height:1.1,color: Colors.white,decoration: TextDecoration.none,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          children: getrfList_(),
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
                          height: ScreenUtil().setHeight(50),
                          decoration: BoxDecoration(color: Colors.orange),
                          child: Text(
                            "大小分",
                            style: TextStyle(height:0.9,color: Colors.white,decoration: TextDecoration.none,fontSize: ScreenUtil().setSp(12)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          children: getdxfList_(),
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
                                                                  "(" +
                                                                  widget
                                                                      .zd_name +
                                                                  ")" +
                                                                  "让分  ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            double.parse(widget
                                                                .p_goal[1]) >
                                                                0
                                                                ? Text(
                                                              widget
                                                                  .p_goal[1],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            )
                                                                : Text(
                                                              widget
                                                                  .p_goal[1],
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
                                                                  "胜负",
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
                                                                  getsfList(state),
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
                                                                color:
                                                                Colors.lightGreen,
                                                                height:
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                    60),
                                                                width:
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                    25),
                                                                child: Text(
                                                                  "让分",
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
                                                                  getrfList(state),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Container(
                                                            margin:EdgeInsets.only(bottom: 5),
                                                            child: Text("总分: "+widget.dafen.substring(1)),
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
                                                                  "大小分",
                                                                  style: TextStyle(
                                                                    fontSize: ScreenUtil().setSp(13),
                                                                    height: 1,
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
                                                                  getdxfList(state),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
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
                                                                Colors.pink,
                                                                height:
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                    180),
                                                                width:
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                    25),
                                                                child: Text(
                                                                  "主胜",
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
                                                                  getzssfcList(state),
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
                                                                color:
                                                                Color(0xffb8fcde),
                                                                height:
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                    180),
                                                                width:
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                    25),
                                                                child: Text(
                                                                  "客胜",
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
                                                                  getkssfcList(state),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
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
        height: ScreenUtil().setHeight(100),
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
        height: ScreenUtil().setHeight(100),
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


getsfList(state){
  String status = widget.p_status[0];
  if(status == "0"){
    return [Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey)),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(320),
      height: ScreenUtil().setHeight(60),
      child: Text("暂停销售",),
    )];
  }

  return [GestureDetector(
    onTap: () {
      Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
      String mid = widget.games[widget.e2][widget.e]["check_info"][0]["id"].toString();
      String id = widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][0]["id"].toString();
      if(checks[mid] != null){
        List attr = checks[mid];
        if(widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][0]["color"] == "co"){

            attr.add(id+"-"+widget.sf[0]);


        }else{
          attr.remove(id+"-"+widget.sf[0]);
        }
        checks[mid] = attr;
      }else{
        List attr = [];
        attr.add(id+"-"+widget.sf[0]);
        checks[mid] = attr;
      }

      widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
      state(() {
        widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][0]
        ["color"] = widget.games[widget.e2][widget.e]["check_info"][0]
        ["bet_way"][0]["color"] ==
            "co"
            ? "red"
            : "co";
      });

    },
    child: Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(60),
      decoration: BoxDecoration(
          color: widget.games[widget.e2][widget.e]["check_info"][0]
          ["bet_way"][0]["color"] ==
              "co"
              ? Color(0xfffff5f8)
              : Colors.red,
          border: Border(
              right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
              bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            "主负",
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][0]
                ["bet_way"][0]["color"] ==
                    "co"
                    ? Colors.black
                    : Colors.white),
          ),
          Text(
            widget.sf[0],
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][0]
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
      String mid = widget.games[widget.e2][widget.e]["check_info"][0]["id"].toString();
      String id = widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][1]["id"].toString();
      if(checks[mid] != null){
        List attr = checks[mid];
        if(widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][1]["color"] == "co"){

            attr.add(id+"-"+widget.sf[1]);

        }else{
          attr.remove(id+"-"+widget.sf[1]);
        }
        checks[mid] = attr;
      }else{
        List attr = [];
        attr.add(id+"-"+widget.sf[1]);
        checks[mid] = attr;
      }

      widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
      state(() {
        widget.games[widget.e2][widget.e]["check_info"][0]["bet_way"][1]
        ["color"] = widget.games[widget.e2][widget.e]["check_info"][0]
        ["bet_way"][1]["color"] ==
            "co"
            ? "red"
            : "co";
      });

    },
    child: Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(160),
      height: ScreenUtil().setHeight(60),
      decoration: BoxDecoration(
          color: widget.games[widget.e2][widget.e]["check_info"][0]
          ["bet_way"][1]["color"] ==
              "co"
              ? Color(0xfffff5f8)
              : Colors.red,
          border: Border(
              right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
              bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            "主胜",
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][0]
                ["bet_way"][1]["color"] ==
                    "co"
                    ? Colors.black
                    : Colors.white),
          ),
          Text(
            widget.sf[1],
            style: TextStyle(
                color: widget.games[widget.e2][widget.e]["check_info"][0]
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

getrfList(state){
    String status = widget.p_status[1];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(60),
        child: Text("暂停销售",),
      )];
    }

    return [GestureDetector(
      onTap: () {
        Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
        String mid = widget.games[widget.e2][widget.e]["check_info"][1]["id"].toString();
        String id = widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][0]["id"].toString();
        if(checks[mid] != null){
          List attr = checks[mid];
          if(widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][0]["color"] == "co"){

              attr.add(id+"-"+widget.rfsf[0]);


          }else{
            attr.remove(id+"-"+widget.rfsf[0]);
          }
          checks[mid] = attr;
        }else{
          List attr = [];
          attr.add(id+"-"+widget.rfsf[0]);
          checks[mid] = attr;
        }

        widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
        state(() {
          widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][0]
          ["color"] = widget.games[widget.e2][widget.e]["check_info"][1]
          ["bet_way"][0]["color"] ==
              "co"
              ? "red"
              : "co";
        });

      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(60),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][1]
            ["bet_way"][0]["color"] ==
                "co"
                ? Color(0xfffff5f8)
                : Colors.red,
            border: Border(
                right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
        child: Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(
              "主负",
              style: TextStyle(
                  color: widget.games[widget.e2][widget.e]["check_info"][1]
                  ["bet_way"][0]["color"] ==
                      "co"
                      ? Colors.black
                      : Colors.white),
            ),
            Text(
              widget.rfsf[0],
              style: TextStyle(
                  color: widget.games[widget.e2][widget.e]["check_info"][1]
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
        String mid = widget.games[widget.e2][widget.e]["check_info"][1]["id"].toString();
        String id = widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][1]["id"].toString();
        if(checks[mid] != null){
          List attr = checks[mid];
          if(widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][1]["color"] == "co"){

              attr.add(id+"-"+widget.rfsf[1]);


          }else{
            attr.remove(id+"-"+widget.rfsf[1]);
          }
          checks[mid] = attr;
        }else{
          List attr = [];
          attr.add(id+"-"+widget.rfsf[1]);
          checks[mid] = attr;
        }
        widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
        state(() {
          widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][1]
          ["color"] = widget.games[widget.e2][widget.e]["check_info"][1]
          ["bet_way"][1]["color"] ==
              "co"
              ? "red"
              : "co";
        });

      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(60),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][1]
            ["bet_way"][1]["color"] ==
                "co"
                ? Color(0xfffff5f8)
                : Colors.red,
            border: Border(
                right: BorderSide(width: 1, color: Color(0xfff2f2f2)),
                bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
        child: Wrap(
          spacing: 5,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(
              "主胜",
              style: TextStyle(
                  color: widget.games[widget.e2][widget.e]["check_info"][1]
                  ["bet_way"][1]["color"] ==
                      "co"
                      ? Colors.black
                      : Colors.white),
            ),
            Text(
              widget.rfsf[1],
              style: TextStyle(
                  color: widget.games[widget.e2][widget.e]["check_info"][1]
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

getdxfList(state){
    String status = widget.p_status[3];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(60),
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
        state(() {
          widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][0]
          ["color"] = widget.games[widget.e2][widget.e]["check_info"][4]
          ["bet_way"][0]["color"] ==
              "co"
              ? "red"
              : "co";
        });

      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(60),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][4]
            ["bet_way"][0]["color"] ==
                "co"
                ? Color(0xfffff5f8)
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
                      ? Colors.black
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
        state(() {
          widget.games[widget.e2][widget.e]["check_info"][4]["bet_way"][1]
          ["color"] = widget.games[widget.e2][widget.e]["check_info"][4]
          ["bet_way"][1]["color"] ==
              "co"
              ? "red"
              : "co";
        });

      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(60),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][4]
            ["bet_way"][1]["color"] ==
                "co"
                ? Color(0xfffff5f8)
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
                      ? Colors.black
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

getzssfcList(state){
  String status = widget.p_status[2];
  if(status == "0"){
    return [Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey)),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(320),
      height: ScreenUtil().setHeight(60*3),
      child: Text("暂停销售",),
    )];
  }
  List zssfc = config.getsfcZs();
  return widget.zs_sfc.asMap().keys.map((e) {

    return GestureDetector(
      onTap: (){
        Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
        String mid = widget.games[widget.e2][widget.e]["check_info"][2]["id"].toString();
        String id = widget.games[widget.e2][widget.e]["check_info"][2]["bet_way"][e]["id"].toString();
        if(checks[mid] != null){
          List attr = checks[mid];
          if(widget.games[widget.e2][widget.e]["check_info"][2]["bet_way"][e]["color"] == "co"){

              attr.add(id+"-"+widget.zs_sfc[e]);


          }else{
            attr.remove(id+"-"+widget.zs_sfc[e]);
          }
          checks[mid] = attr;
        }else{
          List attr = [];
          attr.add(id+"-"+widget.zs_sfc[e]);
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
        width: ScreenUtil().setWidth(160),
        height: ScreenUtil().setHeight(60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 2),
              child: Text(zssfc[e],style: TextStyle(
                  color: widget.games[widget.e2][widget.e]["check_info"][2]
                  ["bet_way"][e]["color"] ==
                      "co"
                      ? Colors.black
                      : Colors.white
              ),),
            ),
            Text(
              widget.zs_sfc[e],
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

getkssfcList(state){
    String status = widget.p_status[2];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(320),
        height: ScreenUtil().setHeight(60*3),
        child: Text("暂停销售",),
      )];
    }
    List zssfc = config.getsfcZs();
    return widget.ks_sfc.asMap().keys.map((e) {

      return GestureDetector(
        onTap: (){
          Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
          String mid = widget.games[widget.e2][widget.e]["check_info"][3]["id"].toString();
          String id = widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"][e]["id"].toString();
          if(checks[mid] != null){
            List attr = checks[mid];
            if(widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"][e]["color"] == "co"){

                attr.add(id+"-"+widget.ks_sfc[e]);


            }else{
              attr.remove(id+"-"+widget.ks_sfc[e]);
            }
            checks[mid] = attr;
          }else{
            List attr = [];
            attr.add(id+"-"+widget.ks_sfc[e]);
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
          width: ScreenUtil().setWidth(160),
          height: ScreenUtil().setHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(zssfc[e],style: TextStyle(
                    color: widget.games[widget.e2][widget.e]["check_info"][3]
                    ["bet_way"][e]["color"] ==
                        "co"
                        ? Colors.black
                        : Colors.white
                ),),
              ),
              Text(
                widget.ks_sfc[e],
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
  //表面
getrfList_() {
    String status = widget.p_status[1];
    print(status);
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
           color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(240),
        height: ScreenUtil().setHeight(50),
        child: Text("暂停销售",),
      )];
    }

    return [GestureDetector(
      onTap: () {
        Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
        String mid = widget.games[widget.e2][widget.e]["check_info"][1]["id"].toString();
        String id = widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][0]["id"].toString();
        if(checks[mid] != null){
          List attr = checks[mid];
          if(widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][0]["color"] == "co"){
              attr.add(id+"-"+widget.rfsf[0]);
          }else{
            attr.remove(id+"-"+widget.rfsf[0]);
          }
          checks[mid] = attr;
        }else{
          List attr = [];
          attr.add(id+"-"+widget.rfsf[0]);
          checks[mid] = attr;
        }
        widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
        setState(() {
          widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][0]
          ["color"] = widget.games[widget.e2][widget.e]["check_info"][1]
          ["bet_way"][0]["color"] ==
              "co"
              ? "red"
              : "co";
        });
        widget.callBack(widget.games);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(50),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][1]
            ["bet_way"][0]["color"] ==
                "co"
                ? Colors.white
                : Colors.red,
            border: Border.all(width: 0.3, color: Colors.grey)),
        child: Text(
          "主负" + widget.rfsf[0],
          style: TextStyle(
              color: widget.games[widget.e2][widget.e]["check_info"][1]
              ["bet_way"][0]["color"] ==
                  "co"
                  ? Colors.grey
                  : Colors.white),
        ),
      ),
    ),Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(50),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey)),
      child: Text(
        "主" + widget.p_goal[1],
        style: TextStyle(color: Colors.grey),
      ),
    ),GestureDetector(
      onTap: () {
        Map checks = jsonDecode(widget.games[widget.e2][widget.e]["checks"]);
        String mid = widget.games[widget.e2][widget.e]["check_info"][1]["id"].toString();
        String id = widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][1]["id"].toString();
        if(checks[mid] != null){
          List attr = checks[mid];
          if(widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][1]["color"] == "co"){

              attr.add(id+"-"+widget.rfsf[1]);


          }else{
            attr.remove(id+"-"+widget.rfsf[1]);
          }
          checks[mid] = attr;
        }else{
          List attr = [];
          attr.add(id+"-"+widget.rfsf[1]);
          checks[mid] = attr;
        }
        widget.games[widget.e2][widget.e]["checks"] =  jsonEncode(checks);
        setState(() {
          widget.games[widget.e2][widget.e]["check_info"][1]["bet_way"][1]
          ["color"] = widget.games[widget.e2][widget.e]["check_info"][1]
          ["bet_way"][1]["color"] ==
              "co"
              ? "red"
              : "co";
        });
        widget.callBack(widget.games);
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(50),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][1]
            ["bet_way"][1]["color"] ==
                "co"
                ? Colors.white
                : Colors.red,
            border: Border.all(width: 0.3, color: Colors.grey)),
        child: Text(
          "主胜" + widget.rfsf[1],
          style: TextStyle(
              color: widget.games[widget.e2][widget.e]["check_info"][1]
              ["bet_way"][1]["color"] ==
                  "co"
                  ? Colors.grey
                  : Colors.white),
        ),
      ),
    )];

  }
getdxfList_() {
    String status = widget.p_status[3];
    if(status == "0"){
      return [Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.3, color: Colors.grey)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(240),
        height: ScreenUtil().setHeight(50),
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
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(50),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][4]
            ["bet_way"][0]["color"] ==
                "co"
                ? Colors.white
                : Colors.red,
            border: Border.all(width: 0.3, color: Colors.grey)),
        child: Text(
          "大分" + widget.dxf[0],
          style: TextStyle(
              color: widget.games[widget.e2][widget.e]["check_info"][4]
              ["bet_way"][0]["color"] ==
                  "co"
                  ? Colors.grey
                  : Colors.white),
        ),
      ),
    ),Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(50),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey)),
      child: Text(
        widget.dafen,
        style: TextStyle(color: Colors.grey),
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
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(50),
        decoration: BoxDecoration(
            color: widget.games[widget.e2][widget.e]["check_info"][4]
            ["bet_way"][1]["color"] ==
                "co"
                ? Colors.white
                : Colors.red,
            border: Border.all(width: 0.3, color: Colors.grey)),
        child: Text(
          "小分" + widget.dxf[1],
          style: TextStyle(
              color: widget.games[widget.e2][widget.e]["check_info"][4]
              ["bet_way"][1]["color"] ==
                  "co"
                  ? Colors.grey
                  : Colors.white),
        ),
      ),
    )];

  }







}
