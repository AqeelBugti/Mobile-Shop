import 'package:helloecommerce/model/Cart_Product.dart';

class ProductOrder {
  String id;
  double price;
  List<CartProduct> list;
  DateTime dateTime;
  ProductOrder({ this.list, this.price, this.dateTime, this.id});
}


