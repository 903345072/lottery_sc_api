import 'package:flutter/material.dart';
import 'package:flutterapp2/SharedPreferences/TokenStore.dart';
import 'package:flutterapp2/pages/ChildItemView.dart';
import 'package:flutterapp2/pages/IndexBack.dart';
import 'package:flutterapp2/pages/IndexPage.dart';
import 'package:flutterapp2/pages/Login.dart';
import 'package:flutterapp2/pages/Mine.dart';
import 'package:flutterapp2/pages/editCard.dart';
import 'package:flutterapp2/utils/JumpAnimation.dart';
import 'package:flutterapp2/utils/Rute.dart';
import 'package:flutterapp2/utils/Toast.dart';
void main() {
  runApp( new BotomeMenumPage());
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class BotomeMenumPage extends StatefulWidget{
  BotomeMenumPage();
  @override
  BotomeMenumPageState createState() => BotomeMenumPageState();
}

class BotomeMenumPageState extends State<BotomeMenumPage> with SingleTickerProviderStateMixin{
  PageController controller;
  BotomeMenumPageState();
  int page = 0;
  GlobalKey<NavigatorState> navigatorKey;
  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
    controller = new PageController(initialPage: this.page);
  }
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
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
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    //底部导航栏显示的内容
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

    return MaterialApp( //注意这里
      navigatorKey: Rute.navigatorKey, //设置在这里
        routes:{
          "/login":(context) => Login(), //注册首页路由
          "/index":(context)=>IndexPage(),
          "/mine":(context)=>Mine(),
          "/editCard":(context)=>editCard(),
        },

      title: '中钥国际',
      home: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            IndexBack(),
            Mine()
          ],
          controller: controller,
          onPageChanged: onPageChanged,
        ),

      ),
    );

  }
  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }


}

