import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helloecommerce/model/Cart_Product.dart';
import 'package:helloecommerce/model/product.dart';
import 'package:helloecommerce/model/product_order.dart';
import 'package:helloecommerce/model/userModel.dart';

class MyProvider with ChangeNotifier {
  ////////////////////Featured///////////////////
  List<MyProduct> _getProduct = [];
  MyProduct _myProduct;
  Future<void> saveData() async {
    List<MyProduct> newList = [];
    QuerySnapshot allProduct = await FirebaseFirestore.instance
        .collection("allProduct")
        .doc('B7UxZbhRzMKOcE7LnpxZ')
        .collection("mantshirt")
        .get();
    allProduct.docs.forEach(
      (element) {
        _myProduct = MyProduct(
          productDescription: element.data()['description'],
          productImages: element.data()['image'],
          productName: element.data()['name'],
          productPrice: element.data()['price'],
        );
        newList.add(_myProduct);
      },
    );
    _getProduct = newList;
  }

  get getAllProduct {
    return _getProduct;
  }

////////////////////BestSelling///////////////////
  List<MyProduct> bestSellingList = [];
  MyProduct myProduct;
  Future<void> bestSellingData() async {
    List<MyProduct> bestSellingNewList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('allProduct')
        .doc('B7UxZbhRzMKOcE7LnpxZ')
        .collection('bestSelling')
        .get();
    querySnapshot.docs.forEach((element) {
      String image = element.data()['image'];
      String name = element.data()['name'];
      double price = element.data()['price'];
      String description = element.data()['description'];
      myProduct = MyProduct(
        productDescription: description,
        productImages: image,
        productName: name,
        productPrice: price,
      );
      bestSellingNewList.add(myProduct);
    });
    bestSellingList = bestSellingNewList;
  }

  get getBestSellingList {
    return bestSellingList;
  }

  ////////////////////WomanDetailCagtegories///////////////////
  List<MyProduct> _getWomanDetailCategories = [];
  MyProduct _myWomanDetailCategories;
  Future<void> saveWomanDetailCategoriesData() async {
    List<MyProduct> newWomanDetailCategoriesList = [];
    QuerySnapshot allProduct = await FirebaseFirestore.instance
        .collection("CategoryDetail")
        .doc('fgrNdVnXDhW6sBvLBkQ9')
        .collection("WomanCategories")
        .get();
    allProduct.docs.forEach((element) {
      _myWomanDetailCategories = MyProduct(
        productDescription: element.data()['description'],
        productImages: element.data()['image'],
        productName: element.data()['name'],
        productPrice: element.data()['price'],
      );
      newWomanDetailCategoriesList.add(_myWomanDetailCategories);
    });

    _getWomanDetailCategories = newWomanDetailCategoriesList;
  }

  get getAllWomanDetailCategories {
    return _getWomanDetailCategories;
  }

  ////////////////////manDetailCategories///////////////////
  List<MyProduct> _getManDetailCategories = [];
  MyProduct _myManDetailCategories;
  Future<void> saveManDetailCategoriesData() async {
    List<MyProduct> newManDetailCategoriesList = [];
    QuerySnapshot allProduct = await FirebaseFirestore.instance
        .collection("CategoryDetail")
        .doc('fgrNdVnXDhW6sBvLBkQ9')
        .collection("ManCategories")
        .get();
    allProduct.docs.forEach((element) {
      _myManDetailCategories = MyProduct(
        productDescription: element.data()['description'],
        productImages: element.data()['image'],
        productName: element.data()['name'],
        productPrice: element.data()['price'],
      );
      newManDetailCategoriesList.add(_myManDetailCategories);
    });

    _getManDetailCategories = newManDetailCategoriesList;
  }

  get getAllManDetailCategories {
    return _getManDetailCategories;
  }

////////////////////KidsDeatilCategoires///////////////////
  List<MyProduct> _getKidsDetailCategories = [];
  MyProduct _myKidsDetailCategories;
  Future<void> saveKidsDetailCategoriesData() async {
    List<MyProduct> newKidsDetailCategoriesList = [];
    QuerySnapshot allProduct = await FirebaseFirestore.instance
        .collection("CategoryDetail")
        .doc('fgrNdVnXDhW6sBvLBkQ9')
        .collection("KidsCategories")
        .get();
    allProduct.docs.forEach((element) {
      _myKidsDetailCategories = MyProduct(
        productDescription: element.data()['description'],
        productImages: element.data()['image'],
        productName: element.data()['name'],
        productPrice: element.data()['price'],
      );

      newKidsDetailCategoriesList.add(_myKidsDetailCategories);
    });

    _getKidsDetailCategories = newKidsDetailCategoriesList;
  }

