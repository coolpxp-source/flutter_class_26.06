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
            Flexible(flex: 1, child: Container(color: Colors.green,), ), // Flexible의 default = 1
            Flexible(flex: 2, child: Column(
              children: [
                Flexible( flex: 2,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Flexible(flex: 1,
                  child: Container(
                    color: Colors.yellow,
                  ),
                ),
                Flexible(flex: 1,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ],
            ), ), // flex 비율 변경 가능
            Flexible(child: Container(color: Colors.redAccent,), flex: 1,)
          ],
        ),
      ),
    );
  }
}
