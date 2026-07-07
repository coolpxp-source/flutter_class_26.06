import 'package:flutter/material.dart';
import 'package:project1/memo/Edit.dart';
import 'MemoDB.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Map<String, dynamic>> list = [];

  @override
  void initState() {
    super.initState();
    _selectMemoList();
  }

  Future<void> _selectMemoList() async {
    var tempList = await DB.selectMemoList();
    setState(() {
      list = tempList;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF8BBD0),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8BBD0),
              Color(0xFFBBDEFB),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 360,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                /// 헤더
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.list_alt,
                        color: Colors.pink,
                        size: 26,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '메모 목록',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                /// 리스트
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 제목 + 아이콘
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item['title']?? '(제목 없음)' ,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async{
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditScreen(id: item['id']),
                                        )
                                    );
                                    if (result == true) {
                                      _selectMemoList();
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    // 삭제 기능 연결 예정
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("삭제"),
                                          content: Text("'${item['title']}' 메모를 정말 삭제하시겠습니까?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await DB.deleteMemo(item['id']);
                                                Navigator.of(context).pop();
                                                _selectMemoList();
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
                                  },
                                ),
                              ],
                            ),

                            SizedBox(height: 6),

                            /// 내용
                            Text(
                              item['content'] ?? '(내용 없음)',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),

                            SizedBox(height: 10),

                            /// 날짜
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                item['date'] ?? '(날짜 없음)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
