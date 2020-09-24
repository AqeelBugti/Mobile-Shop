import 'package:flutter/material.dart';

class SelectSizeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Select Size",
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
