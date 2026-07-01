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
      home: Scaffold(
        body: Row(
          children: [
            Container(width: 150, color: Colors.blue,),
            Expanded(child: Container( color: Colors.green,)) // 나머지 공간을 유동적으로 채우기
          ],
        ),
      ),
    );
  }
}
