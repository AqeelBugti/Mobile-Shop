import 'package:flutter/material.dart';
import 'package:helloecommerce/animation/fade_animation.dart';
import 'package:helloecommerce/model/product.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/DetailPage.dart';
import 'package:helloecommerce/screen/badge.dart.dart';
import 'package:helloecommerce/screen/checkout_page.dart';
import 'package:helloecommerce/screen/homePage.dart';
import 'package:helloecommerce/widget/categories.dart';
import 'package:provider/provider.dart';
import '../screen/categorriessearch.dart';

class DetailCategories extends StatelessWidget {
  final List<MyProduct> list;
  final String name;
  DetailCategories({@required this.list, @required this.name});
  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => MyHomePage(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              myProvider.getSearchList(
                list: list,

              );
              showSearch(context: context, delegate: Search());
            },
          ),
          Consumer<MyProvider>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.cartProductlength.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.black54,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Checkout(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Theme.of(context).accentColor,
        onRefresh: () async {
          return await Future.delayed(
            Duration(seconds: 3),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: FadeAnimtion(
                  delay: 2,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 21,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: GridView.count(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                      childAspectRatio: 0.7,
                      children: list
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                       description: e.productDescription,
                                      image: e.productImages,
                                      name: e.productName,
                                      price: e.productPrice,
                                    ),
                                  ),
                                );
                              },
                              child: Categories(
                                
                                description: e.productDescription,
                                image: e.productImages,
                                name: e.productName,
                                price: e.productPrice,
                              ),
                            ),
                          )
                          .toList()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
