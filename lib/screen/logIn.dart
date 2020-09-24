import 'package:flutter/material.dart';
import '../screen/signup.dart';
import '../widget/MyTextFromField.dart';
import '../widget/RaisedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LogIn extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _auth = FirebaseAuth.instance;

  bool isLoading = false;

  UserCredential authResult;

  RegExp regex = new RegExp(LogIn.pattern);

  final GlobalKey<ScaffoldState> _myKey = GlobalKey<ScaffoldState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  void snackBarValidation() {
    if (email.text.isEmpty && password.text.isEmpty) {
      _myKey.currentState
          .showSnackBar(SnackBar(content: Text("Both field are empty")));
      return;
    } else if (email.text.isEmpty || email.text.trim() == null) {
      _myKey.currentState
          .showSnackBar(SnackBar(content: Text("Email is Emptey")));
      return;
    }
    if (regex.hasMatch(email.text) == false) {
      _myKey.currentState.showSnackBar(SnackBar(
          content: Text(
        'Please enter valid email',
      )));
      return;
    }
    if (password.text.isEmpty || password.text.trim() == null) {
      _myKey.currentState
          .showSnackBar(SnackBar(content: Text("Password is Emptey")));
      return;
    }
    if (password.text.length < 8) {
      _myKey.currentState.showSnackBar(
          SnackBar(content: Text("Pasword Must be greater then 8")));
    }
  }

  Widget _loginAndWelcomeBackText() {
    return Container(
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(
                fontSize: 40,
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Welcome back!",
            style: TextStyle(
                fontSize: 24,
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _emailAndPasswordField() {
    return Container(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFromField(
            hintText: 'Email',
            keybord: TextInputType.emailAddress,
            myObscureText: false,
            myController: email,
          ),
          MyTextFromField(
            hintText: 'Password',
            keybord: TextInputType.emailAddress,
            myObscureText: true,
            myController: password,
          ),
        ],
      ),
    );
  }

  Widget _dontHaveAnAccountSignUpText(context) {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "don't have an account?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
            child: Text(
              "SignUp",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _raisedButton(context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: MyRaisedutton(
        buttonText: 'Login',
        myColor: Theme.of(context).accentColor,
        whenPress: () async {
          try {
            setState(() {
              isLoading = true;
            });
            authResult = await _auth.signInWithEmailAndPassword(
                email: email.text, password: password.text);
            snackBarValidation();
          } on PlatformException catch (err) {
            var message = 'Please check your internet';
            if (err.message != null) {
              message = err.message;
            }
            _myKey.currentState.showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).errorColor,
              ),
            );
            setState(
              () {
                isLoading = false;
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _myKey,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              _loginAndWelcomeBackText(),
              _emailAndPasswordField(),
              Container(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (isLoading)
                      CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    if (!isLoading) _raisedButton(context),
                    _dontHaveAnAccountSignUpText(context),
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
