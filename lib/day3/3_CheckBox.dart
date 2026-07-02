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
  List<String> checkList = [];
  List<String> imgList = [
    "flutter.PNG" , "flutter2.PNG", "flutter3.PNG"
  ];

  void listChange(String item, bool flg){
    if(flg){
      checkList.add(item);
    }else{
      checkList.remove(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              CheckboxListTile(
                  value: checkList.contains(imgList[0]),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("몬치치"),
                  subtitle: Text("몬치치 아는 사람?"),
                  onChanged: (value){
                    setState(() {
                      listChange(imgList[0], value!);
                    });
                  }
              ),
              CheckboxListTile(
                  value: checkList.contains(imgList[1]),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("몬치치2"),
                  subtitle: Text("몬치치 아는 사람?"),
                  onChanged: (value){
                    setState(() {
                      listChange(imgList[1], value!);
                    });
                  }
              ),
              CheckboxListTile(
                  value: checkList.contains(imgList[2]),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text("몬치치3"),
                  subtitle: Text("몬치치 아는 사람?"),
                  onChanged: (value){
                    setState(() {
                      listChange(imgList[2], value!);
                    });
                  }
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 한 행에 몇개를 넣을 것인지?
                    crossAxisSpacing: 10, // 가로 여백
                    mainAxisSpacing: 10, // 세로 여백
                  ),
                  itemCount: checkList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset("assets/${checkList[index]}");
                },
                ),
              )
            ],
          ),
        )
    );
  }
}
