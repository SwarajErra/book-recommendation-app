import 'dart:core';
import 'dart:math';

import 'package:book_recommendation_app/Book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class searchBar extends StatefulWidget {
  // searchBar({
  //   required UniqueKey key,
  // }) : super(key: key);

  @override
  _searchBarState createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  FirebaseFirestore? _instance;
  List<Category> _categories = [];

  List<Category> getCategories() {
    return _categories;
  }

  Future<void> getCategoriesCollectionFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('books-list');
    //
    // DocumentSnapshot snapshot =
    //     await categories.doc('ncdhkTfmYsW6Q1ZZ9V6y').get();
    // var data = snapshot.data() as Map;
  }

   List<Book> list = [];

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          top: 0,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        dynamicJobCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // FloatSearchBar(),
      ],
    );
  }
}

class dynamicJobCard extends StatefulWidget {
  final TextEditingController searchTextFieldController =
      TextEditingController()..text = '';

  @override
  _dynamicJobCardState createState() => _dynamicJobCardState();
}

class _dynamicJobCardState extends State<dynamicJobCard> {
  Map<String, dynamic>? userMap;
  bool pressAttention = false;
  var list = [];
  var listBackup = [];
  double? _ratingValue;
  final dynamic ImageList = [
    'Assets/images/IMG1.jpg',
    'Assets/images/IMG2.jpg',
    'Assets/images/IMG3.jpg',
    'Assets/images/IMG4.jpg',
    'Assets/images/IMG5.jpg',
    'Assets/images/IMG6.jpg',
    'Assets/images/IMG7.jpg',
    'Assets/images/IMG8.jpg',
    'Assets/images/IMG9.jpg',
    'Assets/images/IMG10.jpg',
  ];

  updateList(text) {
    print(text);
    setState(() {
      if(text != ''){
        var tempList = [];
        tempList = listBackup
            .where((user) => user?["bookTitle"]
            ?.toLowerCase()
            .contains(text?.toLowerCase()))
            .toList();

        list = tempList;

      }else{
        list = listBackup;
      }

      print(list);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onSearch();
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('books-list').get().then((value) {
      if (mounted) {
        setState(() {
          for (var i = 0; i < value.docs.length; i++) {
            list.add(value.docs[i].data());
            listBackup.add(value.docs[i].data());
          }
        });
      }
      print(list);
    });
  }

  AssetImage getImage(bookId) {
    print(bookId);
    String imageName = ImageList[bookId].toString();
    return AssetImage(imageName);
  }

  dynamicCard(book) {

    print(book['bookId']);
    return Card(
      shadowColor: Colors.black,
      elevation: 20,
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        height: 220,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Column(
                    children: <Widget>[
                      Flexible(child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(left: 32.0),
                        height: 110,

                        child: Column(
                            //     children : [
                            // Flexible(
                            //       child : Text(' ${book!["bookTitle"]}',
                            //         textAlign: TextAlign.center,
                            //         style: GoogleFonts.openSans(
                            //           textStyle: TextStyle(
                            //               fontSize: 12, fontWeight: FontWeight.normal),))
                            // ),
                            //       Flexible(
                            //           child : Text(' ${book!["bookAuthor"]}',
                            //               textAlign: TextAlign.center,
                            //               style: GoogleFonts.openSans(
                            //                 textStyle: TextStyle(
                            //                     fontSize: 12, fontWeight: FontWeight.normal),))
                            //       ),
                            //     ]
                            ),

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: getImage(book!['bookImageId']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 110,
                        width: 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(children: <Widget>[
                                Text(' ${book!["bookTitle"]}',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ))
                              ]),
                              Column(children: <Widget>[
                                Text(' By : ${book!["bookAuthor"]}',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal)))
                              ]),
                              Column(children: <Widget>[
                                Text('Rating :',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal))),
                                RatingBar(
                                    initialRating: book!['bookOverallRating'],
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,

                                    ratingWidget: RatingWidget(

                                        full: const Icon(Icons.star,
                                            color: Colors.orange),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: Colors.orange,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: Colors.orange,
                                        )),
                                    onRatingUpdate: (value) {
                                      // setState(() {
                                      //   _ratingValue = value;
                                      // });
                                    }),
                              ]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    label: Text('Edit',
                        style: GoogleFonts.pacifico(
                            textStyle: TextStyle(
                          fontSize: 20,
                        ))),
                    icon: Icon(Icons.edit),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    // child: Report(),
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  ),
                  ElevatedButton.icon(
                    label: Text('Block',
                        style: GoogleFonts.pacifico(
                            textStyle: TextStyle(
                          fontSize: 20,
                        ))),
                    icon: Icon(Icons.block),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    // child: Report(),
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  ),
                  ElevatedButton.icon(
                    label: Text('Delete',
                        style: GoogleFonts.pacifico(
                            textStyle: TextStyle(
                          fontSize: 20,
                        ))),
                    icon: Icon(Icons.delete_forever),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    // child: Report(),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 2),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                if (widget.searchTextFieldController.text == '') {
                  updateList(widget.searchTextFieldController.text);
                }
              },
              controller: widget.searchTextFieldController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  hintText: " Search...",
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.grey,
                      onPressed: () {
                        if (widget.searchTextFieldController.text != '') {
                          updateList(widget.searchTextFieldController.text);
                        }
                      })),
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            for (var i in list) dynamicCard(i)
          ],
        ));
  }
}
