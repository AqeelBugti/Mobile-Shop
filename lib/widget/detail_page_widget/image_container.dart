import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String image;
  ImageContainer({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        image: DecorationImage(     
          image: NetworkImage(image),
        ),
      ),
      child: ListTile(
        trailing: IconButton(
          icon: Icon(
            Icons.favorite_border,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
