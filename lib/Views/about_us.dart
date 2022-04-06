import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  void _launchURL() async {
    if (!await launch("mailto:blurbservice@gmail.com"));
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("Assets/images/blurb_logo.png" ,width: 100,),
                SizedBox(height: 50,),
                Text("The Blurb is the largest platform which suggests the best books to users basd on the their intrests. Taking advantage of vast collection across the internet,we suggest the best and fine books with small cover details about the book.We also offer editor recommendations and customer reviews on hundreds of thousands of titles."  , textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                SizedBox(height: 40,),
                Text('Connect With Us' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    IconButton(onPressed:_launchURL, icon: FaIcon(FontAwesomeIcons.envelope)),

                  ],
                )



              ],
            ),
          ),
        ),
      );
  }
}
