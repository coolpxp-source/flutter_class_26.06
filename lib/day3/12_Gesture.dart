import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector( // 움직임을 탐지해서 이벤트를 처리.
          onTap: (){
            print("Tap!");
          },
          onDoubleTap: (){
            print("double!");
          },
          onLongPress: (){
            Fluttertoast.showToast(
              msg: "왜 이름이 토스트 .... ?",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 30.0,
            );
          },
          child: Image.asset("flutter3.PNG"),
        ),
      ),
    );
  }
}
