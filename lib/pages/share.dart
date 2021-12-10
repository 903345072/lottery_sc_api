import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/utils/Toast.dart';

class share extends StatefulWidget{
  @override
  _share createState() => _share();

}
class _share extends State<share>{
  String invite_code = "";
  String url = "";
  getData() async{
    ResultData res = await  HttpManager.getInstance().get("userInfo",withLoading: false);
    if(res.data != null){
      setState(() {
        invite_code = res.data["invite_code"];
        url = res.data["url"];
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
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
        title: Text("推广中心",style: TextStyle(fontSize: 15),),
      ),
      body: Container(

        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.asset("img/share.jpg",fit: BoxFit.fill,),
            ),

            url!=""?Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(280)),
              child: Image.network(url,width: 165,height: 165,),
            ):Container()
          ],
        ),
      ),
    );
  }

}