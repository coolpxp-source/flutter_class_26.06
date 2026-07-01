import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            ListTile(leading: 
              Image.asset("flutter.png"),
              title: Text("몬치치", style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("원숭이치치 가지고 싶다"),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
              onTap: (){
                print("클릭됨");
              },
            ),
            Divider(height: 3, color: Colors.black,),
            ListTile(leading:
            Image.asset("flutter2.png"),
              title: Text("몬치치", style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("원숭이치치 가지고 싶다"),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
              onTap: (){
                print("클릭됨");
              }),
            Divider(height: 3, color: Colors.black,),
            ListTile(leading:
            Image.asset("flutter3.png"),
                title: Text("몬치치", style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("원숭이치치 가지고 싶다"),
                trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                onTap: (){
                  print("클릭됨");
                }),
          ],
        ),
      ),
    );
  }
}
