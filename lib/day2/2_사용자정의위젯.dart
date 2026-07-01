import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug 뱃지 지우기
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.lightGreen // 테마색 지정
      ),
      home: Column(
        children: [
          Container(
            width: 150, height: 150,
            color: Colors.blue,
            child: Center(
              child: Text("box1"),
            )
          ),
          MyBox(150,150,Colors.yellow, "box2"), // 하단에서 만든 MyBox 호출
          MyBox(100,100,Colors.orange, "box3"),
        ],
      ),
    );
  }
}

class MyBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String txt;
  const MyBox(double this.width, double this.height, Color this.color, String this.txt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      color: color,
      child: Text(txt),
    );
  }
}


