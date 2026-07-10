import 'package:flutter/material.dart';

// 1. 메인 실행부
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('결제 메인')),
        body: Center(
          // 2. RequestPayment 위젯 사용
          child: RequestPayment(
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    // 결제 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Payment()),
                    );
                  },
                  child: const Text('결제하기'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// 3. RequestPayment 위젯 정의 (요청하신 부분)
class RequestPayment extends StatelessWidget {
  final Widget child;

  const RequestPayment({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}

// 4. 결제 페이지 화면
class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('결제 화면')),
      body: const Center(child: Text('결제 진행 중...')),
    );
  }
}