  get getAllKidsDetailCategories {
    return _getKidsDetailCategories;
  }

//////////////////// CartProduct  //////////////////////

  List<CartProduct> _cartProductList = [];
  CartProduct cartProduct;
  List<MyProduct> productList = [];
  void addCartProduct(
      {String productName,
      String productImage,
      double productPrice,
      int productQuantity}) {
    cartProduct = CartProduct(
      cartProductImage: productImage,
      cartProductName: productName,
      cartProductPrice: productPrice,
      cartProductQuantity: productQuantity,
    );
    _cartProductList.add(cartProduct);
    notifyListeners();
  }

  List<CartProduct> get allProductList {
    return List.from(_cartProductList);
  }

  int get cartProductlength {
    return _cartProductList.length;
  }

  double get getTottalAmount {
    double total = 0.0;
    _cartProductList.forEach(
      (element) {
        total += element.cartProductQuantity * element.cartProductPrice;
      },
    );
    return total;
  }

  int totalindex;
  void getRemoveIndex(int index) {
    totalindex = index;
  }

  void removeProduct() {
    _cartProductList.removeAt(totalindex);
    notifyListeners();
  }

  void clean() {
    _cartProductList.clear();
  }

  List<MyProduct> get getProductList {
    return productList;
  }

  UserModel _userModel;
  User currentUser = FirebaseAuth.instance.currentUser;
  fetchUserData() async {
    QuerySnapshot quenrySnapshot =
        await FirebaseFirestore.instance.collection('user').get();
    quenrySnapshot.docs.forEach((element) {
      if (currentUser.uid == element.data()['UserId']) {
        _userModel = UserModel(
          name: element.data()['UserName'],
          email: element.data()['UserEmail'],
          phoneNumber: element.data()['UserPhoneNumber'],
          passWord: element.data()['UserPassword'],
          image: element.data()['UserImageUrl'],
        );
      }
    });
  }

  get currentUsers {
    return _userModel ??
        UserModel(
          name: '',
          email: '',
          phoneNumber: '',
          passWord: '',
          image: 'https://www.abc.net.au/news/image/8314104-1x1-940x940.jpg',
        );
  }

  ////////////////////   Search   //////////
  List<MyProduct> search(String query) {
    List<MyProduct> searchList = _getProduct.where((element) {
      return element.productName.toUpperCase().contains(query) ||
          element.productName.toLowerCase().contains(query) ||
          element.productName.toUpperCase().contains(query) &&
              element.productName.toLowerCase().contains(query);
    }).toList();
    return searchList;
  }
  //////////////////end Search //////////

  ////////////////////   Search   //////////
  List<MyProduct> searchlist;
  void getSearchList({List<MyProduct> list}) {
    searchlist = list;
  }

  List<MyProduct> categoriesSearch(String query) {
    List<MyProduct> searchList = searchlist.where((element) {
      return element.productName.toUpperCase().contains(query) ||
          element.productName.toLowerCase().contains(query) ||
          element.productName.toUpperCase().contains(query) &&
              element.productName.toLowerCase().contains(query);
    }).toList();
    return searchList;
  }

  //////////////////end Search //////////
  List<ProductOrder> _productOrder = [];
  List<ProductOrder> get productOrder {
    return [..._productOrder];
  }

  Future<void> addOrder(List<CartProduct> cartProducts, double total) async {
    final timeSteam = DateTime.now();
    try {
      FirebaseFirestore.instance.collection('Order').doc().set({
        'UserName': _userModel.name,
        'UserImageUrl': _userModel.image,
        'UserEmail': _userModel.email,
        'UserPhoneNumber': _userModel.phoneNumber,
        'OrderId': DateTime.now().toString(),
        'OrderAmount': total,
        'OrderTimeDate': timeSteam.toIso8601String(),
        'OrderProduct': cartProducts
            .map((e) => {
                  'OrderImage': e.cartProductImage,
                  'OrderName': e.cartProductName,
                  'OrderPrice': e.cartProductPrice,
                  'OrderQuantity': e.cartProductQuantity,
                })
            .toList()
      });
      _productOrder.insert(
        0,
        ProductOrder(
          price: total,
          dateTime: timeSteam,
          id: DateTime.now().toString(),
        ),
      );
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
