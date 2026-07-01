import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      'C', '(', '%', '/',
      '7', '8', '9', '*',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '0', '00', '.', '='
    ];
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder( // .builder -> 반복문
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 한 행에 몇개를 넣을 것인지?
            crossAxisSpacing: 5, // 가로 여백
            mainAxisSpacing: 5, // 세로 여백
          ),
          itemCount: labels.length, // 전체 갯수
          itemBuilder: (context, index){
            return ElevatedButton(
                onPressed: (){},
                child: Center(child: Text(labels[index], style: TextStyle(color: Colors.black),)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: ((index + 1) % 4 == 0 || index < 4)
                        ? Colors.blue[100]
                        : Colors.grey[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                )
            );
          }
        )
      )
   );
  }
}
