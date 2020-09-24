import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helloecommerce/model/userModel.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/homePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool profileCondition = false;
  File cameraImage;
  var uid;
  Future getImages() async {
    final getImages = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      cameraImage = File(getImages.path);
    });
  }

  Future<String> _uploadFile(File _image) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/$uid');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final String _imagesUrl = (await taskSnapshot.ref.getDownloadURL());
    return _imagesUrl;
  }

  var imagesUrl;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  void userDataUpdate({UserModel currentUsers}) async {
    cameraImage != null
        ? imagesUrl = await _uploadFile(cameraImage)
        : Container();
    FirebaseFirestore.instance.collection("user").doc(uid).update({
      "UserName": name.text,
      "UserEmail": email.text,
      'UserPhoneNumber': phoneNumber.text,
      'UserPassword': password.text,
      "UserImageUrl": cameraImage == null ? currentUsers.image : imagesUrl,
    });
  }

  RegExp regex = new RegExp(ProfileScreen.pattern);

  final GlobalKey<ScaffoldState> _myKey = GlobalKey<ScaffoldState>();

  void getCurrentUser() async {
    final User user = FirebaseAuth.instance.currentUser;
    uid = user.uid;
  }

  Widget _profileText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 35.0,
          letterSpacing: 1.5,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _circleAvatar({UserModel currentUsers}) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          image: cameraImage == null
              ? currentUsers.image == null
                  ? AssetImage('images/ProfileImage.jpg')
                  : NetworkImage(currentUsers.image)
              : FileImage(cameraImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _textFormField(
      {String hintText, IconData icon, TextEditingController myController}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: Colors.white30),
      ),
    );
  }

  Widget _textFormFieldCalling({UserModel currentUsers}) {
    return Container(
      height: 450,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _textFormField(
            hintText: 'User-Name',
            icon: Icons.person,
            myController: name,
          ),
          _textFormField(
            hintText: 'E-mail',
            icon: Icons.mail,
            myController: email,
          ),
          _textFormField(
              hintText: 'Password', icon: Icons.lock, myController: password),
          _textFormField(
            hintText: 'Contact Number',
            icon: Icons.phone,
            myController: phoneNumber,
          ),
          Container(
            height: 55,
            width: double.infinity,
            child: profileCondition == false
                ? Container()
                : RaisedButton(
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {
                      snackBarValidation(
                        currentUsers: currentUsers,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _falseTextField({IconData icon, String hintText}) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 13),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.black54,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  bottom: 2,
                ),
                child: Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 16.2,
                    letterSpacing: 2,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _falseTextFieldCall({UserModel currentUsers}) {
    return Container(
      height: 450,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _falseTextField(
            hintText: currentUsers.name,
            icon: Icons.person,
          ),
          _falseTextField(
            hintText: currentUsers.email,
            icon: Icons.mail,
          ),
          _falseTextField(
            hintText: currentUsers.passWord,
            icon: Icons.lock,
          ),
          _falseTextField(
            hintText: currentUsers.phoneNumber.toString(),
            icon: Icons.phone,
          ),
          Container(
            height: 55,
            width: double.infinity,
            child: profileCondition == false
                ? Container()
                : RaisedButton(
                    color: Colors.black54,
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
          ),
        ],
      ),
    );
  }

  Widget _cameraInCircle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 270, left: 184),
      child: profileCondition == true
          ? CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                onPressed: () {
                  getImages();
                },
              ),
            )
          : Container(),
    );
  }

  void snackBarValidation({UserModel currentUsers}) {
    if (email.text.isEmpty && password.text.isEmpty) {
      _myKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Both field are empty"),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    } else if (email.text.isEmpty || email.text.trim() == null) {
      _myKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is Empty"),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    if (regex.hasMatch(email.text) == false) {
      _myKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Please enter valid emai',
          ),
          duration: Duration(milliseconds: 600),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    {
      setState(() {
        profileCondition = false;
      });
      userDataUpdate(
        currentUsers: currentUsers,
      );
    }
  }

  @override
  void initState() {
    MyProvider myProvider = Provider.of<MyProvider>(context , listen: false);
    myProvider.fetchUserData();
    UserModel currentUsers = myProvider.currentUsers;
    name = TextEditingController(text: currentUsers.name);
    email = TextEditingController(text: currentUsers.email);
    password = TextEditingController(text: currentUsers.passWord);
    phoneNumber = TextEditingController(
      text: currentUsers.phoneNumber.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    MyProvider myProvider = Provider.of<MyProvider>(context,);
    myProvider.fetchUserData();
    UserModel currentUsers = myProvider.currentUsers;

    return Scaffold(
      key: _myKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff555555),
        elevation: 0.0,
        leading: profileCondition == false
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
              )
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(
                    () {
                      profileCondition = false;
                    },
                  );
                },
              ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                profileCondition = true;
              });
            },
            icon: Text(
              "Edit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    profileCondition == true
                        ? _textFormFieldCalling(currentUsers: currentUsers)
                        : _falseTextFieldCall(currentUsers: currentUsers),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _profileText(),
              _circleAvatar(currentUsers: currentUsers),
            ],
          ),
          _cameraInCircle(),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
