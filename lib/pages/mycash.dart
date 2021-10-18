import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/orderdetail.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/freshStyle.dart';
import 'package:flutterapp2/utils/request.dart';


class mycash extends StatefulWidget {
  String type;


  mycash({this.type});
  @override
  _StockRankList createState() => _StockRankList();
}

class _StockRankList extends State<mycash> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  List<Container> table_list = [];
  List dapan_data;
  List<String> containers = ["沪深", "自选"];
  int page = 1;
  int page_ = 1;
  Map rank_list = {} ; //龙虎榜
  double screenwidth;
  List<TextStyle> ts = [TextStyle()];
  Future _future;
  @override
  void initState() {
    super.initState();



    _future = getRankList();

  }

  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  GlobalKey<EasyRefreshState> _key = new GlobalKey<EasyRefreshState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenwidth = MediaQuery.of(context).size.width*0.6;
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);

    return Container(
      child: FutureBuilder(
        future: _future,
          builder: (context, snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('网络请求出错'),
                  );
                }
                return Center(
                  child: EasyRefresh(

                    refreshHeader: freshStyle.getHeader(_headerKey),
                    refreshFooter: freshStyle.getFooter(_footerKey),
                    child: ListView(
                      children: <Widget>[

                  Container(
                   width: double.infinity,
                    child: Wrap(
                      runSpacing: 10,
                      children: getTableRowList(),
                    ),
                  )
                      ],
                    ),
                    onRefresh: () async {
                      await new Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                         getRankList();

                        });
                      });
                    },
                   loadMore: ()async{
                     setState(() {
                       page++;
                     });
                     getRankList();
                   },
                  ),
                );
            }
            return null;
          }
      ),
    );





  }



  Future getRankList() async {
    try{
      ResultData res = await HttpManager.getInstance().get("getMyCash",params:{"page":page,"type":widget.type},withLoading: false);
      Map list = res.data;

      setState(() {
        if(page == 1){
          rank_list = list;
        }else{

          if(list.length>0){
            list.forEach((key, value) {
              if(rank_list[key] != null){

                List s = value;
                List cur_s = rank_list[key];

                s.forEach((element) {
                  cur_s.add(element);
                });
                setState(() {
                  rank_list[key] = cur_s;
                });
              }else{

                setState(() {
                  rank_list[key] = value;
                });
              }
            });
          }

        }

      });
    }catch(e){
      print(e);
    }
  }
  List getTableRowList(){

    return rank_list.keys.map((e){
      List ls = rank_list[e];
      List date_ = e.toString().split("-");
       return Container(

         padding: EdgeInsets.only(bottom: 6),
         decoration: BoxDecoration(color: Colors.white,),
         child: Wrap(
           children: <Widget>[

             Container(
               padding: EdgeInsets.only(left: 5,top: 5,bottom: 5),
               width: double.infinity,
               decoration: BoxDecoration(color: Color(0xffffdbdb)),
               child: Text(date_[0]+"月"+date_[1]+"日"),
             ),
             Wrap(
                 children: ls.asMap().keys.map((e2){
                   return Column(
                     children: <Widget>[
                       GestureDetector(
                         onTap: (){
                           JumpAnimation().jump(orderdetail(ls[e2]["id"],int.parse(ls[e2]["mode"]),ls[e2]["type"].toString()), context);
                         },
                         child: Container(
                           margin: EdgeInsets.only(top: 5,left: 5,right: 20),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Wrap(

                                 spacing: 5,
                                 direction: Axis.vertical,
                                 children: <Widget>[
                                   Row(
                                     children: <Widget>[
                                       Container(
                                         margin:EdgeInsets.only(right: 20),
                                         child:Text(e),
                                       ),
                                     ],
                                   ),
                                   Text(ls[e2]["dtime"]),
                                 ],
                               ),
                               ClipOval(
                                 child: Container(

                                   width: 25,
                                   height: 25,
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(color: ls[e2]["pm"]==1?Colors.lightBlueAccent:Colors.orange),
                                   child: Text(ls[e2]["pm"]==1?"入":"支",style: TextStyle(color: Colors.white),),
                                 ),
                               ),
                               Container(
                                 width: ScreenUtil().setWidth(190),
                                 child: Wrap(
                                   direction: Axis.vertical,
                                   crossAxisAlignment: WrapCrossAlignment.center,
                                   children: <Widget>[
                                     Row(
                                       children: <Widget>[
                                         Text(ls[e2]["pm"]==1?"+":"-"),
                                         Text(ls[e2]["number"].toString()),
                                       ],
                                     ),
                                     Row(
                                       children: <Widget>[
                                         Text("类型:  "),
                                         Text(ls[e2]["type"]=="buy_lottery"?"购彩":ls[e2]["type"]=="win_prize"?"中奖":ls[e2]["type"]=="extract"?"提款":"充值")
                                       ],
                                     )
                                   ],
                                 ),
                               ),

                             ],
                           ),
                         ),
                       ),
                       e2!=ls.length-1?Divider():Container()
                     ],
                   );
                 }).toList(),
               ),

           ],
         ),
       );
    }).toList();



  }

  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, // child is the value returned by pageBuilder
    );
  }

}
