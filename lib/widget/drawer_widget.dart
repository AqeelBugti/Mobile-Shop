import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helloecommerce/model/userModel.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/screen/checkout_page.dart';
import 'package:helloecommerce/screen/homePage.dart';
import 'package:helloecommerce/screen/logIn.dart';
import 'package:provider/provider.dart';
import '../screen/profile.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Widget drawer({
    @required IconData icon,
    @required String text,
    @required Color colors,
    @required Function whenPress,
    @required BuildContext context,
  }) {
    return InkWell(
      onTap: whenPress,
      splashColor: Theme.of(context).accentColor.withOpacity(0.1),
      child: ListTile(
        leading: Container(
          child: IconButton(
            icon: Icon(
              icon,
              color: colors,
            ),
            onPressed: () {},
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _userAccountsDrawerHeader({context, UserModel currentUsers}) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      accountName: Text(
        currentUsers.name,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        currentUsers.email,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      currentAccountPicture: GestureDetector(
        onTap: () {},
        child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            currentUsers.image == null
                ? 'https://www.abc.net.au/news/image/8314104-1x1-940x940.jpg'
                : currentUsers.image,
          ),
        ),
      ),
    );
  }

  Widget _logOutPageCallingDrawer(context) {
    return drawer(
      context: context,
      icon: Icons.exit_to_app,
      colors: Theme.of(context).accentColor,
      text: "Log out",
      whenPress: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => LogIn(),
          ),
        );
      },
    );
  }

  Widget _profilePageCallingDrawer(context) {
    return drawer(
      context: context,
      icon: Icons.person,
      colors: Theme.of(context).accentColor,
      text: "Profile",
      whenPress: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => ProfileScreen(),
          ),
        );
      },
    );
  }

  Widget _aboutPageCallingDrawer(context) {
    return drawer(
      context: context,
      icon: Icons.help,
      colors: Theme.of(context).accentColor,
      text: "About",
      whenPress: null,
    );
  }

  Widget _shoppingCartPageCallingDrawer(context) {
    return drawer(
      context: context,
      icon: Icons.shopping_cart,
      colors: Theme.of(context).accentColor,
      text: "Shopping Cart ",
      whenPress: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => Checkout(),
          ),
        );
      },
    );
  }

  Widget _myOrderPageCallingDrawer(context) {
    return drawer(
      context: context,
      icon: Icons.shopping_basket,
      colors: Theme.of(context).accentColor,
      text: "My Orders",
      whenPress: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => MyHomePage(),
          ),
        );
      },
    );
  }

  Widget _homePageCallingDrawer(context) {
    return drawer(
      context: context,
      icon: Icons.home,
      colors: Theme.of(context).accentColor,
      text: "Home page",
      whenPress: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => MyHomePage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context);
    myProvider.fetchUserData();
    UserModel currentUsers = myProvider.currentUsers;

    return SafeArea(
      child: Column(
        children: [
          _userAccountsDrawerHeader(
            context: context,
            currentUsers: currentUsers,
          ),
          Container(
            height: 600,
            child: ListView(
              children: <Widget>[
                _homePageCallingDrawer(context),
                Divider(),
                _myOrderPageCallingDrawer(context),
                Divider(),
                _shoppingCartPageCallingDrawer(context),
                Divider(),
                _profilePageCallingDrawer(context),
                Divider(),
                _aboutPageCallingDrawer(context),
                Divider(),
                _logOutPageCallingDrawer(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
