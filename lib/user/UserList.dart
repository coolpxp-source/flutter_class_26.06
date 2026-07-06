import 'package:flutter/material.dart';
import 'DB.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Map<String, dynamic>> list = [];
  bool isLoading = true;

  @override
  void initState() { // 화면에 들어오자마자 출력
    super.initState();
    _selectUserList();
    // print(list);
  }

  Future<void> _selectUserList() async {
    var tempList = await DB.selectUserList();
    setState(() {
      list = tempList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (list.length > 1) {
      print(list[1]["name"]);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("사용자 목록"),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.home),
              title: Text("집 고고"),
              subtitle: Text("렛츠고 ~"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit),
                  Icon(Icons.delete)
                ],
              ),
            );
          },
      )
    );
  }
}