import 'dart:math';

import "dart:math";
import 'package:book_recommendation_app/Views/Home.dart';
import 'package:book_recommendation_app/services/firedb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class AddBook extends StatefulWidget {
  String UserEmail;
   AddBook({
    required this.UserEmail
});

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  late String BookID;
  var uuid = Uuid();



  static var  list = ["https://images.unsplash.com/photo-1633477189729-9290b3261d0a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=722&q=80",
  "https://images.unsplash.com/photo-1641154748135-8032a61a3f80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=415&q=80",
  "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1212&q=80",
  "https://images.unsplash.com/photo-1589829085413-56de8ae18c73?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1212&q=80"];

// generates a new Random object
  static final _random = new Random();

// generate a random index based on the list length
// and use it to retrieve the element
  static var element = list[_random.nextInt(list.length)];


  generateBookID() async{
    setState(() {
      BookID = uuid.v1().toString();
    });
  }

  final FirebaseAuth _auth  = FirebaseAuth.instance;

  TextEditingController book_name = new TextEditingController();
  TextEditingController book_subtitle = new TextEditingController();
  TextEditingController author_name = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController publisher = new TextEditingController();
  TextEditingController description = new TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateBookID();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Book"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
                width : MediaQuery.of(context).size.width,
                  child: Text("Enter Details Of Book" , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold), textAlign: TextAlign.start,)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextField(decoration: InputDecoration(
                    prefixIcon: Icon(Icons.book),

                    border: InputBorder.none,
                    hintText: 'Name Of The Book',
                  ),
                    controller: book_name,

                  )),
              SizedBox(height: 10,),

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextField(decoration: InputDecoration(
                    prefixIcon: Icon(Icons.book),

                    border: InputBorder.none,
                    hintText: 'Subtitle Of Book',
                  ),
                    controller: book_subtitle,

                  )),
              SizedBox(height: 10,),

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextField(decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    hintText: 'Author Name',
                  ),
                    controller: author_name,
                  )),
              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextField(decoration: InputDecoration(
                    prefixIcon: Icon(Icons.category),
                    border: InputBorder.none,
                    hintText: 'Type',
                  ), controller: type, )),
              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextField(decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    border: InputBorder.none,
                    hintText: 'Year',
                  ),)),
              SizedBox(height: 10,),

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextField(decoration: InputDecoration(
                    prefixIcon: Icon(Icons.apartment),
                    border: InputBorder.none,
                    hintText: 'Publisher',
                  ),
                      controller: publisher
                  )),

SizedBox(height: 10,),




              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey , width: 2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: TextField(decoration: InputDecoration(
                    prefixIcon: Icon(Icons.dehaze),
                    border: InputBorder.none,
                    hintText: 'Description',
                  ),
                      controller: description
                  )),


              SizedBox(height: 20,),
              ElevatedButton(style: ButtonStyle(

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),

                      )
                  )
              ),onPressed: () async{
                
                await FirebaseFirestore.instance.collection("books-list").doc(BookID).set({

                  "bookAddedBy" : "AAADADCADC@AFCA.cacas",
                  "bookAuthor" : author_name.text.toString(),
                  "bookCategory" : type.text.toString(),
                  "bookCoverDetails" : description.text.toString(),
                  "bookId" : BookID,
                  "bookThumbUrl" : element,
                  "bookImageId" : 0 + new Random().nextInt(9 - 0),
                  "bookOverallRating" : 0,
                  "bookPublishedBy" : publisher.text.toString(),
                  "bookSubTitle" : book_subtitle.text.toString(),
                  "bookTitle" : book_name.text.toString().toLowerCase(),
                  "isBlocked" : false,
                  "bookRatingsAndReviews" : [],
                  "added_usr_email" : widget.UserEmail
                });
                Fluttertoast.showToast(
                    msg: "Book Added Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black45,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(emailID: widget.UserEmail,)));
                });

              }, child:Container(

                padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 70),
                  child: Text("Add A Book" ,style: TextStyle(fontSize: 18),)))

            ],
          ),
        ),
      ),
    );
  }
}
