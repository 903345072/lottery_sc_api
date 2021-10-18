import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/config/config.dart';
import 'package:flutterapp2/utils/EventDioLog.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Toast.dart';
import 'package:flutterapp2/utils/checkMethod.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/wiget/football/banquanchang.dart';
import 'package:flutterapp2/wiget/football/bifen.dart';
import 'package:flutterapp2/wiget/football/feirangqiu.dart';
import 'package:flutterapp2/wiget/football/mix.dart';
import 'package:flutterapp2/wiget/football/rangqiu.dart';
import 'package:flutterapp2/wiget/football/zongjinqiu.dart';

import 'IndexBack.dart';
import 'order.dart';
class football extends StatefulWidget {
  @override
  _GZXDropDownMenuTestPageState createState() =>
      _GZXDropDownMenuTestPageState();
}
class _GZXDropDownMenuTestPageState extends State<football> {
  Future _future;
  List game_ids = [];
  Map num_to_cn = {"1":"一","2":"二","3":"三","4":"四","5":"五","6":"六","7":"末"};
  Map games = {};
  List game_mid_list = [];
  int least_game = 2;
  List lsl = [{"color":Colors.red}];
  List frqspf_ = [{"text":"主胜","color":Color(0xfffff5f8)},{"text":"平","color":Color(0xfffff5f8)},{"text":"主负","color":Color(0xfffff5f8)}];
  List methods = [
    {"name": "混合投注","least_game":2},
    {"name": "让球胜平负","least_game":2},
    {"name": "胜平负","least_game":2},
    {"name": "总进球","least_game":2},
    {"name": "比分","least_game":2},
    {"name": "半全场","least_game":2},
    {"name": "胜平负|单","least_game":1},
    {"name": "让球胜平负|单","least_game":1},
    {"name": "总进球|单","least_game":1},
    {"name": "比分|单","least_game":1},
    {"name": "半全场|单","least_game":1},
    {"name": "","least_game":1},
  ];
  bool withLoading = false;
  int index = 0;
  Icon cur_icon = Icon(
    Icons.arrow_drop_down,
    color: Colors.white,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _future = getGames();
  }

  Future getGames() async {
   ResultData res = await HttpManager.getInstance().get("football_game",params: {"type":index+1},withLoading: withLoading);
   setState(() {

       if(res.data["count"] > 0){
         games = res.data["games"];
       }else{
         games = {};
         Toast.toast(context,msg: "暂无对阵信息");
       }



   });
  }
  List getMethods() {
    return methods.asMap().keys.map((e) {
      Border cur_border;
      Color color;
      if (e == index) {
        cur_border = Border.all(width: 2, color: Colors.red);
        color= Colors.red;
      } else {
        cur_border = null;
        color= Colors.white;
      }
      return GestureDetector(
          onTap: () {
            if(e < methods.length-1){
              setState(() {
                index = e;
                least_game = methods[e]["least_game"];
                withLoading = true;
                Navigator.pop(context);
              });

                getGames();

            }


          },
          child: Container(
            decoration: BoxDecoration(color: color),
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(120),
            height: ScreenUtil().setHeight(50),
            child: Text(
              methods[e]["name"],
              style: TextStyle(fontSize: ScreenUtil().setSp(16)),
            ),
          ));
    }).toList();
  }

  List getGameList(){

   return games.keys.map((e){
     String date = e;
     
     String week = games[e][0]["num"].toString().substring(0,1);
     List list_game =  games[e];
      return Container(
        decoration: BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(width: 0.3,color: Colors.grey))),
        child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ExpansionTile(

              title: Text(date+" 周"+num_to_cn[week]+" "+list_game.length.toString()+"场比赛可投"),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration( color: Color(0xfffff5f8)),
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.only(
                     right: 15,  bottom: 10),
                    child: Column(

                        children: getGameList_(list_game,e),
                    ),
                  ),
                )
              ],
            )),
      );
    }).toList();
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
      List p_single = list_game_[e]["p_single"].toString().split(",");
      String is_single = p_single[0];
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
      return Stack(
        children: <Widget>[
          is_single=="1" && index==0?Positioned(
            left: 0,
            top: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 0,
                  decoration: new BoxDecoration(
                    border: Border(
                      // 四个值 top right bottom left
                      top: BorderSide(
                          color: Colors.yellow,
                          width: 30,
                          style: BorderStyle.solid),
                      right: BorderSide(
                          color: Colors.transparent,
                          width: 30,
                          style: BorderStyle.solid),

                    ),
                  ),
                ),
                Positioned(
                  child: Text("单"),
                ),
              ],
            ),
          ):Container(),
          Container(
            padding: EdgeInsets.only(bottom: bot,left: 10),
            decoration: BoxDecoration(
                border: border
            ),
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Wrap(
                  spacing: 3,
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Text(week_time,style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),),
                    Text(ls_name,style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),),
                    Text(hour_time,style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(14)),),
                  ],
                ),
                //比赛组件
                getComponent(p_status,p_goal,games,e2,e,zd_name,kd_name,spf,rqspf,crs_win,ttg_odds,half_odds)
                //比赛组件
              ],
            ),
          )
        ],
      );
    }).toList();
  }
