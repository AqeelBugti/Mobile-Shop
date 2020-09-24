import 'package:flutter/material.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:provider/provider.dart';

class CartScreenWidget extends StatefulWidget {
  final String image;
  final double price;
  final String name;
  int quantity;
  CartScreenWidget({
    this.image,
    this.name,
    this.price,
    this.quantity,
  });
  @override
  _CartScreenWidgetState createState() => _CartScreenWidgetState();
}

class _CartScreenWidgetState extends State<CartScreenWidget> {
  @override
  Widget build(BuildContext context) {

double price =widget.price* widget.quantity;
    MyProvider myProvider = Provider.of<MyProvider>(context);
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Delete'),
              content: Text('Are you sure ?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(false);
                  },
                  child: Text('No'),
                ),
                FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pop(true);
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      key: UniqueKey(),
      onDismissed: (direction) {
        myProvider.removeProduct();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).accentColor,
            content: Text(
              'Product Deleted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
      background: Container(
        padding: const EdgeInsets.only(right: 20.0),
        alignment: Alignment.centerRight,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(20),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey[300].withOpacity(0.5),
                offset: Offset(0, 1),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          width: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 80,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "\$${price.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "x${widget.quantity}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   height: 80,
                              //   child: Column(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceEvenly,
                              //     children: <Widget>[
                              //       GestureDetector(
                              //         child: Icon(
                              //           Icons.add_circle,
                              //           color: Theme.of(context).accentColor,
                              //         ),
                              //         onTap: () {
                              //           setState(
                              //             () {
                              //               if (widget.quantity < 10) {
                              //                 widget.quantity++;
                              //                 myProvider.addCartProduct(
                              //                     productImage: widget.image,
                              //                     productName: widget.name,
                              //                     productPrice: widget.price,
                              //                     productQuantity:
                              //                         widget.quantity);
                              //               }
                              //               print(widget.quantity);
                              //             },
                              //           );
                              //         },
                              //       ),
                              //       Text(
                              //         widget.quantity.toString(),
                              //         style: TextStyle(
                              //             fontSize: 25,
                              //             color: Theme.of(context).accentColor),
                              //       ),
                              //       GestureDetector(
                              //         child: Icon(
                              //           Icons.remove_circle,
                              //           color: Theme.of(context).accentColor,
                              //         ),
                              //         onTap: () {
                              //           setState(
                              //             () {
                              //               if (widget.quantity > 1) {
                              //                 widget.quantity--;
                              //                 myProvider.addCartProduct(
                              //                     productImage: widget.image,
                              //                     productName: widget.name,
                              //                     productPrice: widget.price,
                              //                     productQuantity:
                              //                     widget.quantity);
                              //               }
                              //             },
                              //           );
                              //         },
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
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
    );
  }
}
