import 'package:book_recommendation_app/Views/Profile.dart';
import 'package:book_recommendation_app/Views/about_us.dart';
import 'package:book_recommendation_app/Views/addbook.dart';
import 'package:book_recommendation_app/Views/book_des.dart';
import 'package:book_recommendation_app/Views/edit_book.dart';
import 'package:book_recommendation_app/Views/login.dart';
import 'package:book_recommendation_app/Views/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  String emailID;
  Home({required this.emailID});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {





  late Map<String, dynamic> UserData;
bool isLoading = true;
  getUserInfo() async {
    print("I AM CALLING");
    await FirebaseFirestore.instance
        .collection("profile-info")
        .where("email", isEqualTo: widget.emailID)
        .get()
        .then((value) {
      setState(() {
        UserData = value.docs[0].data();
        isLoading = false;
      });
    });
  }

  List<Map<String, dynamic>> booksData = [];
  List<Map<String, dynamic>> listBackup = [];
  GetAllBooks() async {

print(" IAM GET ALL BOOKS");
    // UserData["isAdmin"]  ?
      await FirebaseFirestore.instance
          .collection("books-list")
          .orderBy("bookTitle")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          booksData.add(element.data());
          listBackup.add(element.data());
        });
      });

      setState(() {
        print("GETTED ALL BOOK");
      });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    GetAllBooks();


  }

  bool order = true;
  updateList(text) {
    print(text);
    setState(() {
      if(text != ''){
        List<Map<String, dynamic>> tempList = [];
        tempList = listBackup
            .where((user) => user["bookTitle"]
            ?.toLowerCase()
            .startsWith(text?.toLowerCase()))
            .toList();

        booksData = tempList;

      }else{
        booksData = listBackup;
      }

      print(booksData);
    });
  }

  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold(body: Center(child: CircularProgressIndicator(),),) : Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  order = !order;
                });
              },
              icon: Icon(Icons.sort_by_alpha))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=628&q=80"))),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home, size: 35, color: Colors.black),
              title: Text(
                "HOME",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              email: widget.emailID,
                            )));
              },
              leading: Icon(Icons.person, size: 35, color: Colors.black),
              title: Text(
                "PROFILE",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
              leading: Icon(
                Icons.info_rounded,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                "ABOUT US",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
            ),





      SizedBox(
        height: 30,
      ),
      ListTile(
        onTap: () {


          Fluttertoast.showToast(
              msg: "Logged Out Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Future.delayed(Duration(seconds: 3), () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splash()));
          });



        },
        leading: Icon(
          Icons.logout,
          size: 35,
          color: Colors.black,
        ),
        title: Text(
          "LOGOUT",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ),
      ),






















          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(emailID: widget.emailID)));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: TextField(
                  controller: searchController,
                  onChanged: (SearchQuery) async {
                    print("VALUE IS HERE");
                    print(SearchQuery);

                    if (SearchQuery == "") {
                      booksData.clear();
                      updateList(SearchQuery);
                    } else {
                      updateList(SearchQuery);
                      // await FirebaseFirestore.instance
                      //     .collection("books-list")
                      //     .where(
                      //       "bookTitle",
                      //       isEqualTo: SearchQuery.toString().toLowerCase(),
                      //     )
                      //     .get()
                      //     .then((value) {
                      //   value.docs.forEach((element) {
                      //     setState(() {
                      //       booksData.clear();
                      //       booksData.add(element.data());
                      //     });
                      //   });
                      // });
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search books",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddBook(UserEmail: widget.emailID)));
                      },
                      child: Container(
                          padding: EdgeInsets.all(10), child: Text("Add Book")),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )))),
                ),
              ),
              ListView.separated(

                reverse: order,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: booksData.length,
                itemBuilder: (context, index) {
                  final sortedItems = booksData.toList()
                    ..sort((item1, item2) =>
                        item2.toString().compareTo(item1.toString()));
                  final item = sortedItems[index];
                  return item["isBlocked"] == true ? UserData["isAdmin"] == true ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookDes(
                                      BookData: item,
                                      UserEmail: widget.emailID,
                                    )));
                      },
                      child: CustomBookTile(
                          item["bookTitle"].toString().toUpperCase(),
                          item["bookAuthor"],
                          item["bookOverallRating"] / 1.0,
                          item,
                          context,
                          UserData)): Container()  :  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookDes(
                                  BookData: item,
                                  UserEmail: widget.emailID,
                                )));
                      },
                      child: CustomBookTile(
                          item["bookTitle"].toString().toUpperCase(),
                          item["bookAuthor"],
                          averageRating(item['bookRatingsAndReviews']),
                          item,
                          context,
                          UserData));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
