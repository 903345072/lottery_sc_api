import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/wiget/IconInput.dart';

import '../Sender.dart';

class flow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return flow_();
  }
}

class flow_ extends State<flow> {
  List hot = [];
  Map<String, Object> idCard =  {
    "value": "",
    "title": "请输入用户名1",
    "tip": "请输入用户名 如: 张顺飞",
    "icon": Icon(Icons.search, color: Colors.grey),
    "is_edit": false,
    "type":null
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadinfo();
  }
  loadinfo() async{
    ResultData result = await HttpManager.getInstance()
        .get("my_flow", withLoading: false);
    if(result.data["data"] != null){
      setState(() {
        hot = result.data["data"];
      });
    }
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
        title: Text(
          "我的关注",
          style: TextStyle(fontSize: ScreenUtil().setSp(18)),
        ),
      ),
      body: ListView(
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                padding: EdgeInsets.only(top: 15,left: 15),
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Wrap(
                        children: hot.asMap().keys.map((e){
                          return GestureDetector(
                            onTap: () async {
                              JumpAnimation().jump(Sender(uid: hot[e]["uid"],), context);
                              //热搜加1
                              ResultData result = await HttpManager.getInstance()
                                  .get("add_hot",params: {"uid":hot[e]["uid"]}, withLoading: false);
                              loadinfo();
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5),
                              width: 500,
                              height: 75,
                              child: Card(

                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(border: Border.all(width: 3,color: Colors.yellow),borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(55)))),

                                      margin: EdgeInsets.only(left: 10,right: 15),
                                      child: ClipOval(

                                          child: Image.network(

                                            hot[e]["avatar"],
                                            fit: BoxFit.fill,
                                            width: ScreenUtil().setWidth(55),
                                            height: ScreenUtil().setWidth(55),
                                          )),
                                    ),
                                    Text(hot[e]["real_name"]),
                                    Container(
                                      padding: EdgeInsets.only(top: 1,bottom: 1,left: 10,right: 10),
                                      margin: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(border: Border.all(color: Colors.red,width: 0.2),borderRadius: BorderRadius.all(Radius.circular(18))),
                                      child: Text(hot[e]["all_count"].toString()+"中"+hot[e]["win_count"].toString(),style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.bold),),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  
}

