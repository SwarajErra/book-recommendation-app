import 'package:book_recommendation_app/Views/Home.dart';
import 'package:book_recommendation_app/Views/register.dart';
import 'package:book_recommendation_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AccessToken? accessToken;




  TextEditingController emailIdController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                 Image.asset("Assets/images/blurb_logo.png" , width: 170,),
              Container(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey , width: 2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(controller: emailIdController,decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),)),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey , width: 2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(controller: passController,decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          border: InputBorder.none,
                          hintText: 'Password',

                        ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        )),
                    SizedBox(height: 10,),
                    TextButton(  child: Text("Forget Your Password?"),

                        onPressed: emailIdController.text.trim().isEmpty ? null :  () async{


                      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailIdController.text.trim());
                    },
                   ),
                    SizedBox(height: 20,),


                    SignInButton(
                      Buttons.Facebook,

                      onPressed: () {

                      signIn();
                      }
                    ),
SizedBox(height: 30,),
                    ElevatedButton(onPressed: () async{
                     try{
print(emailIdController.text);
print(passController.text);
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email:emailIdController.text, password: passController.text);

                    Navigator.pushReplacement(context, MaterialPageRoute (builder : (context)=>Home(emailID: emailIdController.text)));

                     }catch(e){
                       print(emailIdController.text);
                       print(passController.text);
                       print(e);
                     }

                    }, child:Container(

                      width: MediaQuery.of(context).size.width-90,
                      padding: EdgeInsets.symmetric(horizontal: 50 ,vertical: 10),
                        child: Text("Login" ,style: TextStyle(fontSize: 20), textAlign: TextAlign.center,))),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                    }, child: Text("Don't Have An Account?"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> signIn()async {

    Map<String, dynamic> UserData;
      final LoginResult loginResult =  await  FacebookAuth.instance.login();

      if(loginResult.status == LoginStatus.success){
        accessToken = loginResult.accessToken;

      UserData  =   await FacebookAuth.instance.getUserData() as Map<String, dynamic>;

        await FirebaseFirestore.instance.collection("profile-info").where("email" , isEqualTo :  UserData["email"]).get().then((value){
          if(value.docs.length != 0){
            Fluttertoast.showToast(
                msg: "Logged in Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushReplacement(context, MaterialPageRoute (builder : (context)=>Home(emailID: UserData["email"])));
            });


          }else{

            Fluttertoast.showToast(
                msg: "Not a user!, Register First",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black45,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushReplacement(context, MaterialPageRoute (builder : (context)=>Register()));
            });


          }

        });

      }

  }
}
