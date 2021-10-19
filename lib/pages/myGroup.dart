import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';

class myGroup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myGroup_();
  }
}
class myGroup_ extends State<myGroup>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGroups();
  }
  List data = [];
  getGroups()async{
   ResultData res = await HttpManager.getInstance().get("getGroups",withLoading: false);
   if(res.data["data"] != null){
     setState(() {
       data = res.data["data"];
     });
   }
  }
  @override
  Widget build(BuildContext context) {
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
        title: Text("我的团队",style: TextStyle(fontSize: 18),),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 100,
                child: Text("昵称"),
              ),
              Container(
                alignment: Alignment.center,
                width: 140,
                child: Text("注册时间"),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: Text("自动跟单"),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              runSpacing: 15,
              children: getList(),
            ),
          )
        ],
      ),
    );
  }
  getList(){
    return data.asMap().keys.map((e){
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 100,
                child: Text(data[e]["nickname"].toString()),
              ),
              Container(
                alignment: Alignment.center,
                width: 140,
                child: Text(data[e]["add_time"].toString()),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: Text(data[e]["auto_order"]==1?"是":"否"),
              )
            ],
          ),
          Divider()
        ],
      );
    }).toList();
  }
}