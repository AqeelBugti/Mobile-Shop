import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:helloecommerce/model/CategoryModel.dart';
import 'package:helloecommerce/provider/category_Provider.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/DetailPage.dart';
import 'package:helloecommerce/screen/badge.dart.dart';
import 'package:helloecommerce/screen/checkout_page.dart';
import 'package:helloecommerce/screen/search.dart';
import 'package:helloecommerce/widget/categories.dart';
import 'package:helloecommerce/widget/drawer_widget.dart';
import '../screen/Detail_categories.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../animation/fade_animation.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  MyProduct product;
Widget _categories({@required String image,@required String name,@required Function whenPres,}) {
    return GestureDetector(
      onTap: whenPres,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            FadeAnimtion(
              delay: 2,
              child: Container(
                width: 140,
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ),
            FadeAnimtion(
              delay: 2,
              child: Container(
                height: 100,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(image),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriesAndSeeAllText() {
    return Container(
      padding: EdgeInsets.only(right: 30),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FadeAnimtion(
            delay: 3,
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FadeAnimtion(
            delay: 3,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "See all",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kidscategoriesCallingData() {
    ManCategoryProvider provider = Provider.of<ManCategoryProvider>(context);
    MyProvider myProvider = Provider.of<MyProvider>(context);
    List<CategoryModel> setKidsCategory = provider.getKidsCategory;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: setKidsCategory.map(
            (e) {
              return _categories(
                whenPres: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => DetailCategories(
                        list: myProvider.getAllKidsDetailCategories,
                        name: 'Tablet',
                      ),
                    ),
                  );
                },
                image: e.categoryImage,
                name: e.categoryName,
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _womancategoriesCallingData() {
    ManCategoryProvider provider = Provider.of<ManCategoryProvider>(context);
    MyProvider myProvider = Provider.of<MyProvider>(context);
    List<CategoryModel> setWomanCategory = provider.getWomanCategory;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: setWomanCategory.map(
            (e) {
              return _categories(
                whenPres: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => DetailCategories(
                        name: 'Woman',
                        list: myProvider.getAllWomanDetailCategories,
                      ),
                    ),
                  );
                },
                image: e.categoryImage,
                name: e.categoryName,
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _categoriesCallingData() {
    ManCategoryProvider provider = Provider.of<ManCategoryProvider>(context);
    MyProvider myProvider = Provider.of<MyProvider>(context);
    List<CategoryModel> setManCategory = provider.getManCategory;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: setManCategory.map(
            (e) {
              return Row(
                children: <Widget>[
                  _categories(
                    whenPres: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailCategories(
                            name: 'Mobile',
                            list: myProvider.getAllManDetailCategories,
                          ),
                        ),
                      );
                    },
                    image: e.categoryImage,
                    name: e.categoryName,
                  ),
                  _womancategoriesCallingData(),
                  _kidscategoriesCallingData(),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _featuredAndSeeAllText() {
    return Container(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FadeAnimtion(
                  delay: 1,
                  child: Text(
                    "Featured",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FadeAnimtion(
                  delay: 1,
                  child: Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featuredData() {
    MyProvider provider = Provider.of<MyProvider>(context);
    List<MyProduct> setMyProduct = provider.getAllProduct;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          children: setMyProduct.map((e) {
            return GestureDetector(
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
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _bestSellingAndSeeAllText() {
    return Container(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FadeAnimtion(
                  delay: 1,
                  child: Text(
                    "Best Selling",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FadeAnimtion(
                  delay: 1,
                  child: Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bestSellingData() {
    MyProvider provider = Provider.of<MyProvider>(context);
    List<MyProduct> setMyProduct = provider.bestSellingList;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 309,
        child: Row(
            children: setMyProduct.map((e) {
          return GestureDetector(
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
          );
        }).toList()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    FirebaseFirestore.instance
        .collection("allProduct")
        .snapshots()
        .forEach((element) {
      element.docs.forEach((element) {
        product = MyProduct(
            productDescription: element.data()['description'],
            productImages: element.data()['image'],
            productName: element.data()['name'],
            productPrice: element.data()['price']);
        provider.getProductList.add(product);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    provider.saveData();
    provider.saveWomanDetailCategoriesData();
    provider.saveManDetailCategoriesData();
    provider.saveKidsDetailCategoriesData();
    provider.bestSellingData();
    ManCategoryProvider categoryprovider =
        Provider.of<ManCategoryProvider>(context);
    categoryprovider.fetchmanCategory();
    categoryprovider.fetchWomanCategory();
    categoryprovider.fetchKidsCategory();
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Search(),
                );
              }),
          Consumer<MyProvider>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.cartProductlength.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none,
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
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: Colors.black54,
        backgroundColor: Colors.white,
        onRefresh: () async {
          return await Future.delayed(
            Duration(
              seconds: 3,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 20),
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    _categoriesAndSeeAllText(),
                    _categoriesCallingData(),
                    _featuredAndSeeAllText(),
                    _featuredData(),
                    _bestSellingAndSeeAllText(),
                    _bestSellingData(),
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
