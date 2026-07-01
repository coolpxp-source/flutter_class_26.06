import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 우측 상단의 DEBUG 배너를 숨깁니다.
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // 1. 상단 앱바
        appBar: AppBar(
          title: const Text("타이틀 영역!!"),
          backgroundColor: Colors.blue[100],
        ),

        // 2. 좌측 사이드 메뉴 (Drawer)
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero, // 상단 시스템 바 영역까지 꽉 채우기
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.brown[200]),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/flutter.png"), // 보통 assets 폴더 경로 지정
                    ),
                    SizedBox(height: 10),
                    Text(
                      "몬치치",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "monchichi@cute.com",
                      style: TextStyle(fontSize: 12, color: Colors.brown, fontWeight: FontWeight.bold),
                    ), // ◀ 이 부분들의 닫는 괄호들( ), ])이 누락되었던 것을 수정했습니다.
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('홈'),
                onTap: () {},
              ),
              Divider(height: 2, color: Colors.grey),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('설정'),
                onTap: () {},
              ),
              Divider(height: 2, color: Colors.grey),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('로그아웃'),
                onTap: () {},
              ),
              Divider(height: 2, color: Colors.grey)
            ],

          ),
        ),

        // 3. 중앙 본문 영역
        body: Align(
          alignment: Alignment.topCenter,
          child :  Container(
            height: 100, width: double.infinity,
            color: Colors.redAccent,
            // margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
            padding: EdgeInsets.all(10),
            child: Text("hello flutter"),
          )
        ),

        // 4. 하단 네비게이션 바
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.home), iconSize: 30),
              IconButton(onPressed: () {}, icon: const Icon(Icons.login), iconSize: 30),
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout), iconSize: 30),
            ],
          ),
        ),
      ),
    );
  }
}