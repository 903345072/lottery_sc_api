

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/pages/flowdetail.dart';
import 'package:flutterapp2/pages/orderdetail.dart';
import 'package:flutterapp2/pages/pailie/plflowdetail.dart';
import 'package:flutterapp2/pages/pailie/plorderdetail.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';

class flowlist{
 get(List data,BuildContext context){
    return Container(

      child: Container(
        margin: EdgeInsets.only(top: 330),
        child: ListView(
          children: getList(data,context),
        ),
      ),
    );
  }
 List<Container> getList(List data,BuildContext context){
   return data.asMap().keys.map((e){
     return Container(


       padding: EdgeInsets.only(bottom: 15),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(left: 10,bottom: 15,top: 5),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 //Text(data[e]["date"].toString()),
                 Text(data[e]["plan_title"].toString()!=""?data[e]["plan_title"].toString():"跟我一起中大奖"),
               ],
             ),
           ),

           Container(
             width: double.infinity,
             child: Wrap(
               crossAxisAlignment: WrapCrossAlignment.center,

               alignment: WrapAlignment.spaceAround,
               children: <Widget>[
                 Column(
                   children: <Widget>[
                     Text(data[e]["flag"]=="pl"?"排列三":data[e]["type"]=="f"?"竞彩足球":"竞彩篮球"),
                     Text("类型玩法")
                   ],
                 ),
                 SizedBox(
                   width: 0.5,
                   height: 20,
                   child: DecoratedBox(
                     decoration: BoxDecoration(color: Colors.grey),
                   ),
                 ),
                 Column(
                   children: <Widget>[
                     Text(data[e]["amount"]),
                     Text("订单金额")
                   ],
                 ),
                 SizedBox(
                   width: 0.5,
                   height: 20,
                   child: DecoratedBox(
                     decoration: BoxDecoration(color: Colors.grey),
                   ),

                 ),
                 Column(
                   children: <Widget>[
                     Text((data[e]["num"]*2).toString()),
                     Text("单倍金额")
                   ],
                 ),
                 Container(

                   alignment: Alignment.center,
                   width: ScreenUtil().setWidth(80),
                   child: getConta(data[e],context)
                 )
               ],
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: 90,top: 15,bottom: 15),
             child: Text("推单时间: "+data[e]["date"].toString(),style: TextStyle(color: Colors.grey),),
           ),
           Container(
             color: Color(0xffededed),
             height: 5,
           )
         ],
       ),
     );
   }).toList();
 }
 getConta(Map data,BuildContext context){
   if(data["flag"] == "pl"){
     if(data["state"] == 0){
      return GestureDetector(
         onTap: (){
           JumpAnimation().jump(plorderdetail(data["id"],data["mode"],"pl"), context);
         },
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
          Image.asset("img/chupiaozhong.png",fit: BoxFit.fill,width: 60,),
           ],
         ),
       );
     }

     if(data["state"] == -1 && data["is_flow"] == 1){
      return RaisedButton(
         color: Colors.red,
         onPressed: () {
           JumpAnimation().jump(plflowdetail(data), context);
         },
         child: Text('跟单',style: TextStyle(fontSize: 12.0,color: Colors.white),),
         ///圆角
         shape: RoundedRectangleBorder(
             side: BorderSide.none,
             borderRadius: BorderRadius.all(Radius.circular(5))
         ),
       );
     }
     if(data["state"] == -1 && data["is_flow"] == 0){
       return RaisedButton(
         color: Colors.red,
         onPressed: () {
           JumpAnimation().jump(plflowdetail(data), context);
         },
         child: Text('跟单',style: TextStyle(fontSize: 12.0,color: Colors.white),),
         ///圆角
         shape: RoundedRectangleBorder(
             side: BorderSide.none,
             borderRadius: BorderRadius.all(Radius.circular(5))
         ),
       );
     }


     if(data["state"] == 1){
       return GestureDetector(
         onTap: (){
           JumpAnimation().jump(plorderdetail(data["id"],data["mode"],"pl"), context);
         },
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Image.asset("img/weizhongjiang.png",fit: BoxFit.fill,width: 60,),
           ],
         ),
       );
     }

     if(data["state"] == 2){
       return GestureDetector(
         onTap: (){
           JumpAnimation().jump(plorderdetail(data["id"],data["mode"],'pl'), context);
         },
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Image.asset("img/zhongjiang.png",fit: BoxFit.fill,width: 60,),
             Text(data["money"].toString()+"元",style: TextStyle(color: Colors.red,fontSize: 11),)
           ],
         ),
       );
     }

   }else{
     return data["state"] == 0 ? data["is_flow"] == 1 ?RaisedButton(
       color: Colors.red,
       onPressed: () {
         JumpAnimation().jump(flowdetail(data), context);
       },
       child: Text('跟单',style: TextStyle(fontSize: 12.0,color: Colors.white),),
       ///圆角
       shape: RoundedRectangleBorder(
           side: BorderSide.none,
           borderRadius: BorderRadius.all(Radius.circular(5))
       ),
     ):GestureDetector(
       onTap: (){
       JumpAnimation().jump(orderdetail(data["id"],int.parse(data["mode"]),data["type"]), context);
       },
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           data["flag"] =="ball"?Image.asset("img/weikaijiang.png",fit: BoxFit.fill,width: 60,):Image.asset("img/chupiaozhong.png",fit: BoxFit.fill,width: 60,),
         ],
       ),
     ):data["state"] == 2?GestureDetector(
       onTap: (){
         JumpAnimation().jump(orderdetail(data["id"],int.parse(data["mode"]),data["type"]), context);
       },
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Image.asset("img/zhongjiang.png",fit: BoxFit.fill,width: 60,),
           Text(data["money"].toString()+"元",style: TextStyle(color: Colors.red,fontSize: 11),)
         ],
       ),
     ):GestureDetector(
       onTap: (){
         JumpAnimation().jump(orderdetail(data["id"],int.parse(data["mode"]),data["type"]), context);
       },
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Image.asset("img/weizhongjiang.png",fit: BoxFit.fill,width: 60,),
         ],
       ),
     );
   }


 }
}