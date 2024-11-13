import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_crud/auth_page/log_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();


  void signUpData() async{

    String name = userName.text;
    String email = userEmail.text;
    String password = userPassword.text;

   if(name.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
     var box = await Hive.openBox('auth');
     box.put('userName', name);
     box.put('userEmail', email);
     box.put('userPassword', password);

     Fluttertoast.showToast(msg: 'Sign Up Success');

     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage(),));
   }else{
     Fluttertoast.showToast(msg: 'please fell all details');
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
              padding:  EdgeInsets.only(top: 150,left: 30,right: 30),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sign Up', style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(height: 150,),

                  Card(
                    elevation: 10,
                    color: Colors.white70,
                    child: TextField(
                        controller: userName,
                      decoration: const InputDecoration(
                          hintText: 'Enter Name',
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
                    color: Colors.white70,
                    elevation: 10,
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
            padding: const EdgeInsets.only(left: 30,top: 40),
            child: ElevatedButton(onPressed: () {
              signUpData();

            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
                elevation: 10,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
              ), child: const Text('Sign Up',style: TextStyle(color: Colors.black),),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100,top: 200),
            child: Row(
              children: [
                Text('Have all ready account',style: TextStyle(color: Colors.white,fontSize: 15),),
                TextButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage(),));
                }, child: Text('Login',style: TextStyle(color: Colors.red),))
              ],
            ),
          )
        ],
      ),
     );
  }
}
