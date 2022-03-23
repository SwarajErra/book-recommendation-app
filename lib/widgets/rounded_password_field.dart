import 'package:flutter/material.dart';
import 'package:book_recommendation_app/constants.dart';
import 'package:book_recommendation_app/widgets/widgets.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        cursorColor: Colors.blueAccent,
         decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.blueAccent,
            ),
            hintText: "Password",
            hintStyle:  TextStyle(fontFamily: 'OpenSans'),
            suffixIcon: Icon(
              Icons.visibility,
              color: Colors.blueAccent,
            ),
            border: InputBorder.none),
      ),
    );
  }
}