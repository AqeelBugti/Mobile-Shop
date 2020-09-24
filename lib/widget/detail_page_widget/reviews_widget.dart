import 'package:flutter/material.dart';

class ReviewsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 46,
            width: 61,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              child: Text(
                "4.0",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {},
            ),
          ),
          RichText(
            text: TextSpan(
              text: '49',
              style:
                  TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
              children: <TextSpan>[
                TextSpan(text: 'Reviews'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
