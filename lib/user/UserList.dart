import 'package:flutter/material.dart';
import 'DB.dart';
import 'UserEdit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Map<String, dynamic>> list = [];

  Future<void> _selectUserList() async {
    var tempList = await DB.selectUserList();
    setState(() {
      list = tempList;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectUserList();
  }

  void _showDeleteDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("삭제"),
          content: Text("${user['name']}님을 정말 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () async {
                await DB.deleteUser(user["userId"]);
                Navigator.of(context).pop();
                _selectUserList();
              },
              child: const Text("삭제"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("취소"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("사용자 목록"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          var user = list[index];
          return Slidable(
            key: ValueKey(user["userId"]),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserEdit(userId: user["userId"]),
                      ),
                    );
                    if (result == true) {
                      _selectUserList();
                    }
                  },
                  backgroundColor: const Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: '수정',
                ),
                SlidableAction(
                  onPressed: (context) {
                    _showDeleteDialog(user);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: '삭제',
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: Text("아이디 : ${user["userId"]}, 이름 : ${user["name"]}"),
              subtitle: Text("나이 : ${user["age"]}"),
            ),
          );
        },
      ),
    );
  }
}