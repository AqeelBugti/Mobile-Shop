import 'package:flutter/material.dart';

class UserModel {
  String name;
  String email;
  String passWord;
  String phoneNumber;
  String image;

  UserModel({
   @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.passWord,
    @required this.image,
  });
}
