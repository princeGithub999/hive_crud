import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/Model/notes_model.dart';
import 'package:image_picker/image_picker.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  var userName = TextEditingController();
  var userEmail = TextEditingController();
  File? _imageFile; // Make it nullable
  ImagePicker pickImage = ImagePicker();



  void addData() async {
    var box = await Hive.openBox<NotesModel>('Notes');
    var newUser = NotesModel(
      name: userName.text,
      email: userEmail.text,
      image: _imageFile!.path
    );

    box.add(newUser);
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'User added');
  }

  void imagePicker() async {
    final pick = await pickImage.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(() {
        _imageFile = File(pick.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'Add UserData',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                imagePicker();
              },
              child: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                maxRadius: 59,
                child: ClipOval(
                  child: _imageFile != null
                ? Image.file(_imageFile!,fit: BoxFit.cover,width: 110,height: 110,) // Display picked image
                      : const Center(child: Icon(Icons.person,size: 100,color: Colors.white,),),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: userName,
              decoration: const InputDecoration(
                hintText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: userEmail,
              decoration: const InputDecoration(
                hintText: "Enter Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addData();
              },
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: Colors.greenAccent,
              ),
              child: const Text(
                "Add Data",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
