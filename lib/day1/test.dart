import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("테스트!"),
          backgroundColor: Colors.blue[100],
        ),
        drawer: Drawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("가운데", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Icon(Icons.star, size: 150, color: Colors.yellow,),
              SizedBox(height: 10,),
              Container(
                height: 100, width: 100,
                color: Colors.black,
                padding: EdgeInsets.all(10),
                child: Center(child: Text("네모박스", style: TextStyle(color: Colors.white),)),
              )
            ],
          )
        ),
      ),
    );
  }
}
