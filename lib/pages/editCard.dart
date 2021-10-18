import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/net/Address.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/wiget/IconInput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

class editCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return editCard_();
  }
}

class editCard_ extends State<editCard> {
  Map<String, Object> phoneData;

  Map<String, Object> realName;

  Map<String, Object> idCard;

  Map<String, Object> bankName;

  Map<String, Object> branchName;

  Map<String, Object> bankCard;

  String old_pwd;
  String new_pwd;
  String re_pwd;
  bool check = false;
  String phone = "1";
  String real_id;
  String real_bank;
  FocusNode _commentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBankInfo();
    _commentFocus = FocusNode();
    phoneData = {
      "value": "",
      "title": "手机号码",
      "tip": "请输入绑定关联手机号码",
      "icon": Icon(Icons.phone_iphone, color: Colors.red),
      "is_edit": false,
      "type":"number"
    };
    realName = {
      "value": "",
      "title": "真实姓名",
      "tip": "请输入银行卡开户名",
      "icon": Icon(Icons.person, color: Colors.red),
      "is_edit": false,
      "type":null
    };
    idCard = {
      "value": "",
      "title": "身份证号",
      "tip": "请输入身份证号码",
      "icon": Icon(Icons.credit_card, color: Colors.red),
      "is_edit": false,
      "type":null
    };
    bankName = {
      "value": "",
      "title": "银行名称",
      "tip": "请输入银行名称",
      "icon": Icon(Icons.account_balance, color: Colors.red),
      "is_edit": true,
      "type":null
    };
    branchName = {
      "value": "",
      "title": "开户支行",
      "tip": "请输入开户支行",
      "icon": Icon(Icons.local_library, color: Colors.red),
      "is_edit": true,
      "type":null
    };
    bankCard = {
      "value": "",
      "title": "银行卡号",
      "tip": "请输入银行卡号",
      "icon": Icon(Icons.attach_money, color: Colors.red),
      "is_edit": true,
      "type":"number"
    };

  }

  loadBankInfo() async {
    ResultData result = await HttpManager.getInstance()
        .get("user/card_info", withLoading: false);
    if (result.data["bank_info"] != null) {
      setState(() {
        _controller.text = result.data["bank_info"]["real_name"];
        _controller2.text = result.data["bank_info"]["bank_name"];
        _controller3.text = result.data["bank_info"]["bank_name"];
        phoneData["value"] = result.data["bank_info"]["phone"];
        phoneData["tag_value"] = result.data["bank_info"]["phone"];
        realName["value"] = result.data["bank_info"]["real_name"];
        realName["tag_value"] = result.data["bank_info"]["real_name"];
        if(result.data["bank_info"]["id_card"] != null){
          idCard["value"] = result.data["bank_info"]["id_card"].toString();
          _controller4.text = result.data["bank_info"]["id_card"].toString().replaceRange(6, result.data["bank_info"]["id_card"].toString().length-4, "*"*(result.data["bank_info"]["id_card"].toString().length-10));
       real_id = result.data["bank_info"]["id_card"].toString();
        }else{
          idCard["value"] = "";
        }

        if(result.data["bank_info"]["bank_card"] != null){
          _controller5.text = result.data["bank_info"]["bank_card"].toString().replaceRange(6, result.data["bank_info"]["bank_card"].toString().length-4, "*"*(result.data["bank_info"]["bank_card"].toString().length-10));
          real_bank = result.data["bank_info"]["bank_card"].toString();

          bankCard["value"] =  result.data["bank_info"]["bank_card"].toString();
        }else{
          bankCard["value"] = "";
        }
        idCard["tag_value"] = result.data["bank_info"]["id_card"];
        bankName["value"] = result.data["bank_info"]["bank_name"];
        bankName["tag_value"] = result.data["bank_info"]["bank_name"];
        branchName["value"] = result.data["bank_info"]["bank_branch"];
        branchName["tag_value"] = result.data["bank_info"]["bank_branch"];

        bankCard["tag_value"] = result.data["bank_info"]["bank_card"];
      });
    }else{
      _controller.text = "";
      _controller2.text = "";
      _controller3.text = "";
      _controller4.text = "";
      _controller5.text = "";
    }
  }

  static TextEditingController _controller = TextEditingController();
  static TextEditingController _controller2 = TextEditingController();
  static TextEditingController _controller3 = TextEditingController();
  static TextEditingController _controller4 = TextEditingController();
  static TextEditingController _controller5 = TextEditingController();

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
          title: Text(
            "账户信息",
            style: TextStyle(fontSize: ScreenUtil().setSp(18)),
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5, top: 15, right: 5),
              child: Text("账户设置"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconInput(
                  data: phoneData,
                  callBack: (value) {
                    setState(() {
                      phoneData["value"] = value;
                    });
                  },
                ),
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 15, right: 5),

                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(
                          onChanged: (e) {
                            setState(() {
                              realName["value"] = e;
                            });

                          },
                          controller: _controller,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText:realName["tip"],
                            prefixIcon: realName["icon"],

                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 15, right: 5),

                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onTap: (){
                            _controller4.text = real_id;
                          },
                          onChanged: (e) {

                            setState(() {
                             idCard["value"] = _controller4.text;
                             real_id = e;


                            });

                          },

                          controller: _controller4,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText:idCard["tip"],
                            prefixIcon: idCard["icon"],

                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 15, right: 5),

                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(
                          onChanged: (e) {
                            setState(() {
                              bankName["value"] = e;
                            });

                          },
                          controller: _controller3,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText:bankName["tip"],
                            prefixIcon: bankName["icon"],

                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  height: ScreenUtil().setHeight(50),
                  margin: EdgeInsets.only(left: 5, top: 15, right: 5),

                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: TextField(

                          onTap: (){
                            _controller5.text = real_bank;
                          },
                          onChanged: (e) {

                            setState(() {
                              bankCard["value"] = _controller5.text;
                              real_bank = e;
                            });

                          },

                          controller: _controller5,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: ScreenUtil().setSp(13)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText:bankCard["tip"],
                            prefixIcon: bankCard["icon"],

                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 25, right: 5),
              child: GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () async {
                    var phone = phoneData["value"];
                    var real_name = realName["value"];
                    var id_card = idCard["value"];
                    var bank_name = bankName["value"];
                    var bank_branch = branchName["value"];
                    var bank_card = bankCard["value"];
                    if (!checkExist(phone) ||
                        !checkExist(real_name) ||
                        !checkExist(id_card) ||
                        !checkExist(bank_name) ||
                        !checkExist(bank_card)) {
                      Toast.toast(context, msg: "请输入完整信息");
                      return;
                    }


                    ResultData result = await HttpManager.getInstance().post(
                        "user/edit_card",
                        params: {
                          "phone": phone, "real_name": real_name,
                          "id_card":id_card,"bank_name":bank_name,
                          "bank_branch":bank_branch,"bank_card":bank_card
                        },
                        withLoading: true);
                    if (result.code == 200) {
                      Toast.toast(context, msg: "修改成功");
                      loadBankInfo();
                    } else {
                      Toast.toast(context, msg: result.msg);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    decoration:
                        BoxDecoration(color: Color(0xfffa2020), boxShadow: []),
                    child: Text(
                      "完善信息",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 15, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text("温馨提示："),
                  ),
                  Text("1、我们承若对您的个人信息进行保密，请放心认证。"),
                  Text("2、以上信息仅用于提款到银行卡，请真实填写否则将无法绑定信息，真实姓名须同银行卡户名一致"),
                  Text("3、除银行卡外，信息填写后将无法再次修改，请确保填写正确"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static bool isChinaPhoneLegal(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }

  static bool isBankCard(String str) {
    return new RegExp('^([1-9]{1})(\\d{14}|\\d{18})\$').hasMatch(str);
  }

  static bool isIdCard(String str) {
    return new RegExp(
            '^([1-9]\\d{5}(18|19|20|(3\d))\\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx])\$')
        .hasMatch(str);
  }

  static bool checkExist(value) {
    if (value == null || value == "") {
      return false;
    }
    return true;
  }

  bool is_edit(data){

    if(data["is_edit"]){
      return true;
    }
    if(!data["is_edit"] && (data['tag_value'] == null || data['tag_value'] == "")){
      return true;
    }
    return false;
  }
}
