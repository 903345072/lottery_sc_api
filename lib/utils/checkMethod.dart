import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class checkMethod{

  String title;
  String content;
  BuildContext context;
  Function function;
  checkMethod(this.title,this.content,this.context,this.function);
  void showDioLog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
            content: Text(content,style: TextStyle(fontSize: 15)),

          );
        });
  }
}