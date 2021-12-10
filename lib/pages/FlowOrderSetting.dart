import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/utils/Toast.dart';

class FlowOrderSetting extends StatefulWidget{
  @override
  _FlowOrderSetting createState() => _FlowOrderSetting();

}
class _FlowOrderSetting extends State<FlowOrderSetting>{
  bool auto_order = false;
  int flow_type = 1;
  double auto_flow_amount = 600;
  getData() async{
    ResultData res = await  HttpManager.getInstance().get("userInfo",withLoading: false);
    if(res.data != null){
      setState(() {
        auto_order = res.data["auto_order"]==0?false:true;
        auto_flow_amount = double.parse(res.data["auto_flow_amount"]) ;
        flow_type = res.data["flow_type"];
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
        title: Text("自动跟单设置",style: TextStyle(fontSize: 15),),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("是否开启: "),
                Switch(
                  activeColor: Colors.red,
                  onChanged: (bool value)async {
                    setState(()  {
                      auto_order = value;
                    });
                  }, value: auto_order,
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text("类型选择: "),
                Row(
                  children: <Widget>[
                    Text("保底收益跟单"),
                    Radio(
                      activeColor: Colors.red,
                      value:1,
                      groupValue:this.flow_type,
                      onChanged:(v){
                        setState(() {
                          this.flow_type = v;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("2.0收益跟单"),
                    Radio(
                      activeColor: Colors.red,
                      value:2,
                      groupValue:this.flow_type,
                      onChanged:(v){
                        setState(() {
                          this.flow_type = v;
                        });
                      },
                    ),
                  ],
                )

              ],
            ),
            Row(
              children: <Widget>[
                Text("跟单金额: "),
                DropdownButton(
                  underline: Container(),
                  value: auto_flow_amount,
                  items: [
                    DropdownMenuItem(value:600.0,child: Container(child: Text('600',style: TextStyle(fontSize: 15),),)),
                    DropdownMenuItem(value:3000.0,child: Container(child: Text('3000',style: TextStyle(fontSize: 15),),)),
                    DropdownMenuItem(value:6000.0,child: Container(child: Text('6000',style: TextStyle(fontSize: 15),),)),
                    DropdownMenuItem(value:30000.0,child: Container(child: Text('30000',style: TextStyle(fontSize: 15),),)),
                  ],
                  onChanged: (e){
                    setState(() {
                      auto_flow_amount = e;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  minWidth: 300,
                  color: Colors.red,
                  onPressed: ()async{
                    ResultData result = await HttpManager.getInstance().post(
                        "set_auto_order",
                        params: {"value":auto_order,"flow_type":flow_type,"auto_flow_amount":auto_flow_amount},
                        withLoading: true);
                    if (result.code == 200) {
                      Toast.toast(context, msg: "操作成功");
                      getData();
                    } else {
                      Toast.toast(context, msg: result.msg);
                    }
                  },
                  child: Text("保存设置",style: TextStyle(color: Colors.white),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}