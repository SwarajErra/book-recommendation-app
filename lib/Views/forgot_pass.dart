import 'package:flutter/material.dart';

class Forgot_pass extends StatefulWidget {
  const Forgot_pass({Key? key}) : super(key: key);

  @override
  _Forgot_passState createState() => _Forgot_passState();
}

class _Forgot_passState extends State<Forgot_pass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),


      ),

      body: Column(
        children: [
          SizedBox(height: 30,),
          Text("Forgot Your Password ?" ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 28),),
          SizedBox(height: 30,),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey , width: 2),
                  borderRadius: BorderRadius.circular(50)
              ),
              child: TextField(decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                border: InputBorder.none,
                hintText: 'Enter New Password',
              ),)),

          SizedBox(height: 20,),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey , width: 2),
                  borderRadius: BorderRadius.circular(50)
              ),
              child: TextField(decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                border: InputBorder.none,
                hintText: 'Confirm New Password',
              ),)),

          SizedBox(height: 20,),

          ElevatedButton(onPressed: (){}, child: Container(
            padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 70),
              child: Text("Update" ,style: TextStyle(fontSize: 24),))),
          SizedBox(height: 10,),
          TextButton(onPressed: (){}, child:Text("Back To Login"))
        ],
      ),
    );
  }
}
