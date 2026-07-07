import 'package:flutter/material.dart';
import 'DB.dart';

class UserEdit extends StatefulWidget {
  final int userId;
  const UserEdit({super.key, required this.userId});

  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  // 수정할 사용자의 기존 정보를 불러와서 입력창에 채워넣기
  Future<void> _loadUser() async {
    var user = await DB.selectUserById(widget.userId);
    nameCtrl.text = user["name"].toString();
    ageCtrl.text = user["age"].toString();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _updateUser() async {
    String name = nameCtrl.text;
    int age = int.tryParse(ageCtrl.text) ?? 0;
    await DB.updateUser(name, age, widget.userId);
    Navigator.pop(context, true); // true를 넘겨서 "수정 완료"를 이전 화면에 알림
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("사용자 정보 수정"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "이름"),
            ),
            TextField(
              controller: ageCtrl,
              decoration: const InputDecoration(labelText: "나이"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUser,
              child: const Text("수정 완료"),
            ),
          ],
        ),
      ),
    );
  }
}