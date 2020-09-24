import 'package:flutter/material.dart';

class ProductName extends StatelessWidget {
final String name;
ProductName({@required this.name});

  @override
  Widget build(BuildContext context) {
    return               Text(
                name,
                style: TextStyle(
                  fontSize: 23,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              );
  }
}