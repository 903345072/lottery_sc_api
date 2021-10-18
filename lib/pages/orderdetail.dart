import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/myorder.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/utils/request.dart';
import 'package:flutter/services.dart';
import 'ChildItemView.dart';
import 'flowUsers.dart';
class orderdetail extends StatefulWidget{
  int id;
  int type = 1;
  String f_or_b;
  orderdetail(this.id,this.type,this.f_or_b);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new hangqing_();
  }

}
class hangqing_ extends State<orderdetail>{
  Map game ={};
  Map order= {};
  Map es = {};
  int chang;
  List<String> containers = ["方案详情","跟单列表"];
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
  Map num_to_cn = {"1":"一","2":"二","3":"三","4":"四","5":"五","6":"六","7":"末"};
  @override
  void initState() {
    super.initState();
    order["avatar"] = "http://www.voyork.cn/uploads/store/comment/202104061948036361.jpg";
    getOrderDetail();
    getFlowUser();
  }
  getFlowUser() async {
    ResultData res = await HttpManager.getInstance().get("getFlowUser",params: {"order_id":widget.id},withLoading: false);
    setState(() {
      if(res.data["data"] != null && res.data["data"] != {}){
        data = res.data["data"];

      }

    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.type==1?"普通投注详情":widget.type==2?"发单投注详情":widget.type==3?"跟买投注详情":"优化投注详情",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        backgroundColor: Color(0xfffa2020),

      ),

      body: Column(
        children: <Widget>[
            Expanded(
              child: ListView(
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

                              child:order["avatar"]!=null? Image.network(
                                order["avatar"],
                                fit: BoxFit.fill,
                                width: ScreenUtil().setWidth(55),
                                height: ScreenUtil().setWidth(55),
                              ):Container()),
                        ),

                        Wrap(
                          spacing: 5,
                          direction: Axis.vertical,
                          children: <Widget>[
                            Text(order["real_name"].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 0.2)),
                                  padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                                  child: Text(order["all_count"].toString()+"中"+order["win_count"].toString(),style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.bold),),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5,right: 5,top: 1,bottom: 1),
                                  decoration: BoxDecoration(color: Colors.red),
                                  child: Text("盈利"+order["win_rate"].toString()+"%",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
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
                    padding: EdgeInsets.only(left: 20,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        order["mode"] =="2"? Text(order["plan_title"].toString()!=""?order["plan_title"].toString():"跟我一起中大奖"):Container(child: Text("暂无描述",style: TextStyle(color: Colors.grey),),),
                        order["state"] == 2?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("img/zhongjiang.png",fit: BoxFit.fill,width: 70,),
                            Text(order["award_money"].toString()+"元",style: TextStyle(color: Colors.red,fontSize: 11),)
                          ],
                        ):order["state"] == 1?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("img/weizhongjiang.png",fit: BoxFit.fill,width: 70),
                          ],
                        ):order["state"] == 0?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("img/weikaijiang.png",fit: BoxFit.fill,width: 70),
                          ],
                        ):Container()
                      ],
                    ),
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
                            Text(order["chuan"]!=""?order["chuan"].toString()+"串1":"单关",style: TextStyle(color: Colors.black),),

                            order["mode"] =="2"?Text("佣金: "+order['win_yj'].toString()+"%",style: TextStyle(color: Colors.grey),):Container(),


                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Text("订单编号:"+order["order_no"].toString()),
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
                                child:  Text('订单金额',textAlign: TextAlign.center,),
                              ),
                              Container(
                                padding:EdgeInsets.only(top: 5,bottom: 5),
                                child:  Text('奖金',textAlign: TextAlign.center,),
                              ),

                            ]
                        ),
                        TableRow(
                            children: [
                              Container(
                                padding:EdgeInsets.only(top: 5,bottom: 5),
                                child: Text(order["type"]=="f"?"竞彩足球":"竞彩篮球",textAlign: TextAlign.center,),
                              ),
                              Container(
                                padding:EdgeInsets.only(top: 5,bottom: 5),
                                child: Text(order["amount"].toString()+"元",textAlign: TextAlign.center,),
                              ),
                              Container(
                                padding:EdgeInsets.only(top: 5,bottom: 5),
                                child: Text(order["award_money"]!=null?order["award_money"].toString()+"元":"--",textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),
                              )
                            ]
                        ),
                      ],
                    ),
                  ),
                  Container(


             
                    decoration: BoxDecoration(color:Colors.white,border: Border(bottom: BorderSide(width: 5,color: Color(0xfff5f5f5)))),

                    child: Column(
                      children: <Widget>[
                        order["mode"] =="2" ? Container(

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
                                        Text(order["all_amount"].toString()+"元",style: TextStyle(color: Colors.red),)
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Wrap(
                                        spacing: 15,
                                        children: <Widget>[
                                          Text("佣金收入: "+ formatNum(order['yj_amount'], 2)+"元",style: TextStyle(color: Colors.red),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ):Container(),
                        order["mode"] =="2"  ?Divider():Container(),
                        order["mode"] == "4"?Container(
                          color: Colors.white,
                          child: Container(
                            child: Container(

                              child: ExpansionTile(

                                backgroundColor:Colors.white,
                                key: PageStorageKey(2),
                                initiallyExpanded:true,
                                title: Text("选号详情",style: TextStyle(fontSize: 12),),
                                children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10),top: 5,bottom: 5),
                                    decoration: BoxDecoration(color: Color(0xfffff5f8)),
                                    width: ScreenUtil().setWidth(410),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil().setWidth(60),
                                          child: Text("场次"),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(95),
                                          child: order["type"] =="f"?Text("主队VS客队"):Text("客队VS主队"),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(75),
                                          child: Text("玩法"),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(95),
                                          child: Text("投注"),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(60),
                                          child: Text("彩果"),
                                        )
                                      ],
                                    ),),
                                  Container(
                                    color: Color(0xffebebeb),
                                    width: ScreenUtil().setWidth(410),
                                    child: Column(
                                      children: getList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ):Container(),
                        order["mode"] =="2" ?  Container(
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


                                  child: Container(

                                    child: ExpansionTile(

                                      backgroundColor:Colors.white,
                                      initiallyExpanded:true,
                                      title: Text("选号详情",style: TextStyle(fontSize: 12),),
                                      children: <Widget>[
                                     Container(
                                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10),top: 5,bottom: 5),
                                          decoration: BoxDecoration(color: Color(0xfffff5f8)),
                                          width: ScreenUtil().setWidth(410),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: ScreenUtil().setWidth(60),
                                                child: Text("场次"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(95),
                                                child: order["type"] =="f"?Text("主队VS客队"):Text("客队VS主队"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(75),
                                                child: Text("玩法"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(95),
                                                child: Text("投注"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(60),
                                                child: Text("彩果"),
                                              )
                                            ],
                                          ),),
                                        Container(
                                          color: Color(0xffebebeb),
                                          width: ScreenUtil().setWidth(410),
                                          child: Column(
                                            children: getList(),
                                          ),
                                        )
                                      ],
                                    ),
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
                        ):Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                             order["mode"] =="3"?  getList().length>0 ? Visibility(
                                visible: this.page==0,
                                child: Container(
                                  child: Container(
                                    child: ExpansionTile(

                                      backgroundColor:Colors.white,
                                      initiallyExpanded:order["mode"] == "4"?true:false,
                                      title: Text("选号详情",style: TextStyle(fontSize: 12),),
                                      children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10),top: 5,bottom: 5),
                                          decoration: BoxDecoration(color: Color(0xfffff5f8)),
                                          width: ScreenUtil().setWidth(410),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: ScreenUtil().setWidth(60),
                                                child: Text("场次"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(95),
                                                child: order["type"] =="f"?Text("主队VS客队"):Text("客队VS主队"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(75),
                                                child: Text("玩法"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(95),
                                                child: Text("投注"),
                                              ),
                                              Container(
                                                width: ScreenUtil().setWidth(60),
                                                child: Text("彩果"),
                                              )
                                            ],
                                          ),),
                                        Container(
                                          color: Color(0xffebebeb),
                                          width: ScreenUtil().setWidth(410),
                                          child: Column(
                                            children: getList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ):Container(
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
                              ):Visibility(

                               visible: this.page==0,
                               child: Container(
                                 child: Container(
                                   child: order["mode"] == "4"? ExpansionTile(
                                     initiallyExpanded: true,
                                     backgroundColor:Colors.white,

                                     title: Text("优化详情",style: TextStyle(fontSize: 12),),
                                     children: <Widget>[
                                       Container(
                                         padding: EdgeInsets.only(top: 5,bottom: 5),
                                         decoration: BoxDecoration(color: Color(0xfffff5f8)),
                                         width: ScreenUtil().setWidth(410),
                                         child: Row(

                                           children: <Widget>[
                                             Container(
                                               alignment: Alignment.center,
                                               width: ScreenUtil().setWidth(60),
                                               child: Text("串法"),
                                             ),
                                             Container(
                                               alignment: Alignment.center,
                                               width: ScreenUtil().setWidth(60),
                                               child: Text("注数"),
                                             ),
                                             Container(
                                               alignment: Alignment.center,
                                               width: ScreenUtil().setWidth(60),
                                               child: Text("玩法"),
                                             ),
                                             Container(
                                               alignment: Alignment.center,
                                               width: ScreenUtil().setWidth(150),
                                               child: Text("投注"),
                                             ),
                                             Container(
                                               alignment: Alignment.center,
                                               width: ScreenUtil().setWidth(80),
                                               child: Text("赛果"),
                                             ),

                                           ],
                                         ),),
                                       Container(
                                         color: Color(0xffebebeb),
                                         width: ScreenUtil().setWidth(410),
                                         child: Column(
                                           children: getOptList(),
                                         ),
                                       )
                                     ],
                                   ):ExpansionTile(


                                     backgroundColor:Colors.white,

                                     initiallyExpanded: true,
                                     title: Text("选号详情",style: TextStyle(fontSize: 12),),
                                     children: <Widget>[
                                      Container(
                                         padding: EdgeInsets.only(left: ScreenUtil().setWidth(10),top: 5,bottom: 5),
                                         decoration: BoxDecoration(color: Color(0xfffff5f8)),
                                         width: ScreenUtil().setWidth(410),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: <Widget>[
                                             Container(
                                               width: ScreenUtil().setWidth(60),
                                               child: Text("场次"),
                                             ),
                                             Container(
                                               width: ScreenUtil().setWidth(95),
                                               child: order["type"] =="f"?Text("主队VS客队"):Text("客队VS主队"),
                                             ),
                                             Container(
                                               width: ScreenUtil().setWidth(75),
                                               child: Text("玩法"),
                                             ),
                                             Container(
                                               width: ScreenUtil().setWidth(95),
                                               child: Text("投注"),
                                             ),
                                             Container(
                                               width: ScreenUtil().setWidth(60),
                                               child: Text("彩果"),
                                             )
                                           ],
                                         ),),
                                       Container(
                                         color: Color(0xffebebeb),
                                         width: ScreenUtil().setWidth(410),
                                         child: Column(
                                           children: getList(),
                                         ),
                                       )
                                     ],
                                   ),
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
                  order["is_self"] == 1?Container(
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(child: Text("实体票照片"),),
                        order["order_pic"] != null && order["order_pic"] != ""?Container(
                          margin: EdgeInsets.only(top: 10,bottom: 20),
                          child: Image.network(order["order_pic"]),
                        ):Container(
                          margin: EdgeInsets.only(top: 10,bottom: 20),
                          child: Text("等待店主上传"),
                        )
                      ],
                    ),
                  ):Container(),

                  
                ],
              ),
            ),

        ],
      ),
    );
  }
  getbool(){

    if(order["mode"] == "4"){

      return false;
    }
    return true;
  }
  getChang(){
    if(order["mode"] != "4"){
      return game.length.toString()+"场";
    }else{
      List s = game["data"];
      List s1 = [];
      s.forEach((element) {
        List s2 = element["bet_content"];
        s2.forEach((element1) {
          s1.add(element1["id"]);
        });
      });
      var dedu = new Set();
      dedu.addAll(s1);
      s1 = dedu.toList();
      return s1.length.toString()+"场";
    }
  }
  List<Container> getOptList(){

    List ls = game["data"];

    print(ls);

    return ls.asMap().keys.map((e) {
      List lst = ls[e]["bet_content"];
      return Container(

        alignment: Alignment.center,
        decoration: BoxDecoration(border:Border(top: BorderSide(width: 0.1),right: BorderSide(width: 0.1),left: BorderSide(width: 0.1),bottom:BorderSide(width: 0.1))),

        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            Container(

              alignment: Alignment.center,
              width: ScreenUtil().setWidth(60),
              child: lst.length==1?Text("单关"):Text(lst.length.toString()+"串1"),
            ),

            Container(
              decoration: BoxDecoration(border:Border(left: BorderSide(width: 0.1))),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(border:Border(right: BorderSide(width: 0.1))),
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(60),
                    child: Text(ls[e]["num"].toString()+"注"),
                  ),
                  Column(
                    children: lst.asMap().keys.map((e1){
                      return Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(border:Border(right: BorderSide(width: 0.1),left: BorderSide(width: 0.1),bottom: BorderSide(width: 0.1))),
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(60),
                            child: Text(lst[e1]["name"].toString()),
                          ),
                          Container(
                            decoration: BoxDecoration(border:Border(right: BorderSide(width: 0.1),left: BorderSide(width: 0.1),bottom: BorderSide(width: 0.1))),
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(150),
                            child: Text(lst[e1]["h_name"].toString()+"("+lst[e1]["value"].toString()+")"),
                          ),
                          Container(
                            decoration: BoxDecoration(border:Border(right: BorderSide(width: 0.1),left: BorderSide(width: 0.1),bottom: BorderSide(width: 0.1))),
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(79),
                            child: Text(lst[e1]["caiguo"].toString(),style: TextStyle(color: lst[e1]["ret"]==0?Colors.black:Colors.red),),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();



  }
 List getList(){
    String keys;
    String week ;
    String order_no ;
    String h_name ;
    String a_name ;
    String bifen ;
    int num;
Map data;
if(order["mode"] == "4"){
  data = es;
}else{
  data = game;
}

    return data.keys.map((e){
      Map s = data[e];
      num = 0;
      s.forEach((key, value) {
         week = s[key][0]["time"].toString().substring(0,1);
         order_no = s[key][0]["time"].toString().substring(1,4);
         h_name = s[key][0]["h_name"].toString();
         a_name = s[key][0]["a_name"].toString();
         bifen = s[key][0]["bifen"].toString();
         List z = s[key];

         z.forEach((element) {
           num++;
         });

      });
  int height = num*75;

    return  Container(


      decoration: BoxDecoration(border:Border(top: BorderSide(width: 0.1),right: BorderSide(width: 0.1),left: BorderSide(width: 0.1),bottom:BorderSide(width: 0.1))),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

              Container(
                height: ScreenUtil().setHeight(height),

                alignment: Alignment.center,
                width: ScreenUtil().setWidth(60),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("周"+num_to_cn[week]),
                    Text(order_no),
                  ],
                ),
              ),


          Container(
            height: ScreenUtil().setHeight(height),

            decoration: BoxDecoration(border:Border(left: BorderSide(width: 0.1))),
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(95),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Text(order["type"]=="f"?h_name:a_name,style: TextStyle(fontSize: ScreenUtil().setSp(13),height: 1.2),),
                Text(bifen,style: TextStyle(fontSize: ScreenUtil().setSp(13),height: 1.2)),
                Text(order["type"]=="f"?a_name:h_name,style: TextStyle(fontSize: ScreenUtil().setSp(13),height: 1.2)),
              ],
            ),
          ),
          Container(


            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getRow(s,height),
            ),
          ),


        ],
      ),
    );
    }).toList();
  }
 List<Widget> getRow(Map s,int heights){
     String p_goal;
     String rf = "-500";
     bool is_right = false;

     return s.keys.map((e){
       List ls = s[e];

       ls.forEach((element) {
         if(element["ret"] == 1){
          s[e][0]["is_right"] = true;
         }
       });
       p_goal = ls[0]["p_goal"];

       List pg = p_goal.toString().split(",");
       List meth_id = ls[0]["method_id"].toString().split("-");

       if(order["type"] == "f"){
         if(meth_id[0] == "2"){
           if(pg.length == 1){
              rf = pg[0];
           }else{
             rf = pg[1];
           }
         }else{
           rf = "-500";
         }
       }else{
         if(meth_id[0] == "2"){
           rf = pg[1];
         }else if(meth_id[0] == "5"){
           rf = pg[3];
         }else{
           rf = "-500";
         }
       }

      return Container(
        decoration: BoxDecoration(border:Border(bottom: BorderSide(width: 0.1),left: BorderSide(width: 0.1))),
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(


              alignment: Alignment.center,
              width: ScreenUtil().setWidth(75),
              child: Column(
                children: <Widget>[
                  Text(e.toString()),
                  rf!="-500"?Text("("+ rf + ")"):Container()
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(95),

              alignment: Alignment.center,
              child: Column(

                children: ls.asMap().keys.map((e2){

                  return Container(
                    decoration: BoxDecoration(border:Border(right: BorderSide(width: 0.1),left: BorderSide(width: 0.1))),
                    height: ScreenUtil().setHeight(75),
                    alignment: Alignment.center,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(ls[e2]["bet_value"].toString()),
                        Text(ls[e2]["pl"].toString()),

                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(84),
              child: Text(ls[0]["caiguo"].toString(),style: TextStyle(color: s[e][0]["is_right"]==true?Colors.red:Colors.grey),),
            ),

          ],
        ),
      );
     }).toList();
  }
  getOrderDetail() async {
    ResultData res = await HttpManager.getInstance().get("getOrderDetail",params: {"id":widget.id},withLoading: false);

    setState(() {
      order = res.data["order"];
      if(res.data["detail"].length>0){
        game = res.data["detail"];
        if(res.data["es"] != null && res.data["es"].length>0){
          es = res.data["es"];
        }else{
          es = {};
        }


      }else{
        game = {};
        es = {};
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
              child:  Text(data[e]["state"]==2?data[e]["award_money"].toString():"0",textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),
            ),
            Container(
              padding:EdgeInsets.only(top: 5,bottom: 5),
              child:  Text(data[e]["state"]==2?formatNum(data[e]["yj"], 2):"0",textAlign: TextAlign.center),
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
  String formatNum(num num,int postion){
    if(num ==0){
      return "0";
    }
    List l = num.toString().split(".");
    if(l != null){
      if(l.length>1){
        if(l[1].toString().length==1){
          return num.toString();
        }
      }
    }
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }else{
      return num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
    }
  }

}