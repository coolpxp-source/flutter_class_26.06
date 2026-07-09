import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

void main() async {
  // Flutter 프레임워크와의 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Firebase 초기화 설정
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  Future<void> addUser() async{
    Map<String,dynamic> user = {
      "name" : nameCtrl.text,
      "age" : int.parse(ageCtrl.text),
      "cdate" : Timestamp.now()
    };
    await fs.collection("users").add(user);

    nameCtrl.clear();
    ageCtrl.clear();
  }

  Future<void> updateUser(String name, int newAge) async {
    QuerySnapshot result = await fs.collection("users")
        .where("name", isEqualTo: name)
        .get();

    for (var doc in result.docs) {
      await fs.collection("users").doc(doc.id).update({
        "age": newAge,
      });
    }
  }


  Future<void> deleteUser(String docId) async{
    await fs.collection("users").doc(docId).delete();
  }

  Widget getUserList(){
    return StreamBuilder(
        stream: fs.collection("users").snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator()
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((doc){
              return ListTile(
                leading: Icon(Icons.person),
                title : Text("문서 ID: ${doc.id}"),
                subtitle: Text("나이 : ${doc["age"]}, 이름 : ${doc["name"]}"),
                trailing: IconButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text("삭제 확인"),
                            content: const Text("정말 삭제하시겠습니까?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext); // 다이얼로그 닫기
                                },
                                child: const Text("취소"),
                              ),
                              TextButton(
                                onPressed: () {
                                  fs.collection("users").doc(doc.id).delete();
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text("삭제"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete)
                ),
              );
            }).toList(), //
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("파이어스토어"),),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: "이름",
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(width: 10, height: 10,),
                TextField(
                  controller: ageCtrl,
                    decoration: InputDecoration(
                      labelText: "나이",
                      border: OutlineInputBorder()
                    )
                ),
                SizedBox(width: 10, height: 10,),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          addUser();
                        },
                        child: Text("저장")
                    ),
                    ElevatedButton(
                        onPressed: (){
                          updateUser(nameCtrl.text, int.parse(ageCtrl.text));
                        },
                        child: Text("수정")
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(child: getUserList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
