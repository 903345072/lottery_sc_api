import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp2/net/HttpManager.dart';
import 'package:flutterapp2/net/ResultData.dart';
import 'package:flutterapp2/pages/article.dart';
import 'package:flutterapp2/pages/floworder.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/wiget/CommonWiget.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';

import 'IndexPage.dart';
import 'Mine.dart';
import 'kaijiang.dart';
class IndexBack extends StatefulWidget {
  @override
  _IndexPage createState() => _IndexPage();
}

class _IndexPage extends State<IndexBack> with SingleTickerProviderStateMixin , AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ScrollController _controller;
  Timer _timer;
  double _offset = 0.0;
  int page = 0;
  GlobalKey<NavigatorState> navigatorKey;
  PageController controller;
  List newsContainer ;
  List news;
  @override
  void initState() {
    super.initState();
    news = [];
    newsContainer= [];
    loadNews();
    controller = new PageController(initialPage: this.page);
  }
  Future<void> onTap(int index) async {
    var is_login = await TokenStore().getToken("is_login");

    if((index == 1 && is_login == null) || (index == 1 && is_login == "0")){
      Rute.navigatorKey.currentState.pushNamedAndRemoveUntil("/login",
          ModalRoute.withName("/"));
      return;
    }

    if((index == 3 && is_login == null) || (index == 3 && is_login == "0")){
      Rute.navigatorKey.currentState.pushNamedAndRemoveUntil("/login",
          ModalRoute.withName("/"));
      return;
    }

    if(page != index){

      controller.jumpToPage(index);
    }
  }
  loadNews() async {
   ResultData res = await HttpManager.getInstance().get("news",withLoading: false);
   setState(() {
     news = res.data["news"];
   });
  }
  List getNews(){
      return news.asMap().keys.map((e){
        return GestureDetector(
          onTap: (){
             JumpAnimation().jump(article(id: news[e]["id"],index: e+1,), context);
          },
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),

                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.network(news[e]["img"],fit: BoxFit.fill,width: ScreenUtil().setWidth(130),height: ScreenUtil().setHeight(76),),
                        Wrap(
                          spacing: 13,
                          direction: Axis.vertical,
                          children: <Widget>[
                            Container(
                              width:ScreenUtil().setWidth(232),
                              child: Text(news[e]["title"],maxLines: 1,
                                overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Text(news[e]["date"])
                          ],
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      }).toList();



  }


  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);


  List img_url = [
    "img/swiper1.jpg",
    "img/swiper2.jpg",
    "img/swiper3.jpg",
  ];
  List texts = [
    {"name": "上证指数", "value": "2268.1 2.1%"},
    {"name": "深圳成指", "value": "5123.3 24.1%"}
  ];
  double appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavItems = [
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.home,color: Color(0xfffa2020)),
        backgroundColor: Colors.black,
        icon: Icon(Icons.home),
        title: Text("购彩",),
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(const IconData(0xe609, fontFamily: 'iconfont'),color: Color(0xfffa2020)),
        backgroundColor: Colors.black,
        icon: Icon(const IconData(0xe609, fontFamily: 'iconfont')),
        title: Text("跟单"),
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(const IconData(0xe621, fontFamily: 'iconfont'),color: Color(0xfffa2020),),
        backgroundColor: Colors.black,
        icon: Icon(const IconData(0xe621, fontFamily: 'iconfont')),
        title: Text("开奖"),
      ),
      BottomNavigationBarItem(
        activeIcon: Icon(Icons.person,color: Color(0xfffa2020),),
        backgroundColor: Colors.black,
        icon: Icon(Icons.person,),
        title: Text("我的"),
      ),
    ];
    SystemChrome.setSystemUIOverlayStyle(_style);
    ScreenUtil.instance = ScreenUtil(width: 417, height: 867)..init(context);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(


            selectedItemColor:Colors.red,
            selectedFontSize:12.0,           //选中时的大小
            unselectedFontSize:12.0,      //未选中时的大小
            type: BottomNavigationBarType.fixed,  //固定导航栏颜色
            items: bottomNavItems,
            onTap: onTap,
            currentIndex: page
        ),

        body:   PageView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  IndexPage(),
                  floworder(),
                  kaijiang(),
                  Mine()
                ],
                controller: controller,
                onPageChanged: onPageChanged,
              ),
        );
  }
  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
