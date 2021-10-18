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
import 'package:flutterapp2/pages/success.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class sendPlOrder extends StatefulWidget  {

  int bei;
  int type;
  int num;
  String content;
  sendPlOrder( {this.num, this.bei, this.type, this.content} );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sendPlOrder_();
  }
}

class sendPlOrder_ extends State<sendPlOrder> {


  double min_yj = 5;
  double max_yj = 10;
  double yj = 5;
  int start_money;
  int self_money;
  String plan_title;
  String plan_desc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      start_money = widget.num * 2;
      self_money = widget.num * 2 * widget.bei;
    });
  }
  static TextEditingController _controller = TextEditingController();
  static TextEditingController _controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    // TODO: implement build
    return FlutterEasyLoading(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text(
            "发起订单",
            style: TextStyle(fontSize: ScreenUtil().setSp(18)),
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
           Container(
             margin: EdgeInsets.all(15),
             child:  ListView(
               children: <Widget>[
                 Container(
                   child: Row(
                     children: <Widget>[
                       Text("自购金额   "),
                       Text(
                         self_money.toString(),
                         style: TextStyle(color: Colors.red),
                       ),
                       Text("元"),
                     ],
                   ),
                 ),
                 Divider(height: 20,),
                 Container(
                   margin: EdgeInsets.only(top: 15),
                   child: Row(
                     children: <Widget>[
                       Text("中奖佣金"),
                       Container(
                         width: ScreenUtil().setWidth(160),
                         height: ScreenUtil().setHeight(48),
                         margin: EdgeInsets.only(left: 15, right: 15),
                         child: Row(
                           children: <Widget>[
                             GestureDetector(
                               onTap: () {
                                 if (yj > min_yj) {
                                   setState(() {
                                     yj--;
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
                                 //限制2长度],//只允许输入数字
                                 onChanged: (e) {
                                   setState(() {
                                     yj = double.parse(e);
                                   });
                                 },
                                 controller: TextEditingController.fromValue(
                                     TextEditingValue(
                                         text:
                                         '${this.yj == null ? "" : this.yj}',
                                         selection: TextSelection.fromPosition(
                                             TextPosition(
                                                 affinity:
                                                 TextAffinity.downstream,
                                                 offset: '${this.yj}'.length)))),
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
                                 if (yj < max_yj) {
                                   setState(() {
                                     yj++;
                                   });
                                 }
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
                             Text("%")
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 Divider(height: 20,),
                 Container(
                   margin: EdgeInsets.only(top: 15),
                   child: Row(
                     children: <Widget>[
                       Text("起跟金额"),
                       Container(
                         width: ScreenUtil().setWidth(250),
                         height: ScreenUtil().setHeight(48),
                         margin: EdgeInsets.only(left: 15, right: 15),
                         child: Row(
                           children: <Widget>[
                             GestureDetector(
                               onTap: () {
                                 if (start_money > widget.num * 2) {
                                   setState(() {
                                     start_money -=widget.num*2;
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
                             Container(
                               decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: 1)),
                               alignment: Alignment.center,
                               width: ScreenUtil().setWidth(80),
                               height: ScreenUtil().setHeight(48),
                               child: Text(start_money.toString()),
                             ),
                             GestureDetector(
                               onTap: () {

                                 if (start_money < self_money) {
                                   setState(() {
                                     start_money+=widget.num*2;
                                     if(start_money>self_money){
                                       start_money = self_money;
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
                                   "+",
                                   style: TextStyle(color: Colors.white),
                                 ),
                               ),
                             ),
                             GestureDetector(
                               onTap: () {
                                 if (start_money < self_money) {
                                   setState(() {
                                     start_money+=widget.num*4;
                                     if(start_money>self_money){
                                       start_money = self_money;
                                     }
                                   });
                                 }
                               },
                               child: Container(
                                 margin: EdgeInsets.only(left: 1),
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
                     ],
                   ),
                 ),
                 Divider(height: 20,),

                 Container(

                   margin: EdgeInsets.only(top: 15),
                   child: Row(
                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.only(right: 15),
                         child: Text("方案标题"),
                       ),
                       Expanded(
                         child: TextField(

                           onChanged: (e) {
                             setState(() {
                               plan_title = e;
                             });

                           },
                           controller: _controller,
                           decoration: InputDecoration(
                             hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                             border: OutlineInputBorder(),
                             contentPadding: EdgeInsets.only(left: 10),
                             hintText:"请输入标题(20字以内)",
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
                 Divider(height: 20,),
                 Container(

                   margin: EdgeInsets.only(top: 15),
                   child: Row(
                     children: <Widget>[
                       Container(
                         margin: EdgeInsets.only(right: 15),
                         child: Text("方案描述"),
                       ),
                       Expanded(
                         child: TextField(

                           onChanged: (e) {
                             setState(() {
                               plan_desc = e;
                             });

                           },
                           controller: _controller1,
                           decoration: InputDecoration(
                             hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                             border: OutlineInputBorder(),
                             contentPadding: EdgeInsets.only(left: 10),
                             hintText:"最多可输入50字",
                           ),
                         ),
                       )
                     ],
                   ),
                 ),
               ],
             ),
           ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration:
                    BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text("共"),
                        Text(
                          self_money.toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                        Text("元")
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                         EventDioLog("提示","确认付款",context,() async {
                           ResultData res =
                               await HttpManager.getInstance()
                               .post("doplorder", params: {
                             "num": widget.num,
                             "bei": widget.bei,
                             "type": widget.type,
                             "start_money":start_money,
                             "win_yj":yj,
                             "mode":2,
                             "plan_title":plan_title,
                             "plan_desc":plan_desc,
                              "content":widget.content
                           });
                           if (res.data["code"] == 200) {
                             JumpAnimation().jump(
                                 success(res.data["data"],"pl"), context);
                           } else {
                             Toast.toast(context,
                                 msg: res.data["msg"]);
                             return;
                           }
                         }).showDioLog();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        color: Colors.red,
                        child: Text(
                          "付款",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
