import 'package:book_recommendation_app/Views/splash.dart';
import 'package:book_recommendation_app/services/firedb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  String email;
   Profile({required this.email});

  @override
  _ProfileState createState() => _ProfileState();
}






class _ProfileState extends State<Profile> {
  
  Map User = {};

  FetchUserProfile() async{
    await FirebaseFirestore.instance.collection("profile-info").where("email" , isEqualTo: widget.email).get().then((value){

      setState(() {
      User = value.docs[0].data();
      emailController.text = widget.email;
      PhoneNoController.text = User["mobile"].toString();
      BioController.text = User["bio"].toString();
      });


    });
    
  }






  TextEditingController emailController = new TextEditingController();
  TextEditingController FirstNameController = new TextEditingController();
  TextEditingController LastNameController = new TextEditingController();
  TextEditingController PhoneNoController = new TextEditingController();
  TextEditingController BioController = new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  TextEditingController ConfirmPassController = new TextEditingController();






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchUserProfile();




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 15),
              child: Row(
                children: [
                  SizedBox(width: 40,),
                  Text("${User["firstName"]} ${User["lastName"]}", style: TextStyle(fontSize: 22 ,color: Colors.black, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Divider( thickness: 2,),


            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey , width: 2),
                    borderRadius: BorderRadius.circular(50)
                ),
                child: TextField(readOnly: true,controller: emailController,decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: InputBorder.none,
                  hintText: 'Email ID',
                ),)),



            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey , width: 2),
                    borderRadius: BorderRadius.circular(50)
                ),
                child: TextField(readOnly: true,controller: PhoneNoController,decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
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
                child: TextField(readOnly: true,controller : BioController,decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: 'Bio',
                ),)),






            SizedBox(height: 20,),











            Align(
              alignment: Alignment.center,
                child: ElevatedButton(onPressed: () async{
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email);
                }, child: Text("Update Password"))),
            Container ( width: MediaQuery.of(context).size.width,child: Text("An Email Will Be Sent To Your Email For Reseeting The Password" ,style: TextStyle(fontSize: 10), textAlign: TextAlign.center,)),







          ],
        ),
      ),
    );
  }
}
