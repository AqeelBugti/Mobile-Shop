import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
final  double price;
  ProductPrice({this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: TextStyle(
        fontSize: 19,
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
