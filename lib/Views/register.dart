import 'package:book_recommendation_app/Views/Home.dart';
import 'package:book_recommendation_app/Views/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController FirstNameController = new TextEditingController();
  TextEditingController LastNameController = new TextEditingController();
  TextEditingController PhoneNoController = new TextEditingController();
  TextEditingController BioController = new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  TextEditingController ConfirmPassController = new TextEditingController();

  static var Registerkey  = Uuid().v1();


  late FToast fToast;



  // @override
  // void initState() {
  //   super.initState();
  //   fToast = FToast();
  //   fToast.init(context);
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
      fToast.init(context);
  }




  bool RegisterDisable = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset("Assets/images/blurb_logo.png" , width: 170,),
                Container(
                  child: Column(
                    children: [


                      SizedBox(height: 10,),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey , width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: TextField( controller: emailController,decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: InputBorder.none,
                            hintText: 'Email',

                          ),

                          )),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey , width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: TextField( controller: FirstNameController,decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText: 'First Name',
                          ),)),




                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey , width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: TextField( controller: LastNameController,decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none,

                            hintText: 'Last Name',
                          ),)),


                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey , width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: TextField( controller: PhoneNoController,decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText: 'Phone No.',
                          ),)),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey , width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: TextField( controller:BioController,decoration: InputDecoration(
                            prefixIcon: Icon(Icons.contact_mail),
                            border: InputBorder.none,
                            hintText: 'Bio',
                          ),)),

                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey , width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: TextField( keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,controller: passwordController,decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),)),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey , width: 2),
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: TextField( onChanged: (value){
                            if(value ==passwordController.text ){
                              setState(() {
                                RegisterDisable = false;
                              });
                            }else{
                              setState(() {
                                RegisterDisable = true;
                              });
                            }
                          },controller: ConfirmPassController,decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            border: InputBorder.none,

                            hintText: 'Confirm Password',
                          ),
keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,

                          )),
                      SizedBox(height: 10,),

                      SizedBox(height: 30,),






                      ElevatedButton( child:Container(
                          width: MediaQuery.of(context).size.width-90,
                          padding: EdgeInsets.symmetric(horizontal: 50 ,vertical: 10),
                          child: Text("Register" ,style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),





               onPressed: RegisterDisable ?  null : () async{




                          try{
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text);
                          await FirebaseFirestore.instance.collection("profile-info").doc().set(
                          {"bio" : BioController.text,
                          "email" : emailController.text,
                          "firstName" : FirstNameController.text,
                          "lastName" : LastNameController.text,
                          "mobile" : PhoneNoController.text,
                          "isAdmin" : false,
                          "uid" : Registerkey });
                          Fluttertoast.showToast(
                              msg: "Registered Succesfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black45,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(emailID: emailController.text.trim(),)));
                          });




                          }catch(e){
                setState(() {

                });








                      }

               }



                      ),
                      TextButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                      }, child: Text("Already Have An Account ? Login Here"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
