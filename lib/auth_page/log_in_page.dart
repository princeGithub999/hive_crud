import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/auth_page/sign_up_page.dart';
import 'package:hive_crud/home_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {


  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  bool isLogin = false;

  void loginData()async{


    setState(() {
      isLogin = true;
    });
        var email = userEmail.text;
        var password = userPassword.text;

        var box = await Hive.openBox('auth');
        var gEmail = box.get('userEmail');
        var gPassword = box.get('userPassword');
        box.put('isLogin', isLogin);

        if(gEmail == email && gPassword == password){

          Fluttertoast.showToast(msg: 'Login success');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }else{
          Fluttertoast.showToast(msg: 'wrong password');
        }
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context);
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/images/img_1.png',fit: BoxFit.cover,width: sizes.size.width *1,),
            Padding(
              padding:  const EdgeInsets.only(top: 150,left: 30,right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Log in', style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 150,),

                  Card(
                    elevation: 10,
                    color: Colors.white70,
                    child: TextField(
                      controller: userEmail,
                      decoration: const InputDecoration(
                          hintText: 'Enter Email',
                          border: OutlineInputBorder(

                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))


                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  Card(
                    elevation: 10,
                    color: Colors.white70,
                    child: TextField(
                        controller: userPassword,
                      decoration: const InputDecoration(
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(

                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))


                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),

                  ElevatedButton(onPressed: () {
                    loginData();
                  },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ), child: const Text('Log in',style: TextStyle(color: Colors.black),),

                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Image.asset('assets/images/img_4.png',fit: BoxFit.cover,width: sizes.size.width *1,),

          Padding(
            padding: const EdgeInsets.only(left: 100,top: 200),
            child: Row(
              children: [
                Text(" don't Have all ready account",style: TextStyle(color: Colors.white,fontSize: 15),),
                TextButton(onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                }, child: Text('Login',style: TextStyle(color: Colors.red,fontSize: 18),))
              ],
            ),
          )
        ],
      ),

    );
  }
}
