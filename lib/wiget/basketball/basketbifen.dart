import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/config/config.dart';

class basketbifen extends StatefulWidget {
  Function callBack;
  Map games;
  String e2;
  int e;
  String zd_name;
  String kd_name;
  List zs_sfc;
  List ks_sfc;
  List p_status;


  basketbifen(
      {Key key,
      this.callBack,
      this.games,
      this.e2,
      this.e,
      this.zd_name,
      this.kd_name,
      this.zs_sfc,
      this.ks_sfc,
      this.p_status,

      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildState();
  }
}

class _ChildState extends State<basketbifen> {
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
                    child: getScore(),
                  )
                ],
              ),

            ],
          ),
        )
      ],
    );
  }

getScore(){
  String status = widget.p_status[2];
  if(status == "0"){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey)),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(320),
      height: ScreenUtil().setHeight(35),
      child: Text("暂停销售",),
    );
  }else{
    return GestureDetector(
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
                            height: ScreenUtil().setHeight(600),
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

                                          children: <Widget>[

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
                                                      .setHeight(180),
                                                  width: ScreenUtil()
                                                      .setWidth(25),
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
                                                  color: Colors.orangeAccent,
                                                  height: ScreenUtil()
                                                      .setHeight(180),
                                                  width: ScreenUtil()
                                                      .setWidth(25),
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
                                                      .setWidth(325),
                                                  child: Wrap(
                                                    children:
                                                    getScoreList_ks(
                                                        state),
                                                  ),
                                                )
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
      child: getText_(),
    );
  }
}
  getText_(){
    String str = "";

    List list1 = widget.games[widget.e2][widget.e]["check_info"][2]["bet_way"];
    List list2 = widget.games[widget.e2][widget.e]["check_info"][3]["bet_way"];

    list1.forEach((element) {
      if(element["color"] == "red"){
        str += widget.games[widget.e2][widget.e]["check_info"][2]["name"]+ element["value"]+"|";
      }
    });
    list2.forEach((element) {
      if(element["color"] == "red"){
        str += widget.games[widget.e2][widget.e]["check_info"][3]["name"]+ element["value"]+"|";
      }
    });
    if(str.length == 6){
      str = str.substring(0,5);
    }
    if(str == ""){
      str = "点击展开投注区";
    }
    return Container(
      padding: EdgeInsets.only(top: 3,bottom: 3),
      decoration: BoxDecoration(
          color: str != "点击展开投注区"?Colors.red:Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey)),
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(320),

      child: Text(str,style: TextStyle(color: str != "点击展开投注区"?Colors.white:Colors.grey),),
    );
  }
  getScoreList(state) {
    String status = widget.p_status[0];
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
    List score_ = config.getsfcZs();
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
  getScoreList_ks(state) {
    String status = widget.p_status[0];
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
    List score_ = config.getsfcZs();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(score_[e],style: TextStyle(
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
}
