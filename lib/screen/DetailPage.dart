import 'package:flutter/material.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/checkout_page.dart';
import 'package:helloecommerce/widget/detail_page_widget/Product_price.dart';
import 'package:helloecommerce/widget/detail_page_widget/description_text.dart';
import 'package:helloecommerce/widget/detail_page_widget/detail_app_bar.dart';
import 'package:helloecommerce/widget/detail_page_widget/image_container.dart';
import 'package:helloecommerce/widget/detail_page_widget/old_price.dart';
import 'package:helloecommerce/widget/detail_page_widget/product_name.dart';
import 'package:helloecommerce/widget/detail_page_widget/reviews_widget.dart';
import 'package:helloecommerce/widget/detail_page_widget/select_size_color_calling.dart';
import 'package:helloecommerce/widget/detail_page_widget/select_size_color_calling.dart';
import 'package:helloecommerce/widget/detail_page_widget/select_size_color_widget.dart';
import 'package:helloecommerce/widget/detail_page_widget/select_size_text.dart';
import 'package:helloecommerce/widget/detail_page_widget/select_text_Widget.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final double price;
  final String name;
  final String description;
  DetailPage({this.description, this.image, this.price, this.name});
  @override
  _DetailPageState createState() => _DetailPageState();
}

int count = 1;

class _DetailPageState extends State<DetailPage> {
  MyProvider myProvider;

  Widget _buyButton() {
    return Container(
      height: 46,
      width: 150,
      child: RaisedButton(
        child: Text(
          "Add to Cart",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        color: Theme.of(context).accentColor,
        onPressed: () {
          myProvider.addCartProduct(
            productImage: widget.image,
            productName: widget.name,
            productPrice: widget.price,
            productQuantity: count,
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => Checkout(),
            ),
          );
        },
      ),
    );
  }

  Widget _addOrRemove() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.add_circle,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            setState(() {
              if (count < 10) {
                count++;
              }
            });
          },
        ),
        Text(
          '$count',
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            setState(() {
              if (count > 1) {
                count--;
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context),
      body: RefreshIndicator(
        color: Theme.of(context).accentColor,
        backgroundColor: Colors.white,
        onRefresh: () async {
          return await Future.delayed(
            Duration(seconds: 3),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Container(
                height: 790,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ImageContainer(
                              image: widget.image,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ProductPrice(
                                        price: widget.price * count,
                                      ),
                                      OldPrice(),
                                      Column(
                                        children: [
                                          _buyButton(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReviewsWidget(),
                                      _addOrRemove(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ProductName(
                      name: widget.name,
                    ),
                    DescripationText(
                      description: widget.description,
                    ),
                    SelectTextWidget(),
                    SelectColorWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
