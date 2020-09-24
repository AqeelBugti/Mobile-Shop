import 'package:flutter/material.dart';
import 'package:helloecommerce/animation/fade_animation.dart';

class Categories extends StatefulWidget {
  final String image;
  final double price;
  final String name;
  final String description;
  final Function ontap;
  Categories({
     this.ontap,
    @required this.description,
    @required this.image,
    @required this.name,
    @required this.price,
  });

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isFavorite = false;
  _trogleBuoo() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimtion(
                      delay: 1,
                      child: Container(
                        height: 190,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FadeAnimtion(
                                delay: 1,
                                child: Text(
                                  '\$ ${widget.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FadeAnimtion(
                                delay: 1,
                                child: IconButton(
                                  icon: isFavorite == false
                                      ? Icon(Icons.favorite_border)
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                  onPressed: () {
                                    _trogleBuoo();
                                  },
                                ),
                              ),
                            ],
                          ),
                          FadeAnimtion(
                            delay: 1,
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
