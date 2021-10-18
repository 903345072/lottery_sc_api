import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexBack.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/pages/flowUsers.dart';
import 'package:flutterapp2/pages/order.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class plflowdetail extends StatefulWidget {
  Map data;
  plflowdetail(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return plflowdetail_();
  }
}

class plflowdetail_ extends State<plflowdetail> {
  List<String> containers = ["方案详情","跟单列表"];
  int cur_page = 0;
  List bei = [10,20,50,100];
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  int page = 0;
  List data = [];
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
  int num = 10;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
    getFlowUser();
  }
  getFlowUser() async {
    ResultData res = await HttpManager.getInstance().get("getPlFlowUser",params: {"order_id":widget.data["id"],"type":"pl"},withLoading: false);
    setState(() {
      if(res.data["data"] != null && res.data["data"] != {}){
        data = res.data["data"];
      }
    });
  }
  getTableRows(){
    List s = data.asMap().keys.map((e) {
      return TableRow(
          children: [
            Container(
              padding:EdgeInsets.only(top: 5,bottom: 5),
              child: Text(data[e]["real_name"],textAlign: TextAlign.center,),
            ),
            Container(
              padding:EdgeInsets.only(top: 5,bottom: 5),
              child:  Text(data[e]["amount"].toString(),textAlign: TextAlign.center,),
            ),

            Container(
              padding:EdgeInsets.only(top: 5,bottom: 5),
              child:  Text('----',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),
            ),
            Container(
              padding:EdgeInsets.only(top: 5,bottom: 5),
              child:  Text('----',textAlign: TextAlign.center),
            ),

          ]
      );
    }).toList();
    s.insert(0, TableRow(
        children: [
          Container(
            padding:EdgeInsets.only(top: 5,bottom: 5),
            child: Text('跟单用户',textAlign: TextAlign.center,),
          ),
          Container(
            padding:EdgeInsets.only(top: 5,bottom: 5),
            child:  Text('金额(元)',textAlign: TextAlign.center,),
          ),

          Container(
            padding:EdgeInsets.only(top: 5,bottom: 5),
            child:  Text('奖金(元)',textAlign: TextAlign.center,),
          ),
          Container(
            padding:EdgeInsets.only(top: 5,bottom: 5),
            child:  Text('佣金',textAlign: TextAlign.center,),
          ),

        ]
    ));
    return s;
  }
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
            size: 20.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("方案详情",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor:  Color(0xfff5f5f5),
        body:  Stack(
            children: <Widget>[
             ListView(
               children: <Widget>[
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Container(
                       decoration: BoxDecoration(color:Colors.white,border: Border(bottom: BorderSide(width: 1,color: Color(0xfff5f5f5)))),
                       padding: EdgeInsets.only(top: 5),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           Container(
                             margin: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 15),
                             child: ClipOval(
                                 child: Image.network(
                                   widget.data["avatar"],
                                   fit: BoxFit.fill,
                                   width: ScreenUtil().setWidth(55),
                                   height: ScreenUtil().setWidth(55),
                                 )),
                           ),

                           Wrap(
                             spacing: 5,
                             direction: Axis.vertical,
                             children: <Widget>[
                               Text(widget.data["nickname"],style: TextStyle(fontWeight: FontWeight.bold),),
                               Row(
                                 children: <Widget>[
                                   Container(
                                     decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 0.2)),
                                     padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                                     child: Text(widget.data["all_count"].toString()+"中"+widget.data["win_count"].toString(),style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.bold),),
                                   ),
                                   Container(
                                     padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                                     decoration: BoxDecoration(color: Colors.red),
                                     child: Text("盈利"+widget.data["win_rate"].toString()+"%",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                                   ),
                                 ],
                               )
                             ],
                           ),
                         ],
                       ),
                     ),
                     Container(
                       width: double.infinity,
                       color:Colors.white,
                       padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                       child: Text(widget.data["plan_title"].toString()!=""?widget.data["plan_title"].toString():"跟我一起中大奖"),
                     ),
                     Container(
                       width: double.infinity,
                       color:Colors.white,
                       padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Wrap(
                             spacing: 5,
                             children: <Widget>[
                               Text(widget.data["type"]!=1?"直选普投":widget.data["type"]!=2?"组3复式":"组6普投"),
                               Text("佣金: "+widget.data['win_yj'].toString()+"%",style: TextStyle(color: Colors.grey),),
                             ],
                           ),
                           Container(
                             padding: EdgeInsets.only(right: 5),
                             child: Text("订单编号:"+widget.data["order_no"]),
                           )
                         ],
                       ),
                     ),
                     Container(
                       decoration: BoxDecoration(color:Colors.white,border: Border(bottom: BorderSide(width: 15,color: Color(0xfff5f5f5)))),
                       padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                       child: Table(
                         border: TableBorder.all(
                           color: Colors.grey,
                           width: 0.08
                         ),
                         children: [
                           TableRow(
                               children: [
                                 Container(
                                   padding:EdgeInsets.only(top: 5,bottom: 5),
                                   child: Text('类型',textAlign: TextAlign.center,),
                                 ),
                                 Container(
                                   padding:EdgeInsets.only(top: 5,bottom: 5),
                                   child:  Text('自购金额',textAlign: TextAlign.center,),
                                 ),
                                 Container(
                                   padding:EdgeInsets.only(top: 5,bottom: 5),
                                   child:  Text('起投金额',textAlign: TextAlign.center,),
                                 ),
                               ]
                           ),
                           TableRow(
                               children: [
                                 Container(
                                   padding:EdgeInsets.only(top: 5,bottom: 5),
                                   child: Text("排列三",textAlign: TextAlign.center,),
                                 ),
                                 Container(
                                   padding:EdgeInsets.only(top: 5,bottom: 5),
                                   child: Text(widget.data["amount"].toString()+"元",textAlign: TextAlign.center,),
                                 ),
                                Container(
                                  padding:EdgeInsets.only(top: 5,bottom: 5),
                                  child: Text(widget.data["start_money"].toString()+"元",textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),
                                )
                               ]
                           ),
                         ],
                       ),
                     ),
                     Container(
                       margin: EdgeInsets.only(bottom: 100),
                       decoration: BoxDecoration(color:Colors.white,border: Border(bottom: BorderSide(width: 5,color: Color(0xfff5f5f5)))),
                       child: Column(
                         children: <Widget>[
                           Container(
                             child: Column(
                               children: <Widget>[
                                 Container(
                                   margin: EdgeInsets.only(left: 15,top:15),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: <Widget>[
                                       Row(
                                         children: <Widget>[
                                           Text("跟单金额: "),
                                           Text(widget.data["all_amount"].toString()+"元",style: TextStyle(color: Colors.red),)
                                         ],
                                       ),
                                       Container(
                                         margin: EdgeInsets.only(left: 15),
                                         child: Wrap(
                                           spacing: 15,
                                           children: <Widget>[
                                             Text("佣金收入: "+widget.data['yj_amount'].toString()+"元",style: TextStyle(color: Colors.red),),
                                           ],
                                         ),
                                       )
                                     ],
                                   ),
                                 ),


                               ],
                             ),
                           ),
                           Divider(),
                           Container(

                             color: Colors.white,
                             child: Column(
                               children: <Widget>[
                                 Row(
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

                                       },
                                       child: Container(
                                         padding: EdgeInsets.only(top: 7),
                                         child: Column(
                                           children: <Widget>[
                                            e==0? Container(child: Text(containers[e],style: cur_ts,),):Container(child: Text(containers[e]+"("+data.length.toString()+")",style: cur_ts,),),
                                             Container(
                                               margin: EdgeInsets.only(top: 7),
                                               decoration: cur_bd,width: 160,
                                             )
                                           ],
                                         ),
                                       ),
                                     );
                                   }).toList(),
                                 ),
                                 Visibility(

                                   visible: this.page==0,
                                   child: Container(
                                     
                                     margin: EdgeInsets.only(top: 50,bottom: 70),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: <Widget>[
                                         Icon(Icons.lock),
                                         Text("开赛后可见")
                                       ],
                                     ),
                                   ),
                                 ),
                                 Visibility(

                                   visible: this.page==1,
                                   child: Container(
                                     margin: EdgeInsets.only(top: 15),
                                     child: Table(
                                       border: TableBorder.all(
                                           color: Colors.grey,
                                           width: 0.08
                                       ),
                                       children: getTableRows(),
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),


                         ],
                       ),
                     ),
                   ],
                 ),
               ],
             ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: <Widget>[

                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[

                          Container(

                            padding: EdgeInsets.only(top: 10,left: 15,right: 15),
                            width:double.infinity,
                            child: Wrap(
                              alignment:WrapAlignment.spaceAround,

                              children: bei.asMap().keys.map((e){
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      cur_page = e;
                                      num = bei[e];
                                    });
                                  },
                                  child: e==cur_page? Container(
                                    padding: EdgeInsets.only(top: 3,right: 15,left: 15,bottom: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: Text(bei[e].toString()+"倍",style: TextStyle(color: Colors.white),),
                                  ):Container(
                                    padding: EdgeInsets.only(top: 3,right: 15,left: 15,bottom: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey)

                                    ),
                                    child: Text(bei[e].toString()+"倍",style: TextStyle(color: Colors.grey),),
                                  )
                                );
                              }).toList(),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5),
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(70),
                                child: Row(
                                  children: <Widget>[
                                    Text("购买"),
                                    Container(
                                      width: ScreenUtil().setWidth(70),
                                      height: ScreenUtil().setHeight(38),
                                      margin: EdgeInsets.only(left: 15, right: 15),

                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextField(
                                              //限制2长度],//只允许输入数字
                                              onChanged: (e) {
                                                setState(() {
                                                  num = int.parse(e) ;
                                                });
                                              },
                                              controller: TextEditingController.fromValue(
                                                  TextEditingValue(
                                                      text:
                                                      '${this.num == null ? "" : this.num}',
                                                      selection: TextSelection.fromPosition(
                                                          TextPosition(
                                                              affinity: TextAffinity.downstream,
                                                              offset: '${this.num}'.length)))),
                                              keyboardType: TextInputType.number,
                                              //键盘类型，数字键盘

                                              decoration: InputDecoration(

                                                contentPadding: EdgeInsets.only(left: 10),
                                                hintText: "",
                                                border: OutlineInputBorder(),

                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: Text("倍"),
                                    ),
                                    Text((num*widget.data["start_money"]).toString()+"元",style: TextStyle(color: Colors.red),),

                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  EventDioLog("提示","确认付款",context,() async {
                                    ResultData res = await HttpManager.getInstance().post("doFlowPlOrder",params:{"id":widget.data["id"],"num":num,});
                                    if(res.data["code"] == 200){
                                      Toast.toast(context,msg: "付款成功");
                                      JumpAnimation().jump(IndexBack(), context);
                                    }else{
                                      Toast.toast(context,msg: res.data["msg"]);
                                      return;
                                    }
                                  }).showDioLog();

                                },
                                child: Container(
                                  width: ScreenUtil().setWidth(100),
                                  alignment: Alignment.center,
                                  height: ScreenUtil().setHeight(70),
                                  color: Colors.red,
                                  child: Text("付款",style: TextStyle(color: Colors.white),),
                                ),
                              ),



                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

      ),
    );
  }
}
