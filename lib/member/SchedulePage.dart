import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';


class SchedulePage extends StatefulWidget {
  final String memberDocId; // 로그인한 회원의 문서 ID

  const SchedulePage({super.key, required this.memberDocId});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  TextEditingController scheduleCtrl = TextEditingController();

  Future<void> addSchedule() async {
    // 문서의 하위 컬랙션에 추가
    await fs.collection("member") // 상위 문서 접근
        .doc(widget.memberDocId)
        .collection("schedule") // 하위 문서 컬렉션명으로 접근
        .add({
          "content" : scheduleCtrl.text,
          "date" : "7월 10일"
        });
    scheduleCtrl.clear();
  }

  Future<void> deleteSchedule(String scheduleDocId) async {
    await fs.collection("member")
        .doc(widget.memberDocId)
        .collection("schedule")
        .doc(scheduleDocId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('개인일정관리')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: scheduleCtrl,
                    decoration: InputDecoration(
                      labelText: '새 일정',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addSchedule,
                  child: Text('추가'),
                ),
              ],
            ),
          ),
          Expanded(
            // 해당 회원의 하위 컬렉션(schedules)만 실시간 스트림으로 가져옴
            child: StreamBuilder(
              stream: fs.collection("member")
                      .doc(widget.memberDocId)
                      .collection("schedule")
                      .snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                if(docs.isEmpty){
                  return Center(child: Text('등록된 일정이 없습니다.'));
                }
                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      return ListTile(
                        leading: IconButton(onPressed: (){}, icon: Icon(Icons.schedule)),
                        title: Text(doc["content"]),
                        subtitle: Text(doc["date"]), 
                        trailing : IconButton(
                            onPressed: (){
                              deleteSchedule(doc.id);
                            },
                            icon: Icon(Icons.delete)
                        )
                      );
                    },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}