
import 'package:flutter/material.dart';
class CartProduct {
  final String cartProductImage;
  final String cartProductName;
  final double cartProductPrice;
  final int cartProductQuantity;
  CartProduct(
      {
      @required this.cartProductQuantity,
      @required this.cartProductImage,
      @required this.cartProductName,
      @required this.cartProductPrice,
});
}