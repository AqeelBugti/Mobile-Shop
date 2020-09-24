import 'package:flutter/material.dart';

class SelectColor extends StatelessWidget {
  final Color color;
  SelectColor({@required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {},
      ),
    );
  }
}
