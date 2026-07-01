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
      home: Scaffold(
        body: GridView.builder( // .builder -> 반복문
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 한 행에 몇개를 넣을 것인지?
                crossAxisSpacing: 10, // 가로 여백
                mainAxisSpacing: 10, // 세로 여백
            ),
            itemCount: 12, // 전체 갯수
            itemBuilder: (context, index){
              return Container(
                  color: Colors.blue[100 * ((index % 9)+1)],
                  child: Center(child: Text(
                      "${index+1}", style: TextStyle(color: Colors.white,)
                  ),
                )
              );
            },
       ),
      ),
    );
  }
}
