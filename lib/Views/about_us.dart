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
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."  , textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
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
