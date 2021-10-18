import 'package:shared_preferences/shared_preferences.dart';

class TokenStore{
  setToken(String key,String val) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key,val);
  }

 Future getToken(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(key);
    return token;
  }
  void clearToken(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}