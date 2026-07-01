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
  TextEditingController idCtrl = TextEditingController(); // new 키워드 없이 생성자 생성

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: idCtrl,
                  // obscureText: true,
                  decoration: InputDecoration(
                    labelText: "아이디",
                    hintText: "ex) test1234",
                    prefixIcon: Icon(Icons.perm_identity),
                    suffixIcon: Icon(Icons.check_circle, color: Colors.green,),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.yellow[100],
                    // enabled: false
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      print("입력 된 아이디 : ${idCtrl.text}");
                    },
                    child: Text("로그인")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
