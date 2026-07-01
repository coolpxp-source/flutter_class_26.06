import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // debug 뱃지 지우기
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightGreen // 테마색 지정
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              "타이틀",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
                letterSpacing: 2,
                decoration: TextDecoration.underline,
                decorationColor: Colors.redAccent,
                decorationStyle: TextDecorationStyle.dashed,
              ),
          ),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
            IconButton(onPressed: (){}, icon: Icon(Icons.home)),
          ],
        ),
        drawer: Drawer(),
        body: Center(
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: (){
                    print("클릭함");
                  },
                  child: Text("선택"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.limeAccent,
                    foregroundColor: Colors.black,
                    shadowColor: Colors.green,
                    elevation: 5, // shadow 효과 범위 지정 클 수록 번짐 효과
                    shape: RoundedRectangleBorder( // 테두리의 모서리
                      borderRadius: BorderRadius.circular(15)
                    ),
                    side: BorderSide(
                      color: Colors.blueGrey
                    ) // border color
                  )
              ),
              MyButton(text : Text("하이")),
              MyButton(text : Text("ㅎㅎ")),
              MyButton(text : Text("ㅋㅋ")),
              MyButton(text : Text("반갑습니다.")),
            ],
          ),

        ),
        bottomNavigationBar: BottomAppBar(),

      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Text text;
  const MyButton({super.key, required Text this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        print("클릭함");
      },
        child: text,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.limeAccent,
          foregroundColor: Colors.black,
          shadowColor: Colors.green,
          elevation: 5, // shadow 효과 범위 지정 클 수록 번짐 효과
          shape: RoundedRectangleBorder( // 테두리의 모서리
            borderRadius: BorderRadius.circular(15)
          ),
          side: BorderSide(
            color: Colors.blueGrey
          ) // border color
      )
    );
  }
}
