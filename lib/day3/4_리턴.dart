import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> checkList = [];
  List<String> imgList = [
    "flutter.PNG" , "flutter2.PNG", "flutter3.PNG"
  ];
  Text MyText(String txt){
    return Text(txt);
  }
  Widget MyWidget(){ // widget = object 어떤 타입이든 리턴 가능
    return Container(height: 50, width: 50, color: Colors.yellow,);
  }
  void listChange(String item, bool flg){
    if(flg){
      checkList.add(item);
    }else{
      checkList.remove(item);
    }
  }
  Widget MyCheckBox(String title,{required String imgUrl} ){
    return Column(
      children: [
        CheckboxListTile(
            value: checkList.contains(imgUrl),
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(title),
            onChanged: (value){
              setState(() {
                listChange(imgUrl, value!);
              });
            }
        ),
        if (checkList.contains(imgUrl))                // 체크됐을 때만 이미지 표시
          Image.asset(
            "assets/$imgUrl",
            height: 100,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            MyText("hi"),
            MyText("hello"),
            MyText("flutter"),
            MyCheckBox("몬치치", imgUrl: imgList[0]),
            MyCheckBox("몬치치2", imgUrl: imgList[1]),
            MyCheckBox("몬치치3", imgUrl: imgList[2]),
            MyWidget()
          ]
        ),
      ),
    );
  }
}
