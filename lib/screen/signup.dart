import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helloecommerce/screen/homePage.dart';
import 'logIn.dart';
import '../widget/MyTextFromField.dart';
import '../widget/RaisedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final RegExp regex = RegExp(SignUp.pattern);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final auth = FirebaseAuth.instance;

  bool isLoading = false;
  UserCredential authResult;

  void submit() async {
    try {
      setState(() {
        isLoading = true;
      });
      authResult = await auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      FirebaseFirestore.instance
          .collection("user")
          .doc(authResult.user.uid)
          .set({
        "UserEmail": email.text,
        "UserName": fullName.text,
        'UserPassword':password.text,
        'UserPhoneNumber':phoneNumber.text,
        "UserId": authResult.user.uid,
      });
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message;
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(error),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );

      print(error);
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => MyHomePage()));
    setState(
      () {
        isLoading = false;
      },
    );
  }

  vaildationText() {
    if (fullName.text.isEmpty && email.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please Fill All Text"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    } else if (fullName.text.trim() == null || fullName.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("FullName Is Empty"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    } else if (email.text.isEmpty || email.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Email is Empty"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    } else if (!regex.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please Try Vaild Email"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    } else if (password.text.isEmpty || password.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Password is Empty"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    } else if (password.text.length < 8) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Password is too short"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    } else {
      submit();
    }
  }

  Widget _buildAllVaildTextButton() {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFromField(
            hintText: "fullName",
            keybord: TextInputType.emailAddress,
            myController: fullName,
            myObscureText: false,
          ),
          MyTextFromField(
            hintText: "Email",
            keybord: TextInputType.emailAddress,
            myController: email,
            myObscureText: false,
          ),
          MyTextFromField(
            hintText: "password",
            keybord: TextInputType.emailAddress,
            myController: password,
            myObscureText: true,
          ),
          MyTextFromField(
            hintText: "PhoneNumber",
            keybord: TextInputType.emailAddress,
            myController: phoneNumber,
            myObscureText: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTopPart(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 105,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Signup",
                  style: TextStyle(
                      fontSize: 35, color: Theme.of(context).primaryColor),
                ),
                Text(
                  "create an account",
                  style: TextStyle(
                      fontSize: 25, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          // CircleAvatar(
          //   radius: 60,
          //   backgroundColor: Theme.of(context).primaryColor,
          //   child: GestureDetector(
          //     onTap: () {
          //       getImage();
          //     },
          //     child: CircleAvatar(
          //       backgroundColor: Colors.white,
          //       radius: 55,
          //       backgroundImage: myImage == null
          //           ? AssetImage("images/CirclePerson.png")
          //           : FileImage(myImage),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBottomButoon(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        isLoading == false
            ? Container(
                height: 60,
                width: double.infinity,
                child: MyRaisedutton(
                  buttonText: 'Sign up',
                  myColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  whenPress: () {
                    vaildationText();
                  },
                ),
              )
            : CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Already have an account ?",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => LogIn()));
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTopPart(context),
                _buildAllVaildTextButton(),
                _buildBottomButoon(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
