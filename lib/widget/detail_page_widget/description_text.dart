import 'package:flutter/material.dart';

class DescripationText extends StatelessWidget {
  final String description;
  DescripationText({@required this.description});
  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 15,
        color: Colors.blueGrey[400],
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
