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
    TextEditingController numCtrl = TextEditingController(); // new 키워드 없이 생성자 생성
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("계산기",
                style: TextStyle(fontSize: 30),
              ),
              TextField(
                controller: numCtrl,
                // obscureText: true,
                decoration: InputDecoration(
                  labelText: "숫자",
                  hintText: "ex) 1234",
                  prefixIcon: Icon(Icons.calculate),
                  suffixIcon: Icon(Icons.check_circle, color: Colors.green,),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[100],
                  // enabled: false
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: GridView.builder( // .builder -> 반복문
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 한 행에 몇개를 넣을 것인지?
                    crossAxisSpacing: 5, // 가로 여백
                    mainAxisSpacing: 5, // 세로 여백
                  ),
                  itemCount: labels.length, // 전체 갯수
                  itemBuilder: (context, index){
                    return ElevatedButton(
                        onPressed: (){},
                        child: Center(child: Text(labels[index], style: TextStyle(color: Colors.black, fontSize: 30),)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ((index + 1) % 4 == 0 || index < 4)
                                ? Colors.blue[100]
                                : Colors.grey[200],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
                        )
                    );
                  }
                ),
              ),
            ],
          ),
        )
      )
   );
  }
}
