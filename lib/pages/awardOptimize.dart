import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/success.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Toast.dart';
import '../main.dart';

class awardOptimize extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
  List data;
  int money;
  int chuan;
  List game;

  awardOptimize({this.data,this.money,this.chuan,this.game});
}

class Login_ extends State<awardOptimize> {
  Map num_to_cn = {
    "1": "一",
    "2": "二",
    "3": "三",
    "4": "四",
    "5": "五",
    "6": "六",
    "7": "末"
  };
  int order_money;
  List lst;
  int zhu_;
  int zhu;
  int diff_zhu;
  List now_index=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      order_money = widget.money;
       lst = widget.data;
    });
    setState(() {
      lst = widget.data;
    });

    lst.forEach((element) {

      List ls1 = element["data"];
      double m = 1;
      ls1.forEach((element2) {
        m*=element2["pl"];
      });
      element["award"] = m*2;
      element["base_award"] = m*2;

    });


    zhu = (widget.money/2).toInt();
    zhu_ = lst.length;
    diff_zhu = zhu-zhu_;

    if(diff_zhu>0){
      lst.sort((left, right) => left["award"].compareTo(right["award"]));
      int m = 0;
      for(int i=0;i<diff_zhu;i++){
        lst[0]["award"] += lst[0]["base_award"];
        now_index.add(lst[0]["index"]);
        lst.sort((left, right) => left["award"].compareTo(right["award"]));
        m++;
      }

    }
    lst.sort((left, right) {
      List s1 = left["data"];
      int l1 = s1.length;
      List s2 = right["data"];
      int l2 = s2.length;
      return l1.compareTo(l2);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          size: 25.0,
          color: Colors.white, //修改颜色
        ),
        backgroundColor: Color(0xfffa2020),
        title: Text("奖金优化",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(110)),
                child: Center(
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Color(0xffebebeb),
                        child: Row(
                          children: <Widget>[
                            Text("计划购买"),
                            Container(
                              width: ScreenUtil().setWidth(160),
                              height: ScreenUtil().setHeight(48),
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      if (order_money > lst.length*2 ) {
                                        setState(() {
                                          order_money -= 2;

                                          int index =  now_index.removeLast();
                                          for(int i=0;i<lst.length;i++){
                                            if(lst[i]["index"] == index){
                                              lst[i]["award"] -= lst[i]["base_award"];
                                              break;
                                            }
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      color: Colors.grey,
                                      height: ScreenUtil().setHeight(48),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "—",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      //限制2长度],//只允许输入数字
                                      onChanged: (e) {
                                        setState(() {
                                          order_money = int.parse(e);
                                          if(order_money<lst.length*2){
                                            order_money = lst.length*2;
                                            zhu_ +=1;
                                          }
                                        });
                                      },
                                      controller: TextEditingController.fromValue(
                                          TextEditingValue(
                                              text:
                                              '${this.order_money == null ? "" : this.order_money}',
                                              selection: TextSelection.fromPosition(
                                                  TextPosition(
                                                      affinity:
                                                      TextAffinity.downstream,
                                                      offset: '${this.order_money}'.length)))),
                                      keyboardType: TextInputType.number,
                                      //键盘类型，数字键盘

                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 10),
                                        hintText: "",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(0))),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        order_money += 2;
                                        Map s =  lst.reduce((value, element) {
                                          return value["award"]>element["award"]?element:value;
                                        });
                                        s["award"] += s["base_award"];
                                        now_index.add(s["index"]);
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      color: Colors.grey,
                                      height: ScreenUtil().setHeight(48),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "+",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("元"),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(top: 7,bottom: 7),
                        color: Color(0xffebebeb),
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Row(

                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: ScreenUtil().setWidth(60),
                                  child: Text("过关"),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: ScreenUtil().setWidth(140),
                                  child: Text("单注组合"),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: ScreenUtil().setWidth(130),
                                  child: Text("注数分布"),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: ScreenUtil().setWidth(70),
                                  child: Text("预测奖金"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(top: 7,bottom: 7),

                        width: double.infinity,
                        child: Column(

                          children: getData(),
                        ),
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  alignment: Alignment.center,
                  color: Color(0xffebebeb),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text("投"),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25,right: 25,top: 3,bottom: 3),
                        margin: EdgeInsets.only(left: 10,right: 10),
                        decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Color(0xffebebeb),)),
                        child: Text("1"),
                      ),
                      Container(
                        child: Text("倍"),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child:Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              children: <Widget>[
                                Text("总金额："+order_money.toString()+"元",style: TextStyle(color: Colors.red),),
                                Text("奖金范围"+getAwardRange(),style: TextStyle(color: Colors.red,fontSize: 10),),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                color: Colors.orange,
                                onPressed: (){
//

                        if(order_money<10){
                          Toast.toast(context,
                              msg: "投注金额不能小于10");
                          return;
                        }

                        List chuan = [];
                                  lst.forEach((element) {
                                   chuan.add(element["data"].length);
                                    element["num"] = (element["award"]/element["base_award"]).toStringAsFixed(0);

                                  });
                        var dedu = new Set();
                        dedu.addAll(chuan);

                                  List s = widget.game;
                                  EventDioLog("提示", "确认付款", context, () async {

                                    ResultData res =
                                    await HttpManager.getInstance()
                                        .post("doorder", params: {
                                      "games": s,
                                      "chuan": dedu.toList(),
                                      "optimize_game":lst,
                                      "bei": 1,
                                      "type": "f",
                                      "mode":4,
                                      "num":order_money/2
                                    });
                                    if (res.data["code"] == 200) {
                                      JumpAnimation().jump(
                                          success(res.data["data"],"f"), context);
                                    } else {
                                      Toast.toast(context,
                                          msg: res.data["msg"]);
                                      return;
                                    }
                                  }).showDioLog();
                                },
                                child: Text("立即付款",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
  String getAwardRange(){
    List ls = [];
    double m = 0;

    lst.forEach((element) {
      ls.add(element["award"]);
      m+=element["award"];
    });
    List sz = [];
    lst.forEach((element) {

    List data = element["data"];


    sz.add({"attr":data[0]["attr"],"award":element["award"]});

    ls.add(element["award"]);
    m+=element["award"];
    });
    print(sz);
    ls.sort((left, right) => left.compareTo(right));
    double s1 = ls.first;
    return s1.toStringAsFixed(2)+"~"+m.toStringAsFixed(2);
  }
  List<GestureDetector> getData(){


    return lst.asMap().keys.map((e){
      List data = lst[e]["data"];
      double award = lst[e]["award"];
      String num = (lst[e]["award"]/lst[e]["base_award"]).toStringAsFixed(0);
     return GestureDetector(
       onTap: (){
         setState(() {
           lst[e]["is_show"] = lst[e]["is_show"]==false?true:false;
         });
       },
       child: Column(
         children: <Widget>[
           Row(
             children: <Widget>[
               Row(

                 children: <Widget>[
                   Container(
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(60),
                     child: widget.chuan>0?Text(data.length.toString()+"串1 "):Text("单关"),
                   ),
                   Container(
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(140),
                     child: Wrap(
                       direction: Axis.vertical,
                       crossAxisAlignment: WrapCrossAlignment.center,
                       children: <Widget>[
                         widget.chuan>0?Text(data[0]["h_name"]+"|"+data[0]["value"],style: TextStyle(fontSize: 10),):Text(data[0]["h_name"]+"|"+data[0]["value"],style: TextStyle(fontSize: 10),),
                         widget.chuan>0?Text(data[1]["h_name"]+"|"+data[1]["value"],style: TextStyle(fontSize: 10),):Text("单注组合",style: TextStyle(fontSize: 10)),
                         lst[e]["is_show"] == false? Icon(Icons.arrow_drop_down,color: Colors.grey,):Icon(Icons.arrow_drop_up,color: Colors.grey,)
                       ],
                     ),
                   ),
                 ],
               ),
               Row(
                 children: <Widget>[
                   Container(

                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(130),
                     child: Container(
                       width: ScreenUtil().setWidth(160),
                       height: ScreenUtil().setHeight(25),
                       margin: EdgeInsets.only(left: 15, right: 15),
                       child: Row(
                         children: <Widget>[
                           GestureDetector(
                             onTap: () {


                               if (order_money > lst.length*2 ) {
                                 if(int.parse(num)>1){
                                   setState(() {
                                     order_money -= 2;
                                     lst[e]["award"] -= lst[e]["base_award"];

                                   });
                                 }
                               }
                             },
                             child: Container(
                               padding: EdgeInsets.only(left: 5, right: 5),
                               color: Colors.grey,
                               height: ScreenUtil().setHeight(25),
                               alignment: Alignment.center,
                               child: Text(
                                 "—",
                                 style: TextStyle(color: Colors.white),
                               ),
                             ),
                           ),
                           Expanded(
                             child: TextField(
                               enabled: false,
                               //限制2长度],//只允许输入数字
                               onChanged: (e) {
                                 setState(() {
                                   order_money = int.parse(e);
                                   if(order_money<lst.length*2){
                                     order_money = lst.length*2;
                                   }
                                 });
                               },
                               controller: TextEditingController.fromValue(
                                   TextEditingValue(
                                       text:
                                       '${num == null ? "" : num}',
                                       selection: TextSelection.fromPosition(
                                           TextPosition(
                                               affinity:
                                               TextAffinity.downstream,
                                               offset: '${num}'.length)))),
                               keyboardType: TextInputType.number,
                               //键盘类型，数字键盘

                               decoration: InputDecoration(

                                 contentPadding: EdgeInsets.only(left: 15),
                                 hintText: "",
                                 border: OutlineInputBorder(
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(0))),
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: () {
                               setState(() {
                                 order_money += 2;
                                 lst[e]["award"] += lst[e]["base_award"];
                                 now_index.add(lst[e]["index"]);
                               });
                             },
                             child: Container(
                               padding: EdgeInsets.only(left: 5, right: 5),
                               color: Colors.grey,
                               height: ScreenUtil().setHeight(25),
                               alignment: Alignment.center,
                               child: Text(
                                 "+",
                                 style: TextStyle(color: Colors.white),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                   Container(
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(70),
                     child: Text(lst[e]["award"].toStringAsFixed(2)),
                   ),
                 ],
               ),
             ],
           ),
          Offstage(
             offstage: lst[e]["is_show"],
             child: Container(
               color: Color(0xfffaffe3),
               child: Column(
                 children: data.asMap().keys.map((e){
                   String week = data[e]["week"].toString().substring(0,1);
                   String number = data[e]["week"].toString().substring(1,4);
                   return  Row(
                     children: <Widget>[
                       Row(

                         children: <Widget>[
                           Container(
                             alignment: Alignment.center,
                             width: ScreenUtil().setWidth(60),
                             child: Text("周"+num_to_cn[week]+number,style: TextStyle(fontSize: 12),),
                           ),
                           Container(
                             alignment: Alignment.center,
                             width: ScreenUtil().setWidth(140),
                             child: Text(data[e]["h_name"].toString(),style: TextStyle(fontSize: 12),),
                           ),
                         ],
                       ),
                       Row(
                         children: <Widget>[
                           Container(
                             alignment: Alignment.center,
                             width: ScreenUtil().setWidth(130),
                             child: Text(data[e]["a_name"].toString(),style: TextStyle(fontSize: 12),),
                           ),
                           Container(
                             alignment: Alignment.center,
                             width: ScreenUtil().setWidth(70),
                             child:  widget.chuan>0?Text(data[e]["value"].toString()+" "+data[e]["pl"].toString(),style: TextStyle(fontSize: 12),):Text(data[e]["value"].toString()+"  "+data[e]["pl"].toString(),style: TextStyle(fontSize: 12),),
                           ),
                         ],
                       ),
                     ],
                   );
                 }).toList(),
               ),
             ),
           )
         ],
       ),
     );
    }).toList();
  }
}
