import 'package:flutter/material.dart';
import 'MemoDB.dart';

class EditScreen extends StatefulWidget {
  final int id;
  const EditScreen({super.key, required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMemo();
  }

  Future<void> _loadMemo() async {
    var memo = await DB.selectMemoById(widget.id); // DB.dart에 이 함수 필요
    titleCtrl.text = memo['title'];
    contentCtrl.text = memo['content'];
    setState(() {});
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
            width: 340,
            padding: EdgeInsets.all(24),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 헤더
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.edit_note,
                        color: Colors.blue,
                        size: 26,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '메모 작성',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28),

                /// 제목
                Text(
                  '제목',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: titleCtrl,
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 20),
                /// 내용
                Text(
                  '내용',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: contentCtrl,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: '내용을 입력하세요',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 28),

                /// 저장 버튼
                GestureDetector(
                  onTap: () async {
                    await DB.updateMemo( // DB.dart에 이 함수 필요
                      titleCtrl.text,
                      contentCtrl.text,
                      widget.id,
                    );
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '저장하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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