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
  Offset p = Offset(100, 150); // x=100 , y=150

  late List<Widget> list = [
    Positioned(
      top: p.dx, left: p.dy,
      child: Container(
      height: 50, width: 50, color: Colors.limeAccent,
    )),
    Positioned(
        top: 100, left: 100,
        child: Container(
          height: 50, width: 50, color: Colors.amber,
        )),
    Positioned(
        top: 150, left: 150,
        child: Container(
          height: 50, width: 50, color: Colors.green,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: list,
      ),
    );
  }
}
