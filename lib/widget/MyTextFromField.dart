import 'package:flutter/material.dart';

class MyTextFromField extends StatelessWidget {
  final TextEditingController myController;

  final String hintText;
  final TextInputType keybord;
  final bool myObscureText;
  MyTextFromField(
      {this.hintText, this.keybord, this.myObscureText, this.myController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      obscureText: myObscureText,
      keyboardType: keybord,
      decoration: InputDecoration(
        fillColor: Theme.of(context).primaryColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
