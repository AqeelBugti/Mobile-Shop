import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helloecommerce/provider/category_Provider.dart';
import 'package:helloecommerce/provider/my_provider.dart';
import 'package:helloecommerce/provider/place_provider.dart';
import 'package:helloecommerce/screen/homePage.dart';
import 'package:helloecommerce/screen/logIn.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ManCategoryProvider>(
          create: (BuildContext context) => ManCategoryProvider(),
        ),
        ChangeNotifierProvider<MyProvider>(
          create: (BuildContext context) => MyProvider(),
        ),
        ChangeNotifierProvider<PlaceProvider>(
          create: (BuildContext context) => PlaceProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Color(0xff507786),
          // primaryColor: Color(0xff068a8c)
        ),
        home: 
        StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return MyHomePage();
            }
            return LogIn();
          },
        ),
      ),
    );
  }
}
