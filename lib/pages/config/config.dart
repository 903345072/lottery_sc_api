import 'dart:ui';

class config{
  static List getFrq(){
    return [
      "主胜",
      "平",
      "主负",
    ];
  }
  static List getrq(){
    return [
      "主胜",
      "平",
      "主负",
    ];
  }
  static List  getScore(){
   return [
     "1:0",
     "2:0",
     "2:1",
     "3:0",
     "3:1",
     "3:2",
     "4:0",
     "4:1",
     "4:2",
     "5:0",
     "5:1",
     "5:2",
     "胜其他",
     "0:0",
     "1:1",
     "2:2",
     "3:3",
     "平其他",
     "0:1",
     "0:2",
     "1:2",
     "0:3",
     "1:3",
     "2:3",
     "0:4",
     "1:4",
     "2:4",
     "0:5",
     "1:5",
     "2:5",
     "负其他",
   ];
 }
 static List getTotal(){
    return [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7+",
    ];
 }
 static List getHalf(){
    return [
      "胜胜",
      "胜平",
      "胜负",
      "平胜",
      "平平",
      "平负",
      "负胜",
      "负平",
      "负负",
    ];
 }
 static List getTest(){
    Color co = Color(0xfffff5f8);
    return [
      {"mid":"111","methods":[
        {"pid":1,"style":[{"id":1,"color":co},{"id":2,"color":co},{"id":3,"color":co}]},
        {"pid":2,"style":[
          {"id":1,"color":co},
          {"id":2,"color":co},
          {"id":3,"color":co},
        ]},
        {"pid":3,"style":[
          {"id":1,"color":co},
          {"id":2,"color":co},
          {"id":3,"color":co},
          {"id":4,"color":co},
          {"id":5,"color":co},
          {"id":6,"color":co},
          {"id":7,"color":co},
          {"id":8,"color":co},
          {"id":9,"color":co},
          {"id":10,"color":co},
          {"id":11,"color":co},
          {"id":12,"color":co},
          {"id":13,"color":co},
          {"id":14,"color":co},
          {"id":15,"color":co},
          {"id":16,"color":co},
          {"id":17,"color":co},
          {"id":18,"color":co},
          {"id":19,"color":co},
          {"id":20,"color":co},
          {"id":21,"color":co},
          {"id":22,"color":co},
          {"id":23,"color":co},
          {"id":24,"color":co},
          {"id":25,"color":co},
          {"id":26,"color":co},
          {"id":27,"color":co},
          {"id":28,"color":co},
          {"id":29,"color":co},
          {"id":30,"color":co},
          {"id":31,"color":co},
        ]},
        {"pid":4,"style":[
          {"id":1,"color":co},
          {"id":2,"color":co},
          {"id":3,"color":co},
          {"id":4,"color":co},
          {"id":5,"color":co},
          {"id":6,"color":co},
          {"id":7,"color":co},
          {"id":8,"color":co},
        ]},
        {"pid":5,"style":[
          {"id":1,"color":co},
          {"id":2,"color":co},
          {"id":3,"color":co},
          {"id":4,"color":co},
          {"id":5,"color":co},
          {"id":6,"color":co},
          {"id":7,"color":co},
          {"id":8,"color":co},
          {"id":9,"color":co},
        ]},
        ]}
    ];
 }

 static List getSf(){
   return [
     "主负",
     "主胜",
   ];
 }

  static List getrfSf(){
    return [
      "主负",
      "主胜",
    ];
  }
  static List getsfcZs(){
    return [
      "1-5",
      "6-10",
      "11-15",
      "16-20",
      "21-25",
      "26+"
    ];
  }
}