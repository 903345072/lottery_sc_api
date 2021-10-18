import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/pailie/sendPlOrder.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Toast.dart';

import '../success.dart';

class plOrder extends StatefulWidget{
  List s1 = [];
  List s2 = [];
  List s3 = [];
  int zhu = 0;
  int type = 1;
  plOrder({this.zhu,this.s1,this.s2,this.s3,this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return plOrder_();
  }
}
class plOrder_ extends State<plOrder>{


  int bei = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("确认投注",style: TextStyle(fontSize: 17),),
        backgroundColor: Color(0xfffa2020),
      ),
      body: FlutterEasyLoading(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Wrap(
                  children: <Widget>[
                    Text(getText(),style: TextStyle(color: Colors.red),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widget.type==1?Text("直选普投"):widget.type==2?Text("组3复式"):Text("组6普投"),
                        Text("共"+getZhu()+"注"+getMoney()+"元"),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey,width: 0.3))),
                    padding: EdgeInsets.all(10),
                    child: Wrap(
                      spacing: 15,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text("投"),
                        GestureDetector(

                          onLongPressUp: (){
                            setState(() {
                              if(bei>1){
                                bei = bei -5;
                              }
                              if(bei<1){
                                bei = 1;
                              }
                            });
                          },
                          onTap: (){
                            setState(() {
                              if(bei>1){
                                bei--;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                            child: Text("-"),
                          ),
                        ),
                        Container(
                          child: Text(bei.toString()),
                        ),
                        GestureDetector(

                          onLongPressUp: (){
                            bei= bei+5;
                          },
                          onTap: (){
                            setState(() {
                              bei++;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                            child: Text("+"),
                          ),
                        ),
                        Container(
                          child: Text("倍"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 10,top: 10,bottom: 10),
                    color: Colors.black87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            JumpAnimation().jump(sendPlOrder(content:getText(),num:int.parse(getZhu()),bei: bei,type: widget.type,), context);
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.all(Radius.circular(2))),
                            padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                            child: Text("发单",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        Text("共"+getZhu()+"注"+getMoney()+"元",style: TextStyle(color: Colors.white),),
                        GestureDetector(
                          onTap: () async{
                            EventDioLog("提示", "确认付款", context, () async {

                              ResultData res = await HttpManager.getInstance()
                                  .post("doplorder", params: {
                                "num": getZhu(),
                                "mode":1,
                                "bei": bei,
                                "type": widget.type,
                                "content":getText()
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
                            decoration: BoxDecoration(      color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(2))),
                            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            child: Text("提交订单",style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  getText(){
      String s1 = widget.s1.join(",");
      String s2 = widget.s2.join(",");
      String s3 = widget.s3.join(",");
      if(widget.type == 1){
        return s1+"|"+s2+"|"+s3;
      }
      return s1;
  }
  getZhu(){
    return widget.zhu.toString();
  }
  getMoney(){
    return (widget.zhu*2*bei).toString();
  }

}