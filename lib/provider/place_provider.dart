import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:helloecommerce/model/place_model.dart';

class PlaceProvider with ChangeNotifier {
  List<PlaceModel> _placeList = [];
  PlaceModel placeModel;

  Future<void> fetchPlaceList() async {
    List<PlaceModel> _newPlaceModel = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("places").get();
    query.docs.forEach((element) {
      String getImage = element.data()["image"];
      String getTitle = element.data()["title"];
      placeModel = PlaceModel(image: getImage, title: getTitle);
      _newPlaceModel.add(placeModel);
    });
    _placeList = _newPlaceModel;
  }

  List<PlaceModel> get getPlaceList => List.from(_placeList);
  
}
