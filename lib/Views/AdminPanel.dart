import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';


class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),

      ),

      body:Container()
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

Widget CustomBookTileAD(String Title , String subtitle , double Rating , int BookCoverUrl){
  return InkWell(

    child: Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          // Image.network(BookCoverUrl ,width: 100,),
          Image.asset(ImageList[BookCoverUrl].toString(),
              fit: BoxFit.contain,
              width: 100),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(Title , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.w500),),
                Text("By : " +subtitle , style: TextStyle(color: Colors.black54),),
                Row(
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
                        valueLabelPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: Colors.yellow,
                      ),
                    ),
                  ],
                ),
                

              ],
            ),
          )
        ],
      ),
    ),
  );
}
