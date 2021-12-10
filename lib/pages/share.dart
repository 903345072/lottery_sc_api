import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            Positioned(
              left: 80,
              top: 258,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(invite_code,style: TextStyle(letterSpacing: 5),),
                  ),
                  GestureDetector(
                    onTap: (){
                      Future res = Clipboard.setData(ClipboardData(text: invite_code));
                      res.whenComplete(() =>Toast.toast(context,msg: "复制成功"));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 80),
                      child: Text("                       "),
                    ),
                  )
                ],
              ),
            ),
            url!=""?Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 255),
              child: Image.network(url,width: 130,height: 130,),
            ):Container()
          ],
        ),
      ),
    );
  }

}