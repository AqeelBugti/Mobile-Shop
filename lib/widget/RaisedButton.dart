import 'package:flutter/material.dart';

class MyRaisedutton extends StatelessWidget {
  final String buttonText;
  final Color myColor;
  final Color textColor;
  final Function whenPress;
  MyRaisedutton(
      {this.textColor, this.buttonText, this.myColor, this.whenPress});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        buttonText,
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
      ),
      color: myColor,
      onPressed: whenPress,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
