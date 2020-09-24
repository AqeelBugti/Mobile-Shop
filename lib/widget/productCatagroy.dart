import 'package:flutter/material.dart';

class ProductCatagory extends StatelessWidget {
  final String productName;
  final String productImage;
  final int productSize;
  final String productDescription;
  ProductCatagory(
      {@required this.productName,
      @required this.productImage,
      @required this.productSize,
      @required this.productDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: Colors.yellow,
                child: Image.network(productImage),
              ),
              Text(
                productName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                productSize.toString(),
              ),
              Text(
                productDescription,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
