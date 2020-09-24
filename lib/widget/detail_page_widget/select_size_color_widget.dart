import 'package:flutter/material.dart';
import 'package:helloecommerce/widget/detail_page_widget/select_size_color.dart';

//////////////////Color..Data..Widget//////////////
class SelectColorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SelectColor(
            color: Colors.red,
          ),
          SelectColor(
            color: Color(0xffC0C0C0),
          ),
          SelectColor(
            color: Color(0xffFFD700),
          ),
          SelectColor(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
