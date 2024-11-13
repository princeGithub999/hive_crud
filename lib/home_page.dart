import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/Model/notes_model.dart';
import 'package:hive_crud/add_data_page.dart';
import 'package:hive_crud/auth_page/log_in_page.dart';
import 'package:hive_crud/auth_page/sign_up_page.dart';
import 'package:hive_crud/update_data.dart';
import 'package:hive_flutter/adapters.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void deleteData(int index)async{
    var box = await Hive.openBox<NotesModel>('Notes');
    box.deleteAt(index);
    setState(() {

    });
  }

  void logOutData()async{
    var box = await Hive.openBox('auth');
    box.put('isLogin', false);

    Fluttertoast.showToast(msg: 'logOut success');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage(),));

  }
  @override
  Widget build(BuildContext context) {

    var box = Hive.box<NotesModel>('Notes');

    return Scaffold(
      appBar: AppBar(title:  Text('Hive Database',style: TextStyle(color: Colors.white),
      ),
        backgroundColor: Colors.greenAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton.icon(onPressed: () {
              logOutData();
            }, label: Icon(Icons.logout,color: Colors.white,)),
          )
        ],

      ),


      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<NotesModel> box,_) {
          if(box.isEmpty){
            return Center(child: Text('No User'),);
          }else{
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context,index){
                  var user = box.getAt(index);
                  return Card(
                    elevation: 10,
                    shadowColor: Colors.greenAccent,
                    child: InkWell(
                      onLongPress: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateData(
                          userName:user.name,
                          userEmail:user.email,
                          index:index,
                          userImage:user.image!
                        ),));
                      },
                      child: ListTile(
                        leading: CircleAvatar(

                          backgroundColor: Colors.greenAccent,
                          maxRadius: 30,
                          child: ClipOval(
                            child: user != null && user.image != null && user.image!.isNotEmpty
                                ? Image.file(File(user.image!),
                              fit: BoxFit.cover, // Ensure the image fits well within the circle
                              width: 50,
                              height: 50,
                            )
                                : const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        title: Text(user!.name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),),
                        subtitle: Text(user.email,style:  TextStyle(fontSize: 17,fontWeight: FontWeight.w300),),

                        trailing: IconButton(onPressed: () {
                          deleteData(index);
                        }, icon: Icon(Icons.delete),),
                      ),
                    ),
                  );
                  }),
            );
          }
        },

      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.greenAccent,
          label: const Text("Add Data",style: TextStyle(color: Colors.white),),
          icon: const Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddDataPage(),));
          }),
    );
  }
}
