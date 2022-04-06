import 'package:book_recommendation_app/Views/AdminPanel.dart';
import 'package:book_recommendation_app/Views/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class BookDes extends StatefulWidget {
   final Map<String, dynamic> BookData;
   String UserEmail;
   BookDes(
  {
    required this.BookData,
    required this.UserEmail
}
      );

  @override
  _BookDesState createState() => _BookDesState();
}



class _BookDesState extends State<BookDes> {
  Future<void> share(String text, String subtext ) async {
    await FlutterShare.share(
        title: text,
        text: subtext,

        chooserTitle: "BLURB"
    );
  }

static int rating = 0;
static String comment = "";

   static late Map<String, dynamic> BookDataInfo;
 static String UserEmailID = "";
  static final  FirebaseAuth _auth  = FirebaseAuth.instance;
  static List<dynamic>? ReviewList;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      BookDataInfo = widget.BookData;
      UserEmailID = widget.UserEmail;
      ReviewList = BookDataInfo["bookRatingsAndReviews"];
    });


  }


  final _dialog = RatingDialog(
    initialRating: 1.0,
    // your app's name?
    title: Text(
      'Rate Blurb',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    // encourage your user to leave a high rating?
    message: Text(
      'Tap a star to set your rating. Add more description here if you want.',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    ),

    image: Image.asset("Assets/images/blurb_logo.png" , width: 50,),
    submitButtonText: 'Submit',
    commentHint: 'Write Your Review',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response)  {

      rating = response.rating.toInt();
      comment = response.comment;

      print(UserEmailID);
      print(rating);
      print(comment);

ReviewList!.add({
  "bookRating" : response.rating,
  "bookReview" : response.comment,
  "reviewerId" : Uuid().v1(),
  "reviewerName" :UserEmailID
});


      FirebaseFirestore.instance.collection("books-list").doc(BookDataInfo["bookId"].toString()).update({
        "bookRatingsAndReviews" : ReviewList
      }).then((value) {
        print("LINK IS HERE HEHREHHRHEHHR");
print("https://blurb-book-app-api.herokuapp.com/sendEmail/${UserEmailID}/${rating}/${comment}");
        final url = Uri.parse('https://blurb-book-app-api.herokuapp.com/sendEmail/${UserEmailID}/${rating}/${comment}');
         http.post(url);
      });



       FirebaseFirestore.instance.collection("books-list").doc(BookDataInfo["bookId"].toString()).update({"bookOverallRating" : averageRating(ReviewList) });


    },


  );

  // show the dialog



  @override
  Widget build(BuildContext context) {
    print(widget.BookData["bookOverallRating"]/1.0);
    return Scaffold(
      floatingActionButton: ElevatedButton(child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 10),
          child: Text("Share")), onPressed: (){
        share(widget.BookData["bookTitle"] , " ${widget.BookData["bookTitle"]} - ${widget.BookData["bookAuthor"]}");
      },    style: ButtonStyle(

          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),

              )
          )
      )
      ),
      appBar: AppBar(
        title: Text("Blurb"),
      ),

      body: RefreshIndicator(
        onRefresh: () async{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(emailID: widget.UserEmail)));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
CustomBookTileAD(widget.BookData["bookTitle"], widget.BookData["bookAuthor"], averageRating(widget.BookData["bookRatingsAndReviews"]), widget.BookData["bookImageId"]),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  Row(
                    children: [
                      Icon(Icons.menu , size: 28,),
                      SizedBox(width: 5,),
                      Text("Description" , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold), textAlign: TextAlign.start,),


                    ],

                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                      child: Text(widget.BookData["bookCoverDetails"], style: TextStyle(fontSize: 18),textAlign: TextAlign.start))

                ],),
              ),





              Card(
                elevation: 1.0,

                child: Container(
                  width: MediaQuery.of(context).size.width-40,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [

                      SizedBox(height: 10,),
                      // Text(_auth.currentUser!.displayName.toString() ,
                      Text(widget.UserEmail ,
                        style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
                      TextButton( child: Text("Write Your Review" , style: TextStyle(fontSize: 20),) , onPressed: (){

                         showDialog(
                          context: context,
                          barrierDismissible: true, // set to false if you want to force a rating
                          builder: (context) => _dialog,
                        );
                      },),

                    ],
                  ),
                ),
              ),


              SizedBox(
height: 300,
                child: ListView.builder(

                    itemCount: ReviewList?.length,itemBuilder: (context , index){return ListTile(title: Text(ReviewList![index]["bookReview"]), subtitle:Text(ReviewList![index]["reviewerName"] ,style: TextStyle(fontSize: 12),) , trailing: Text("${ReviewList![index]['bookRating']}/5") );}),
              )


          ],
    ),
        ),
      ),
    );
  }
}

Widget ReviewTile(String Reviwer_Name , String comment){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 30),
    width: 800,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Reviwer_Name , style: TextStyle(fontSize: 14 , color: Colors.blueAccent), textAlign: TextAlign.start,),
        Container(
          width: 600,
          padding: EdgeInsets.symmetric(horizontal: 10  ,vertical: 10),
          color: Colors.white70,
            child: Text(comment , style: TextStyle(fontSize: 20 , color: Colors.black45),textAlign: TextAlign.start,))

      ],
    ),
  );
}

 averageRating(ratings)
{
  double sum = 0,avg=0;
  if(ratings.length>0) {
    for (int i = 0; i < ratings.length; i++) {
      sum = sum + (ratings[i]["bookRating"]);
    }
    avg = sum / ratings.length;
  }
return avg;
}