import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductEdit extends StatefulWidget {
  final String docId; // 수정할 문서의 ID를 밖에서 받아옴

  const ProductEdit({super.key, required this.docId});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  bool isLoading = true; // 데이터 불러오는 중인지 표시

  @override
  void initState() {
    super.initState();
    loadProductData(); // 화면 생성되자마자 기존 데이터 불러오기
  }

  Future<void> loadProductData() async {
    var doc = await fs.collection("Products").doc(widget.docId).get();

    if (doc.exists) {
      setState(() {
        nameCtrl.text = doc["name"];
        categoryCtrl.text = doc["category"];
        priceCtrl.text = doc["price"].toString();
        descCtrl.text = doc["description"];
        isLoading = false;
      });
    }
  }

  Future<void> updateProduct() async {
    Map<String, dynamic> updatedData = {
      "name": nameCtrl.text,
      "category": categoryCtrl.text,
      "price": int.parse(priceCtrl.text),
      "description": descCtrl.text,
    };

    await fs.collection("Products").doc(widget.docId).update(updatedData);

    if (mounted) {
      Navigator.pop(context); // 수정 끝나면 이전 화면(목록)으로 돌아감
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    categoryCtrl.dispose();
    priceCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("제품 수정"),
        backgroundColor: Color(0xFFF8BBD0),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "제품 정보",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: "제품명",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: categoryCtrl,
              decoration: InputDecoration(
                labelText: "카테고리",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "가격",
                prefixText: '₩',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "상세 설명",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            TextField(
              controller: descCtrl,
              decoration: InputDecoration(
                labelText: "제품에 대한 설명을 입력해주세요.",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                updateProduct();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF8BBD0),
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("수정 완료"),
            )
          ],
        ),
      ),
    );
  }
}