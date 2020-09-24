import 'package:flutter/material.dart';
import 'package:helloecommerce/model/place_model.dart';
import 'package:helloecommerce/place_widget.dart';
import 'package:helloecommerce/provider/place_provider.dart';
import 'package:provider/provider.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlaceProvider provider = Provider.of<PlaceProvider>(context);

    ////list will full/////
    provider.fetchPlaceList();

    //get list ///////
    List<PlaceModel> placeModel = provider.getPlaceList;

    Widget renderPlace(ctx, index) {
      return PlaceWidget(
        image: placeModel[index].image,
        title: placeModel[index].title,
      );
    }

    return SafeArea(
      child: Scaffold(
          body: ListView.builder(
        itemBuilder: renderPlace,
        itemCount: placeModel.length,
      )),
    );
  }
}
