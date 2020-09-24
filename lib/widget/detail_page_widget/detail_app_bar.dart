import 'package:flutter/material.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/badge.dart.dart';
import 'package:helloecommerce/screen/checkout_page.dart';
import 'package:helloecommerce/screen/homePage.dart';
import 'package:provider/provider.dart';

AppBar appBar({@required context}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MyHomePage(),
          ),
        );
      },
    ),
    title: Text(
      'DetailPage',
      style: TextStyle(
        color: Colors.black54,
      ),
    ),
    centerTitle: true,
    actions: <Widget>[
      Consumer<MyProvider>(
        builder: (_, cart, ch) => Badge(
          child: ch,
          value: cart.cartProductlength.toString(),
        ),
        child: IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Checkout(),
              ),
            );
          },
        ),
      ),
    ],
  );
}
