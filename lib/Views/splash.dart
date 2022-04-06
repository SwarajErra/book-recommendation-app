import 'package:book_recommendation_app/Views/Home.dart';
import 'package:book_recommendation_app/Views/Profile.dart';
import 'package:book_recommendation_app/Views/login.dart';
import 'package:book_recommendation_app/Views/register.dart';
import 'package:book_recommendation_app/services/localdb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {



  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;


  @override
  void initState() {
    super.initState();



    animation = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);

    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        animation.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        animation.forward();
      }
    });
    animation.forward();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeInFadeOut,
                child: Container(
                  padding: EdgeInsets.all(100),
                  child: Image.asset("Assets/images/blurb_logo.png"),)
              ),

              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              }, child: Container( padding : EdgeInsets.symmetric(horizontal: 55 , vertical: 15),child: Text("Login" , style: TextStyle(fontSize: 20),))),

SizedBox(height: 30,),

              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()));
              }, child: Container( padding : EdgeInsets.symmetric(horizontal: 55 , vertical: 15),child: Text("Register" , style: TextStyle(fontSize: 20),))),


            ],
          ),
        ),
      ),
    );
  }
}
