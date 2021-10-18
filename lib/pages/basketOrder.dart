import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/wiget/football/banquanchang.dart';
import 'package:flutterapp2/wiget/football/bifen.dart';
import 'package:flutterapp2/wiget/football/feirangqiu.dart';
import 'package:flutterapp2/wiget/football/mix.dart';
import 'package:flutterapp2/wiget/football/rangqiu.dart';
import 'package:flutterapp2/wiget/football/zongjinqiu.dart';

class basketOrder extends StatefulWidget{
  Function callBack;
  Map games;
  List game_ids;
  int type;
  int least_game;

  basketOrder(this.games,this.game_ids,this.callBack,this.type,this.least_game);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return order_();
  }
}
class order_ extends State<basketOrder>{
  Map num_to_cn = {"1":"一","2":"二","3":"三","4":"四","5":"五","6":"六","7":"末"};
  List chuan_ = [];
  int num = 1;
  double money = 0;
  double least_award = 0;
  double max_award = 0;
  bool is_pack = false;
  bool visible_ = false;
  List chuan = [];
  int bot = 100;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i=0;
    if(widget.least_game<2){
      setState(() {
        visible_ = true;
      });
    }
    widget.game_ids.forEach((element) {
      chuan.add({"num":i+1,"color":Colors.grey});
      i++;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfffa2020),
        title: Text("竞彩足球投足"),
      ),
      body: MediaQuery.removePadding(context: context, child: Stack(
        children: <Widget>[
          Container(

            margin: EdgeInsets.only(top: ScreenUtil().setHeight(30),bottom: ScreenUtil().setHeight(getBot())),
            child:  Column(
              children: <Widget>[
                Expanded(
                  child: Container(

                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(60)),
                    child: ListView(
                      children: getGameList(),

                    ),
                  ),
                ),

              ],
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: (){
                widget.callBack(widget.games);
                Navigator.pop(context);
              },
              child: Container(
                height: ScreenUtil().setHeight(60),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0), //阴影xy轴偏移量
                          blurRadius: 15.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                      )
                    ]),
                alignment: Alignment.center,
                child: Text("+ 继续选择比赛"),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child:  Container(
                decoration: BoxDecoration( color: Colors.white),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Offstage(
                      offstage: visible_,
                      child: Container(

                        margin: EdgeInsets.only(bottom: 10,top: 10),
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(

                              margin: EdgeInsets.only(bottom: 5),
                              child: Text("标准过关"),
                            ),
                            Wrap(
                              runSpacing: 5,
                              children: getChuan(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(80),
                      decoration: BoxDecoration(border: Border.all(width: 1,color: Color(0xffe6e6e6))),
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(10),left:5,bottom: ScreenUtil().setHeight(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: getText(),
                          ),
                         Row(
                           children: <Widget>[
                             Container(


                               child: Text("投"),
                             ),
                             Container(
                               width: ScreenUtil().setWidth(70),
                               height: ScreenUtil().setHeight(38),
                               margin: EdgeInsets.only(left: 15, right: 15),

                               child: Row(
                                 children: <Widget>[
                                   Expanded(
                                     child: TextField(


                                       //限制2长度],//只允许输入数字
                                       onChanged: (e) {
                                         setState(() {
                                           num = int.parse(e) ;
                                         });
                                       },
                                       controller: TextEditingController.fromValue(
                                           TextEditingValue(
                                               text:
                                               '${this.num == null ? "" : this.num}',
                                               selection: TextSelection.fromPosition(
                                                   TextPosition(
                                                       affinity: TextAffinity.downstream,
                                                       offset: '${this.num}'.length)))),
                                       keyboardType: TextInputType.number,
                                       //键盘类型，数字键盘

                                       decoration: InputDecoration(

                                         contentPadding: EdgeInsets.only(left: 10),
                                         hintText: "",
                                         border: OutlineInputBorder(),

                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ),
                             Container(


                               child: Text("倍"),
                             )
                           ],
                         )
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(80),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: ScreenUtil().setWidth(90),
                              color: Color(0xffe6e6e6),
                              child: Text("发单"),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(220),
                            child: Wrap(
                              direction: Axis.vertical,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Text("共"+getNum().length.toStringAsFixed(0)+"注",style: TextStyle(color: Colors.red,fontSize: ScreenUtil().setSp(12)),),
                                Text(getMoney()+"元"),
                                getExpectAward(),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              width: ScreenUtil().setWidth(107),
                              alignment: Alignment.center,
                              color: Colors.red,
                              child: Text("付款",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),

          )
        ],
      )),
    );
  }
  getBot(){
    if(widget.least_game == 1){

      return 100;
    }
    if(!is_pack){
      int i = chuan.length;
      var a = i/4;
      int b = int.parse(a.toStringAsFixed(0));
      int c = b*40+90;
      return 100+c;
    }

    return 100;
  }
  getText(){

if(widget.least_game == 1){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10,bottom: 10),
    width: ScreenUtil().setWidth(70),
    decoration: BoxDecoration(border: Border(right: BorderSide(width: 0.6,color: Colors.grey))),
    margin: EdgeInsets.only(right: ScreenUtil().setHeight(70)),
    child: Text("单关"),
  );
}
    if(!is_pack){
      return GestureDetector(
        onTap: (){
          setState(() {
            is_pack = true;
            visible_ = true;

          });
        },
        child: Container(

          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10,bottom: 10),
          width: ScreenUtil().setWidth(70),
          decoration: BoxDecoration(border: Border(right: BorderSide(width: 0.6,color: Colors.grey))),
          margin: EdgeInsets.only(right: ScreenUtil().setHeight(70)),

          child: Text("收起"),
        ),
      );
    }else{
      return GestureDetector(
          onTap: (){
            setState(() {

              is_pack = false;
              visible_ = false;

            });
          },
          child: Container(

            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            width: ScreenUtil().setWidth(70),
            decoration: BoxDecoration(border: Border(right: BorderSide(width: 0.6,color: Colors.grey))),
            margin: EdgeInsets.only(right: ScreenUtil().setHeight(70)),

              child: Text("展开"),
          )
      );
    }
  }
  getExpectAward(){
    String text = "预计奖金0";
   List s = getNum();

   if(s.length>0){
     double min = s[0]*num*2;
     double max = s[getNum().length-1]*num*2;
     text = "预计奖金"+min.toStringAsFixed(2)+"~"+max.toStringAsFixed(2);
   }
   if(s.length == 1){
     double min = s[0]*num*2;
     text = "预计奖金"+min.toStringAsFixed(2);
   }
    return Text(text,style: TextStyle(fontSize: ScreenUtil().setSp(12)),);
  }
  String getMoney(){
    int i = getNum().length;
   var a = i*num*2;
    return a.toString();
  }
 List getNum(){
    List zz = [];

    widget.games.forEach((key, value) {
      value.forEach((game) {
        if(widget.game_ids.contains(game["id"])){
          List ls  = [];
           Map maps = jsonDecode(game["checks"]);
           maps.forEach((key1, value1) {
             List ls1 = value1;
             ls1.forEach((element) {
               ls.add(element);
             });
           });
           zz.add(ls);
        }
      });
    });
    List ar = [];
    if(widget.least_game == 1){

      zz.forEach((z) {
        List z1 = z;
        z1.forEach((element_) {
          ar.add(double.parse(element_));
        });
      });
      ar.sort((left,right)=>left.compareTo(right));
      return ar;
    }


     chuan.forEach((element) {
       if(element["color"] == Colors.red){
         setState(() {
           if(!chuan_.contains(element["num"])){
             chuan_.add(element["num"]);
           }
         });
       }else{
         chuan_.remove(element["num"]);
       };

     });
     List ars = [];

     chuan_.forEach((element4) {
      List lss = plzh(zz,element4);
      lss.forEach((element5) {
        List lss2 = element5;
        lss2.forEach((element6) {
          List lss3 = element6.toString().split(",");
          double m= 1;
          lss3.forEach((element7) {
            m *= double.parse(element7);
          });
          ars.add(m);
        });
      });
     });

    ars.sort((left,right)=>left.compareTo(right));
    return ars;
  }
  plzh(List arr,int size){
    int len = arr.length;
    int max = pow(2, len);
    int min = pow(2, size) - 1;
    List r_arr = [];
    for (int i = min; i < max; i++) {
      int count = 0;
      List t_arr = [];
      for (int j = 0; j < len; j++) {
        int a = pow(2, j);
        int t = i & a;
        if (t == a) {
          t_arr.add(arr[j]);
          count++;
        }
      }
      if (count == size) {
        r_arr.add(t_arr);
      }
    }
    List arr_ = [];
    r_arr.forEach((element) {
      arr_.add(cartesian(element));
    });
    return arr_;

  }

  cartesian(List sets){
      List arr = [];
      for(int i = 0;i<sets.length-1;i++){
        if(i == 0){
          arr = sets[i];
        }
        List tmp = [];
         arr.forEach((element) {
           List ls = sets[i+1];
           ls.forEach((element2) {
               tmp.add(element+","+element2);
           });
         });
         arr = tmp;
      };
      return arr;
  }
  getChuan(){

     List ls;
      ls = widget.game_ids.asMap().keys.map((e){
      String num = (e+1).toString();
      return  GestureDetector(
        onTap: (){
          setState(() {
            chuan[e]["color"] = chuan[e]["color"] == Colors.red?Colors.grey:Colors.red;
          });
        },
        child: Container(
          width: ScreenUtil().setWidth(90),
          height: ScreenUtil().setHeight(40),
          margin: EdgeInsets.only(right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration( color: Colors.white,border: Border.all(width: 1,color: chuan[e]["color"])),
          child: Text(num+"串1"),
        ),
      );
    }).toList();
      if(ls.length>0){ ls.removeAt(0);}


      return ls;
  }
  List getGameList(){
  List ls;
    ls =  widget.games.keys.map((e){
      String date = e;

      String week = widget.games[e][0]["num"].toString().substring(0,1);
      List list_game =  widget.games[e];
      BoxDecoration boxde = BoxDecoration(color: Color(0xfffff5f8),border: Border(bottom: BorderSide(width: 0.3,color: Colors.grey)));
       if(widget.game_ids.length==0){
         boxde = null;
       }
      return Container(
        decoration: boxde,
        child: Container(
            decoration: BoxDecoration(color: Color(0xfffff5f8)),
            child: Column(

              children: getGameList_(list_game,e),
            )),
      );
    }).toList();
    Widget db = Container(
      alignment: Alignment.center,
      child: Text("sadasd"),
    );

    return ls;
  }
  List getGameList_(List list_game_,e2){

    return list_game_.asMap().keys.map((e){
      String week = list_game_[e]["num"].toString().substring(0,1);
      String order_no = list_game_[e]["num"].toString().substring(1,4);
      String week_time = "周"+num_to_cn[week]+order_no;
      String hour_time = list_game_[e]["dtime"].toString().substring(11,16);
      String ls_name = list_game_[e]["l_cn_a"];
      String zd_name = list_game_[e]["h_cn"];
      String kd_name = list_game_[e]["a_cn"];
      String p_goal  = list_game_[e]["p_goal"].toString();
      List p_status = list_game_[e]["p_status"].toString().split(",");

      if(list_game_[e]["type"] == 1){
        p_goal = list_game_[e]["p_goal"].toString().split(",")[1];//让球个数
      }
      if(list_game_[e]["type"] == 2 || list_game_[e]["type"] == 3 || list_game_[e]["type"] == 4  || list_game_[e]["type"] == 5 || list_game_[e]["type"] == 6){
        p_status = [list_game_[e]["p_status"].toString(),list_game_[e]["p_status"].toString(),list_game_[e]["p_status"].toString(),list_game_[e]["p_status"].toString(),list_game_[e]["p_status"].toString()];
      }

      List ttg_odds = list_game_[e]["ttg_odds"].toString().split(",");//总进球赔率
      List half_odds = list_game_[e]["hafu_odds"].toString().split(",");//半全场赔率
      List spf = list_game_[e]["had_odds"].toString().split(",");//非让球赔率


      List rqspf = list_game_[e]["hhad_odds"].toString().split(",");//让球赔率
      List crs_win = list_game_[e]["crs_win"].toString().split(","); //胜比分赔率
      List crs_draw = list_game_[e]["crs_draw"].toString().split(","); //平比分赔率
      List crs_lose = list_game_[e]["crs_lose"].toString().split(","); //负比分赔率

      crs_draw.forEach((element) {
        crs_win.add(element);
      });
      crs_lose.forEach((element) {
        crs_win.add(element);
      });
      Border border;
      double bot;
      if(list_game_.length>1){
        border =  Border(bottom: BorderSide(width: 0.2,color: Colors.grey));
        bot =15;
      }else{
        border = null;
        bot =0;
      }
      if(e == list_game_.length-1){
        bot = 0;
        border = null;
      }
if(widget.game_ids.contains(list_game_[e]["id"])){
  return Container(

    padding: EdgeInsets.only(bottom: bot,left: 15),
    decoration: BoxDecoration(
        color: Color(0xfffff5f8),
        border: border
    ),
    margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
    child: Row(


      children: <Widget>[

        //比赛组件
        getComponent(p_status,p_goal,widget.games,e2,e,zd_name,kd_name,spf,rqspf,crs_win,ttg_odds,half_odds),
        IconButton(
          onPressed: (){
            widget.game_ids.remove(list_game_[e]["id"]);
            setState(() {
            });
          },
          icon: Icon(Icons.close,color: Colors.grey,),
        )
        //比赛组件
      ],
    ),
  );
}else{
  return Container();
}
    }).toList();
  }
  getComponent(p_status,p_goal,games,e2,e,zd_name,kd_name,spf,rqspf,crs_win,ttg_odds,half_odds){

    switch(widget.type){
      case 0:
        return mix(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,p_goal:p_goal,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,spf: spf,rqspf: rqspf,crs_win: crs_win,ttg_odds: ttg_odds,half_odds: half_odds,
        );
      case 1:
        return rangqiu(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,p_goal:p_goal,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,rqspf: rqspf
        );
      case 2:
        return feirangqiu(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,p_goal:p_goal,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,spf: spf
        );
      case 3:
        return zongjinqiu(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,ttg_odds: ttg_odds,
        );
      case 4:
        return bifen(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,crs_win: crs_win,
        );
      case 5:
        return banquanchang(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,half_odds: half_odds,
        );
      case 6:
        return feirangqiu(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,p_goal:p_goal,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,spf: spf
        );
      case 7:
        return rangqiu(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,p_goal:p_goal,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,rqspf: rqspf
        );
      case 8:
        return zongjinqiu(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,ttg_odds: ttg_odds,
        );
      case 9:
        return bifen(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,crs_win: crs_win,
        );
      case 10:
        return banquanchang(callBack: (value) {
          setState(() {
            games = value;
          });
        },p_status:p_status,games: games,e2: e2,e: e,zd_name: zd_name,kd_name: kd_name,half_odds: half_odds,
        );
    }
  }
}