import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/routeRoot.dart';

void main() {
  runApp(const ImagePickerScreen());
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker(); // 이제 정상 동작

  Future<void> pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> takePhoto() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("이미지 선택")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300, height: 300,
                decoration: BoxDecoration(),
                child:  _image != null ? ClipOval(
                  child: Image.file(_image!, fit: BoxFit.cover,),
                ) : Center(child: Text("이미지 선택되지 않았음"),),
              ), // 이미지 출력
              SizedBox(height: 10,),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: takePhoto,
                      child: Text("카메라 촬영")
                  ),
                  ElevatedButton(
                      onPressed: pickImage,
                      child: Text("사진첩 선택")
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}