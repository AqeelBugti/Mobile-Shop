import 'package:flutter/material.dart';
import 'package:helloecommerce/model/product.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/DetailPage.dart';
import 'package:helloecommerce/widget/categories.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate<MyProduct> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    List<MyProduct> _searchfoodList = provider.search(query);

    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 0.2,
        mainAxisSpacing: 2,
        padding: EdgeInsets.only(top: 10),
        children: _searchfoodList
            .map<Widget>((e) => Categories(
                  description: e.productDescription,
                  ontap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DetailPage(
                              description: e.productDescription,
                              image: e.productImages,
                              name: e.productName,
                              price: e.productPrice,
                            )));
                  },
                  image: e.productImages,
                  name: e.productName,
                  price: e.productPrice,
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    List<MyProduct> _searchfoodList = provider.search(query);
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 0.2,
        mainAxisSpacing: 2,
        padding: EdgeInsets.only(top: 10),
        children: _searchfoodList
            .map<Widget>((e) => Categories(
                  description: e.productDescription,
                  ontap: () {
                    Navigator.of(context).pushReplacement(
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
                  image: e.productImages,
                  name: e.productName,

                  price: e.productPrice,
                  // context: context,
                  // image: e.image,
                  // onPress: () {},
                  // price: e.price,
                  // ratting: e.ratting,
                  // subtext: e.foodsubTmanittle,
                  // text: e.foodName,
                ))
            .toList());
  }
}
