import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'ProductEdit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  int _selectedIndex = 0; // 탭 인덱스는 딱 한 번만 선언

  Future<void> addProduct() async {
    Map<String, dynamic> product = {
      "name": nameCtrl.text,
      "category": categoryCtrl.text,
      "price": int.parse(priceCtrl.text),
      "description": descCtrl.text,
      "date": Timestamp.now()
    };
    await fs.collection("Products").add(product);

    nameCtrl.clear();
    categoryCtrl.clear();
    priceCtrl.clear();
    descCtrl.clear();
  }

  Future<void> deleteProduct(String docId) async {
    await fs.collection("Products").doc(docId).delete();
  }

  Future<void> updateProduct(String docId, int newPrice) async {
    await fs.collection("Products").doc(docId).update({
      "price": newPrice,
    });
  }

  Widget buildProductListPage() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _selectedIndex = 1; // 등록 탭으로 이동
            });
          },
        ),
        title: Text("제품 목록"),
        backgroundColor: Color(0xFFF8BBD0),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: fs.collection("Products").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(doc["name"]),
                subtitle: Text(
                  "${doc["category"]} · ₩${doc["price"]}\n${doc["description"]}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductEdit(docId: doc.id),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text("삭제 확인"),
                              content: const Text("정말 삭제하시겠습니까?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text("취소"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteProduct(doc.id);
                                    Navigator.pop(dialogContext);
                                  },
                                  child: const Text("삭제"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget buildProductAddPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("제품 등록"),
        backgroundColor: Color(0xFFF8BBD0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "제품 정보",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                addProduct();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF8BBD0),
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("제품 등록하기"),
            )
          ],
        ),
      ),
    );
  }

  // ---------------- 마이페이지 (임시) ----------------
  Widget buildMyPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이페이지"),
        backgroundColor: Color(0xFFF8BBD0),
        centerTitle: true,
      ),
      body: Center(child: Text("마이페이지 준비 중")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 탭 목록을 build() 안에서 만들어서 항상 최신 상태를 반영
    final List<Widget> pages = [
      buildProductListPage(),
      buildProductAddPage(),
      buildMyPage(),
    ];

    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "목록"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "등록"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이페이지"),
          ],
        ),
      ),
    );
  }
}