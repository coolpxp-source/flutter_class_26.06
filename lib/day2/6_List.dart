import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = ["떡볶이","순대","모둠튀김"];
    List<IconData> iconList = [Icons.food_bank, Icons.home, Icons.star];
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: Icon(iconList[index] as IconData?),
                title: Text(list[index]),
                onTap: (){},
              );
            },
        ),
      ),
    );
  }
}
