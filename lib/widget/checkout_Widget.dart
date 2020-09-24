import 'package:flutter/material.dart';

class CheckOutWidget extends StatefulWidget {
  String images;
  String name;
  double price;

  CheckOutWidget({this.images, this.name, this.price});

  @override
  _CheckOutWidgetState createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListTile(
            leading: Container(
              // height: 300,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.images,
                  ),
                ),
              ),
            ),
            subtitle: Container(
              height: 75,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 235,
                    height: 20,
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.price}",
                        style: TextStyle(fontSize: 39),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              color: Colors.blueGrey,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        count++;
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              color: Colors.white.withOpacity(0.87),
                              child: Center(
                                child: Text(
                                  count.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              color: Colors.blueGrey,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        if (count > 1) {
                                          count--;
                                        }
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 20,
          thickness: 2,
        ),
      ],
    );
  }
}
