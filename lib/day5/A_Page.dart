import 'package:flutter/material.dart';
import 'package:project1/day5/B_Page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: APage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class APage extends StatefulWidget {
  const APage({super.key});

  @override
  State<APage> createState() => _APageState();
}

class _APageState extends State<APage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A 페이지"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BPage(msg: '',)),
                );
              },
              child: const Text("이동"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BPage(msg : "A 페이지에서 보냈습니다.")),
                );
              },
              child: const Text("값 보내기"),
            ),
          ],
        ),
      ),
    );
  }
}