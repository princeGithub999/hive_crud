import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/Model/notes_model.dart';
import 'package:image_picker/image_picker.dart';

class UpdateData extends StatefulWidget {
   final String userName;
   final String userEmail;
   final int  index;
   final String userImage;

  const UpdateData({super.key, required this.userEmail, required this.userName, required this.index, required this.userImage, });

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {


  var updateName = TextEditingController();
  var updateEmail = TextEditingController();
  
  File ? _imageFile;
  ImagePicker imagePicker = ImagePicker();


  @override
  void initState() {
    super.initState();
    updateName = TextEditingController(text: widget.userName);
    updateEmail = TextEditingController(text: widget.userEmail);

  }
  
  void pickImageF()async{
    var pickImageFile = await imagePicker.pickImage(source: ImageSource.gallery);

        if(pickImageFile != null){
          setState(() {
            _imageFile = File(pickImageFile.path);
          });
        }
    
     }

  void updateData() async{
    var box = await Hive.openBox<NotesModel>('Notes');

    var userData = NotesModel(
        name: updateName.text,
        email: updateEmail.text,
        image: _imageFile!=null ? _imageFile!.path : widget.userImage,

    );
    box.putAt(widget.index, userData);

    Fluttertoast.showToast(msg: 'Update data');
    Navigator.pop(context);

    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('User Update Data',style: TextStyle(color: Colors.white),),
      ),
      body:SingleChildScrollView(
        child:  Padding(
          padding:  EdgeInsets.only(top: 80, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              InkWell(
                onTap: () {
                  pickImageF();
                },
                child: CircleAvatar(
                  maxRadius: 59,
                  backgroundColor: Colors.greenAccent,
                  child: ClipOval(
                    child: _imageFile != null ?
                    Image.file(_imageFile!,width: 110,height: 110,fit: BoxFit.cover,)
                        : Image.file(File(widget.userImage,),width: 110,height: 110,fit: BoxFit.cover,),
                  ) ,

                ),
              ),

              SizedBox(height: 20,),

              TextField(
                controller: updateName,
                decoration: const InputDecoration(
                  hintText: "Enter Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25),

              TextField(
                controller: updateEmail,
                decoration: const InputDecoration(
                  hintText: "Enter Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  updateData();

                 },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.greenAccent,
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
