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
  double x = 150;
  double y = 150 ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: y, left: x,
                child:GestureDetector(
                  onPanUpdate: (e){
                    setState(() {
                      x+= e.delta.dx;
                      y+= e.delta.dy;
                    });
                  },
                  child: Container(
                    height: 100, width: 100, color: Colors.green,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
