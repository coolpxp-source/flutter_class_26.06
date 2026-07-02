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
  var subject = "java";
  var gender = "male";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            RadioGroup(
                groupValue: subject,
                onChanged: (value){
                  setState(() {
                    subject = value!;
                  });
                },
                child: Column(
                  children: [
                    RadioListTile(value: "java", title: Text("자바")),
                    RadioListTile(value: "oracle", title: Text("오라클")),
                    RadioListTile(value: "mySql", title: Text("MySQL")),
                    RadioListTile(value: "flutter", title: Text("flutter")),
                  ],
                )
            ),
            Divider(height: 2, color: Colors.green,),
            RadioGroup(
                groupValue : gender,
                onChanged: (value){
                  setState(() {
                    gender = value!;
                  });
                },
                child: Column(
                  children: [
                    RadioListTile(value: "male", title: Text("남자")),
                    RadioListTile(value: "female", title: Text("여자")),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
