

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app_flutter/Provider/favorite_provider.dart';
import 'package:recipe_app_flutter/Provider/quantity_provider.dart';
import 'package:recipe_app_flutter/Views/app_main_screen.dart';
import 'package:recipe_app_flutter/Views/login_screnn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //For favorite provider
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        // Quantity provider
        ChangeNotifierProvider(create: (context) => QuantityProvider()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
