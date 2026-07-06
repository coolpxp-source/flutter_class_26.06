import 'dart:math';
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
  Random ran = Random();
  static const double boxSize = 50;
  List<Widget> list = [];
  int nextNumber = 1; // 다음에 눌러야 하는 숫자

  void createdBox() {
    final screenSize = MediaQuery.of(context).size;
    List<Widget> tempList = [];
    for (int i = 1; i <= 10; i++) {
      tempList.add(_buildBox(i, screenSize));
    }
    setState(() {
      list = tempList;
      nextNumber = 1; // 재배치할 때 순서 초기화
    });
  }

  Widget _buildBox(int number, Size screenSize) {
    return Positioned(
      key: ValueKey(number), // 숫자별로 구분되게 key 부여
      left: ran.nextDouble() * (screenSize.width - boxSize),
      top: ran.nextDouble() * (screenSize.height - boxSize - 50),
      child: GestureDetector(
        onTap: () => removeBox(number),
        child: Container(
          width: boxSize,
          height: boxSize,
          color: Colors.lightGreen[100],
          alignment: Alignment.center,
          child: Text("$number"),
        ),
      ),
    );
  }

  void removeBox(int number) {
    if (number == nextNumber) {
      setState(() {
        list.removeWhere((widget) => (widget.key == ValueKey(number)));
        nextNumber++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: list,
              ),
            ),
            Container(
              height: 50,
              color: Colors.yellow[100],
              child: Center(
                child: ElevatedButton(
                  onPressed: createdBox,
                  child: const Text("박스 생성"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}