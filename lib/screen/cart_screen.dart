import 'package:flutter/material.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/checkout_page.dart';
import 'package:helloecommerce/screen/homePage.dart';
import 'package:helloecommerce/widget/cartScreenWidget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget _totalPrice(context) {
    MyProvider totalPrice = Provider.of<MyProvider>(context);
    double total;
    setState(() {
      total = totalPrice.getTottalAmount;
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Total",
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "\$ ${total.toStringAsFixed(2)}",
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Widget _shoppingCartBadge() {
  //   return Badge(
  //     position: BadgePosition.topRight(top: 0, right: 3),
  //     animationDuration: Duration(milliseconds: 300),
  //     animationType: BadgeAnimationType.slide,
  //     badgeContent: Text(
  //       _counter.toString(),
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     child: IconButton(
  //       icon: Icon(
  //         Icons.shopping_cart,
  //         color: Colors.black54,
  //       ),
  //       onPressed: () {},
  //     ),
  //   );
  // }

  Widget _proceedButton() {
    return Container(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Theme.of(context).accentColor,
        child: Text(
          "Checkout",
          style: TextStyle(fontSize: 22, color: Colors.white, letterSpacing: 4),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => Checkout(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => MyHomePage(),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              }),
          title: Text(
            "Cart",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          actions: <Widget>[
            // _shoppingCartBadge(),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: ListView.builder(
                    itemCount: myProvider.cartProductlength,
                    itemBuilder: (ctx, index) => CartScreenWidget(
                      image: myProvider.allProductList[index].cartProductImage,
                      name: myProvider.allProductList[index].cartProductName,
                      price: myProvider.allProductList[index].cartProductPrice,
                      quantity:
                          myProvider.allProductList[index].cartProductQuantity,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(28),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 4,
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _totalPrice(context),
                      _proceedButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
