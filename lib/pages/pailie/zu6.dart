import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/pages/pailie/plOrder.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';

class zu6 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return zu6_();
  }
}
class zu6_ extends State<zu6>{
  List num = [0,1,2,3,4,5,6,7,8,9];
  List s1 = [];
  List s2 = [];
  List s3 = [];
  int zhu = 0;
  int money = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 5,
          runSpacing: 15,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5,top: 5),
              child: Text("至少选择3个号，猜对开奖号(顺序不限)即中173元"),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15,top: 10),
                    child: Text("选号"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: 250,
                    child: GridView.count(
                      mainAxisSpacing:10,
                      crossAxisSpacing: 15,
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      children: getNum(s1),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(left: 15,right: 10,top: 5,bottom: 5),
            color: Colors.black87,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      s1 = [];
                    });
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.delete,color: Colors.white,),
                        Text("清空",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                ),
                Text("共"+getZhu()+"注"+getMoney()+"元",style: TextStyle(color: Colors.white),),
                GestureDetector(
                  onTap: (){
                    if(int.parse(getZhu())>0){
                     JumpAnimation().jump(plOrder(zhu: int.parse(getZhu()),s1:s1,s2:s2,s3:s3,type: 3,), context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(      color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(2))),
                    padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    child: Text("选好了",style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  getZhu(){
    if(s1.length>2){
      return int.parse(((s1.length*(s1.length-1)*(s1.length-2))/6).toStringAsFixed(0)).toString();
    }else{
      return "0";
    }
  }
  getMoney(){
    return (int.parse(getZhu())*2).toString();
  }
  getNum(List list){
      return num.asMap().keys.map((e){
        return  GestureDetector(
          onTap: (){
            setState(() {
              if(list.contains(e)){
                list.remove(e);
              }else{
                list.add(e);
              }
            });
          },
          child: ClipOval(
            child: Container(
              decoration: BoxDecoration(
                color: list.contains(e)?Colors.red:Colors.white,
              ),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow:( [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 20.0), //阴影xy轴偏移量
                        blurRadius: 20.0, //阴影模糊程度
                        spreadRadius: 5.0 //阴影扩散程度
                    )
                  ]),
                ),
                child: Text(e.toString(),style: TextStyle(color: list.contains(e)?Colors.white:Colors.red,),),
              ),
            ),
          ),
        );
      }).toList();
  }
}