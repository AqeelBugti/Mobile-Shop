import 'package:flutter/material.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/DetailPage.dart';
import 'package:helloecommerce/widget/cartScreenWidget.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  MyProvider myProvider;
  Widget _subtotal() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Subtotal",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        Text(
          '\$${myProvider.getTottalAmount.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _checkOutDetail(
      {@required Color color,
      @required BuildContext context,
      @required String name,
      @required double price}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _checkOutDetailDivider() {
    return Divider(
      thickness: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    double shippingCost = 10;
    double taxes = 3;
    double total;
    double discountRupees;
    myProvider = Provider.of<MyProvider>(context);
    myProvider.fetchUserData();

    discountRupees = shippingCost / 100 * taxes;
    total = myProvider.getTottalAmount + shippingCost - discountRupees;
    if (myProvider.allProductList.isEmpty) {
      total = 0.0;
      taxes = 0.0;
      shippingCost = 0.0;
    }
    return Scaffold(
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0,
        title: Text('CartScreen'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (ctx) => DetailPage(
                  
                ),
              ),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 750,
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Container(
                    height: 300,
                    child: ListView.builder(
                        itemCount: myProvider.cartProductlength,
                        itemBuilder: (context, index) {
                          myProvider.getRemoveIndex(index);
                          return Container(
                            child: Column(
                              children: [
                                CartScreenWidget(
                                  image: myProvider
                                      .allProductList[index].cartProductImage,
                                  name: myProvider
                                      .allProductList[index].cartProductName,
                                  price: myProvider
                                      .allProductList[index].cartProductPrice,
                                  quantity: myProvider.allProductList[index]
                                      .cartProductQuantity,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Container(
                      height: 230,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _subtotal(),
                          _checkOutDetailDivider(),
                          _checkOutDetail(
                              color: Theme.of(context).accentColor,
                              context: context,
                              name: 'Shipping Cost',
                              price: shippingCost),
                          _checkOutDetailDivider(),
                          _checkOutDetail(
                              color: Theme.of(context).accentColor,
                              context: context,
                              name: 'Taxes',
                              price: taxes),
                          _checkOutDetailDivider(),
                          _checkOutDetail(
                              color: Colors.black87.withOpacity(0.7),
                              context: context,
                              name: 'Total',
                              price: total),
                        ],
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (ctx) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      height: 55,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.black54,
                        child: Text(
                          "CHECKOUT",
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 3,
                              color: Colors.white),
                        ),
                        onPressed: myProvider.getTottalAmount <= 0
                            ? null
                            : () async {
                                await Provider.of<MyProvider>(context,
                                        listen: false)
                                    .addOrder(
                                  myProvider.allProductList.toList(),
                                  myProvider.getTottalAmount,
                                );
                                myProvider.clean();
                                Scaffold.of(ctx).showSnackBar(
                                  SnackBar(
                                    content: Text('Your order successful'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
