import 'package:flutter/material.dart';

class OldPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '\$23.00',
      style: TextStyle(
        fontSize: 19,
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.lineThrough,
      ),
    );
  }
}
