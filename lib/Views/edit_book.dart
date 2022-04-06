import 'dart:math';

import 'package:book_recommendation_app/Views/Home.dart';
import 'package:book_recommendation_app/services/firedb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class EditBook extends StatefulWidget {
  Map<String, dynamic> BookData;
  String EmailId;
   EditBook({
    required this.BookData,
     required this.EmailId
});

  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {


  late String BookID;
  var uuid = Uuid();

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
    setState(() {


    book_name.text = widget.BookData["bookTitle"];
    book_subtitle.text = widget.BookData["bookSubTitle"];
    author_name.text = widget.BookData["bookAuthor"];
    type.text = widget.BookData["bookCategory"];
    publisher.text = widget.BookData["bookPublishedBy"];
    description.text = widget.BookData["bookCoverDetails"];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Your Book"),
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

                await FirebaseFirestore.instance.collection("books-list").doc(widget.BookData["bookId"]).update({

                  "bookAddedBy" : widget.BookData["bookAddedBy"],
                  "bookAuthor" : author_name.text.toString(),
                  "bookCategory" : type.text.toString(),
                  "bookCoverDetails" : description.text.toString(),
                  "bookId" : widget.BookData["bookId"],
                  "bookImageId" : widget.BookData["bookImageId"],
                  "bookOverallRating" : widget.BookData["bookOverallRating"],
                  "bookPublishedBy" : publisher.text.toString(),
                  "bookSubTitle" : book_subtitle.text.toString(),
                  "bookTitle" : book_name.text.toString().toLowerCase(),
                  "isBlocked" : widget.BookData["isBlocked"],
                  "bookRatingsAndReviews" : widget.BookData["bookRatingsAndReviews"]
                });

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(emailID: widget.EmailId,)));

              }, child:Container(

                  padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 70),
                  child: Text("Update Book" ,style: TextStyle(fontSize: 18),)))


            ],
          ),
        ),
      ),
    );
  }
}



