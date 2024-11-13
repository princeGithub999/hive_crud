import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/auth_page/log_in_page.dart';
import 'package:hive_crud/auth_page/sign_up_page.dart';
import 'package:hive_crud/home_page.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {



 @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),()async{

      var box = await Hive.openBox('auth');
      bool?  isLogin = box.get('isLogin');

      if(isLogin == true && isLogin!){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage(),));

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.greenAccent,
    );
  }
}
