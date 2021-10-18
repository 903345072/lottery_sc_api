import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class kaijiangdetail extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return news_();
  }
}
class news_ extends State<kaijiangdetail>{


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
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        title: Text("走势",style: TextStyle(color:Colors.black,fontSize: ScreenUtil().setSp(18),),),
      ),
      body: Container(
          alignment: Alignment.center,
          child: WebView(
            initialUrl: "https://www.lottery.gov.cn/zst/pls/",
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }

}