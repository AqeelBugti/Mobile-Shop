import 'package:flutter/material.dart';

class SelectTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Select Color",
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
