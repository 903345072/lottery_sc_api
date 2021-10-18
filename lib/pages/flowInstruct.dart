import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class flowInstruct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Login_();
  }
}

class Login_ extends State<flowInstruct> {
  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentFocus = FocusNode();
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
            size: 25.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: Text("用户注册协议",style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(

              child: Center(
                child: Html(
                  data: """ 
                  <P>1、本平台注册用户，申请成为大神后即有资格进行发单;</P>  
                  <P>2、发单者所发单中奖，并【税后奖金-（税后奖金*发单提成）>投注金，则有佣金提成;</P>  
                  <P>3、几中几∶指发单者近七单已开奖发单方案数量及中奖方案数量;</P>  
                  <P>4、胜率∶指发单者在本平台历史记录中的红单数与总购彩单数的百分比，其中总购彩单数包括"非跟单"订单;</P>  
                  <P>5、预计回报∶指当前方案的回报倍数。预计回报倍数是根据发单者支付时的赔率计算而来;</P>  
                  <P>6、余额不足时，无法使用彩金进行跟单;</P>  
                  <P>7、订单排序∶根据订单当前的（跟单金额/自购金额）大小进行排序，该数值越大，排的越前;</P>  
                  <P>8、发单目前仅支持篮球、篮球单关、足球、足球单关;如何发单∶</P>  
                  <P>1、选择好比赛场次后点击"选好了"按钮进入付款页面，在该页面左下角，点击"发单"按钮即可进入发单页面;</P>  
                  <P>2、发单页面可进行佣金的设置，为0%-10%;方案有公开、跟单可见、开赛可见、永久保密四种保密设置;"方案描述"中填写的内容将在跟单页面进行展示，请谨慎填写;3、付款即完成发单;</P>  
                  <P3>付款即完成发单;</P>  
                  <P3>如何获得佣金∶</P>  
                  <P3>1、发单时，可选择0%-10%的佣金提成;</P>  
                  <P3>2、必须是中奖的跟单，且【税后奖金-（税后奖金*发单提成）>投注金，才有佣金提成;</P>  
                  <P3>3、必须有跟单者跟投方案;</P>  
                  <P3>4、跟单者跟投方案中奖后，则从该方案奖金里扣除发单者所设佣金并返于发单者。
本规则最终解释权归本平台所有，如有疑问请拨打客服电话。</P>  
                  """,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
