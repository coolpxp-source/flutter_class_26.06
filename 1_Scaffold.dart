import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 최상위 고정
      home: Scaffold(
        appBar: AppBar(
          title : Text("타이틀 영역!"),
          backgroundColor: Colors.blue[100],
        ),
        drawer: Drawer(),
        body: Container(),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.home), iconSize: 40,),
              IconButton(onPressed: (){}, icon: Icon(Icons.login), iconSize: 40,),
              IconButton(onPressed: (){}, icon: Icon(Icons.logout), iconSize: 40,),
            ],
          ),
        ),

      ),
    );

  }
}
