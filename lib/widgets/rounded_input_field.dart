import 'package:flutter/material.dart';
import 'package:flutter_auth_ui/constants.dart';
import 'package:flutter_auth_ui/widgets/widgets.dart';

class RoundedInputField extends StatelessWidget {
  const RoundedInputField({Key? key, this.hintText, this.icon = Icons.person, MaterialAccentColor })
      : super(key: key);
  final String? hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: Colors.blueAccent,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.blueAccent,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(fontFamily: 'OpenSans'),
            border: InputBorder.none),
      ),
    );
  }
}
