import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helloecommerce/model/CategoryModel.dart';

class ManCategoryProvider with ChangeNotifier {
  List<CategoryModel> _manCategory = [];
  CategoryModel _modelCategory;
  Future<void> fetchmanCategory() async {
    List<CategoryModel> newManList = [];
    QuerySnapshot allManCategory = await FirebaseFirestore.instance
        .collection("Category")
        .doc('ia9YS5KQYGOpmg9cFmAr')
        .collection("Man")
        .get();
    allManCategory.docs.forEach((element) {
      print(element);
      _modelCategory = CategoryModel(
        categoryImage: element.data()['image'],
        categoryName: element.data()['name'],
      );
      newManList.add(_modelCategory);
    });
    _manCategory = newManList;
  }

  get getManCategory {
    return _manCategory;
  }

  List<CategoryModel> _womanCategory = [];
  CategoryModel _womanCategoryModel;
  Future<void> fetchWomanCategory() async {
    List<CategoryModel> newWomanList = [];
    QuerySnapshot allWomanCategory = await FirebaseFirestore.instance
        .collection("Category")
        .doc('ia9YS5KQYGOpmg9cFmAr')
        .collection("Woman")
        .get();
    allWomanCategory.docs.forEach((element) {
      _womanCategoryModel = CategoryModel(
        categoryImage: element.data()['image'],
        categoryName: element.data()['name'],
      );
      newWomanList.add(_womanCategoryModel);
    });
    _womanCategory = newWomanList;
  }

  get getWomanCategory {
    return _womanCategory;
  }
//////////////kid category/////////////

  List<CategoryModel> _kidsCategory = [];
  CategoryModel _kidsCategoryModel;
  Future<void> fetchKidsCategory() async {
    List<CategoryModel> newKidsList = [];
    QuerySnapshot allKidsCategory = await FirebaseFirestore.instance
        .collection("Category")
        .doc('ia9YS5KQYGOpmg9cFmAr')
        .collection("kids")
        .get();
    allKidsCategory.docs.forEach((element) {
      _kidsCategoryModel = CategoryModel(
        categoryImage: element.data()['image'],
        categoryName: element.data()['name'],
      );
      newKidsList.add(_kidsCategoryModel);
    });
    _kidsCategory = newKidsList;
  }

  get getKidsCategory {
    return _kidsCategory;
  }
}
