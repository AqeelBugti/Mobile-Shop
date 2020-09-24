import 'package:flutter/material.dart';

class PlaceWidget extends StatelessWidget {
  final String image;
  final String title;
  PlaceWidget({this.image, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(children: [
          Image.network(
            image,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.blue,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
