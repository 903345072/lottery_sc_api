import 'dart:convert';

class model{
  Map pl;
  String value;
  String h_name;
  String a_name;
  String id;
  String attr;
  double award;
  double base_award;
  double num;

  model.fromJson(Map<String,dynamic> json){
    pl = json["pl"];
    value = json["value"];
    h_name = json["h_name"];
    a_name = json["a_name"];
    id = json["id"];
    attr = json["attr"];
    award = json["award"];
    base_award = json["base_award"];
    num = json["num"];
  }
   String tojson(){
     Map<String,dynamic> map  = new Map<String,dynamic>();
     map["pl"] = pl;
     map["value"] = value;
     map["h_name"] = h_name;
     map["a_name"] = a_name;
     map["attr"] = attr;
     map["award"] = award;
     map["base_award"] = base_award;
     map["num"] = num;
     jsonEncode(map);
     return jsonEncode(map);
   }
}