final dynamic ImageList = [
  'Assets/images/IMG1.jpg',
  'Assets/images/IMG2.png',
  'Assets/images/IMG3.jpg',
  'Assets/images/IMG4.jpg',
  'Assets/images/IMG5.jpg',
  'Assets/images/IMG6.jpg',
  'Assets/images/IMG7.jpg',
  'Assets/images/IMG8.jpg',
  'Assets/images/IMG9.jpg',
  'Assets/images/IMG10.jpg',
];

AssetImage getImage(bookId) {
  print(bookId);
  String imageName = ImageList[bookId].toString();
  return AssetImage(imageName);
}


Widget CustomBookTile(String Title, String subtitle, double Rating,
    Map<String, dynamic> booksData, context, Map<String, dynamic> UserData) {

  print(Title);
  print(subtitle);
  print(Rating.toString());
  print(UserData);

  Future<void> share(String text, String subtext) async {
    await FlutterShare.share(title: text, text: subtext, chooserTitle: "BLURB");
  }

  return InkWell(
    child: Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Image.asset(ImageList[booksData["bookImageId"]].toString(),
                    fit: BoxFit.cover,
                    width: 150),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Title,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "By : "+subtitle,
                        style: TextStyle(color: Colors.black54),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: RatingStars(
                              starBuilder: (index, color) => Icon(
                                Icons.star,
                                color: color,
                              ),
                              starCount: 5,
                              starSize: 30,
                              value: Rating,
                              maxValue: 5,
                              starSpacing: 2,
                              maxValueVisibility: true,
                              valueLabelVisibility: false,
                              animationDuration: Duration(milliseconds: 1000),
                              valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                      // UserData["email"] == booksData["bookPublishedBy"]
                      // UserData["email"] == booksData["added_usr_email"] ?


                    ],
                  ),
                ),
              ],
            )
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserData["isAdmin"]
                    ?
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                            padding: EdgeInsets.only(right: 5),
                        child  : ElevatedButton.icon(
                          label: Text('Delete',
                              style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                  ))),
                          icon: Icon(Icons.delete_forever),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),

                          ),

                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("books-list")
                                .doc(booksData["bookId"])
                                .delete()
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(
                                        emailID: UserData["email"],
                                      )));
                            });
                          },
                        )),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child  :  ElevatedButton.icon(
                          label: booksData["isBlocked"] ? Text('UnBlock',
                              style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                  ))) : Text('Block',
                              style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                  ))),
                          icon: Icon(Icons.block),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),

                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("books-list")
                                .doc(booksData["bookId"])
                                .update({
                              "isBlocked": !booksData["isBlocked"]
                            });

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                      emailID: UserData["email"],
                                    )));
                          },
                        )),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child  :
                          ElevatedButton.icon(
                          label: Text('Edit',
                              style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                  ))) ,
                          icon: Icon(Icons.edit),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditBook(
                                      BookData: booksData,
                                      EmailId: UserData["email"],
                                    )));
                          },
                        )),

                      ],
                    )

                    : UserData["email"] == booksData["added_usr_email"]
                    ?
                ElevatedButton.icon(
                  label: Text('Edit',
                      style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                            fontSize: 12,
                          ))) ,
                  icon: Icon(Icons.edit),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlue),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBook(
                              BookData: booksData,
                              EmailId: UserData["email"],
                            )));
                  },
                )
                    : Container(),
                ElevatedButton.icon(
                  label: Text('Share',
                      style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                            fontSize: 12
                          ))) ,
                  icon: Icon(Icons.share),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlue),
                  ),
                  onPressed: () {
                    share(Title, subtitle);
                  },
                ),
              ],
            ),
          ),


        ],
      ),

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