getComponent(p_status,p_goal,games,e2,e,zd_name,kd_name,spf,rqspf,crs_win,ttg_odds,half_odds){
    switch(index){
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
  getGameNum(){
    game_ids = [];
    games.forEach((key, value) {
        List ls  = value;
        ls.forEach((element) {
        List e2 = element["check_info"];
        e2.forEach((element1) {
          List e3 = element1["bet_way"];
          e3.forEach((element2) {
            if(element2["color"] != "co"){
              if(!game_ids.contains(element["id"])){
                game_ids.add(element["id"]);
              }
            }
          });
        });
      });
    });
    return game_ids.length.toString();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    return FlutterEasyLoading(
      child: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            size: 22.0,
            color: Colors.white, //修改颜色
          ),
          backgroundColor: Color(0xfffa2020),
          title: GestureDetector(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Material(
                            child: Container(
                              margin: EdgeInsets.only(top: 25),
                              color: Colors.white,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: getMethods(),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  methods[index]["name"],
                  style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                ),
                cur_icon
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xfff5f5f5),
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            child:

            FutureBuilder(
                future: _future,
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return  Center(child: CircularProgressIndicator());

                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text('网络请求出错'),
                        );
                      }
                      return Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(60)),
                                  child: ListView(
                                    children: getGameList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.white,
                              height: ScreenUtil().setHeight(60),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {

                                        games.forEach((key, value) {
                                          List ls  = value;
                                          ls.forEach((element) {
                                            List e2 = element["check_info"];

                                            element["checks"] = '{}';
                                            e2.forEach((element1) {
                                              List e3 = element1["bet_way"];
                                              e3.forEach((element2) {

                                                element2["color"] = "co";
                                              });
                                            });
                                          });
                                        });
                                      });

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(0xfff2f2f2),width: 0.5))),
                                      alignment: Alignment.center,
                                      width: ScreenUtil().setWidth(90),
                                      child: Text("清空"),
                                    ),
                                  ),
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text("已选择"+ getGameNum() +"场",style: TextStyle(color: Colors.red),),
                                      //Text("至少选择"+ least_game.toString()+"场比赛")
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){


                                    if(index == 0){
                                      List p_single = games.values.toList()[0][0]["p_single"].toString().split(",");
                                      if(p_single[0] == "1" && p_single[1] == "1"){
                                        if(getGameNum() == "1"){
                                          int flag1=0;
                                          int flag2=0;
                                          int flag3=0;
                                          int flag4=0;
                                          int flag5=0;
                                          List s1 = games.values.toList()[0][0]["check_info"][0]["bet_way"];
                                          List s2 = games.values.toList()[0][0]["check_info"][1]["bet_way"];
                                          List s3 = games.values.toList()[0][0]["check_info"][2]["bet_way"];
                                          List s4 = games.values.toList()[0][0]["check_info"][3]["bet_way"];
                                          List s5 = games.values.toList()[0][0]["check_info"][4]["bet_way"];

                                          s1.forEach((element1) {
                                            if(element1["color"] == "red"){
                                              flag1 = 1;
                                              return;
                                            }
                                          });
                                          s2.forEach((element2) {
                                            if(element2["color"] == "red"){
                                              flag2 = 1;
                                              return;
                                            }
                                          });
                                          s3.forEach((element2) {
                                            if(element2["color"] == "red"){
                                              flag3 = 1;
                                              return;
                                            }
                                          });
                                          s4.forEach((element2) {
                                            if(element2["color"] == "red"){
                                              flag4 = 1;
                                              return;
                                            }
                                          });
                                          s5.forEach((element2) {
                                            if(element2["color"] == "red"){
                                              flag5 = 1;
                                              return;
                                            }
                                          });
                                          if(flag1 == 0 && flag2 == 0){
                                            Toast.toast(context,msg: "请至少选择"+least_game.toString()+"比赛");
                                            return;
                                          }else{
                                            if((flag3 ==0 && flag4 == 0 && flag5 ==0 ) && (flag1 == 1 || flag2 == 1)){
                                              JumpAnimation().jump(order(games,game_ids,(value){
                                                setState(() {
                                                  games = value;
                                                });
                                              },index,methods[index]["least_game"],"f"), context);
                                              return;
                                            }
                                          }
                                        }
                                      }

                                    }
                                    if(int.parse(getGameNum())< least_game){
                                        Toast.toast(context,msg: "请至少选择"+least_game.toString()+"比赛");
                                        return;
                                      }
                                  //一场比赛选了spf、rqspf
                                      JumpAnimation().jump(order(games,game_ids,(value){
                                        setState(() {
                                          games = value;
                                        });
                                      },index,methods[index]["least_game"],"f"), context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: ScreenUtil().setHeight(60),
                                      decoration: BoxDecoration(color:Colors.red,border: Border(left: BorderSide(color: Color(0xfff2f2f2),width: 1))),
                                      width: ScreenUtil().setWidth(90),
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
                  return null;
                }
            )


        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
