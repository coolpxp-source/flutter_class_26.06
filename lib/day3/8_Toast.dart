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
        body: Center(
          child: ElevatedButton(
              onPressed: (){
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
              child: Text("이게 토스트?")),
        ),
      ),
    );
  }
}
