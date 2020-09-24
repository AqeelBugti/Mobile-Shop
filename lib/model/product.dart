import 'package:flutter/material.dart';

class MyProduct {
  String productImages;
  String productName;
  double productPrice;
  String productDescription;
  MyProduct({
      @required this.productDescription,
      @required this.productImages,
      @required this.productName,
      @required this.productPrice,
});
}