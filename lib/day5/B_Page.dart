import 'package:flutter/material.dart';

class BPage extends StatefulWidget {
  final String msg;
  const BPage({super.key, required this.msg});

  @override
  State<BPage> createState() => _BPageState();
}

class _BPageState extends State<BPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("B 페이지"),
      ),
      body: Center(
        child: Text(
          widget.msg.isEmpty
              ? "B페이지, 전달 받은 값 없음."
              : widget.msg,
        ),
      ),
    );
  }
}