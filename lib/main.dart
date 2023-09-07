import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_service_fetin/Screens/Welcome/welcome_screen.dart';
import 'package:food_service_fetin/constants.dart';
import 'package:provider/provider.dart';

import 'AppState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD3-uDjOHlzHWkpjJDngIMuCaq4T6dYOu4",
        authDomain: "foodservice-78cae.firebaseapp.com",
        projectId: "foodservice-78cae",
        storageBucket: "foodservice-78cae.appspot.com",
        messagingSenderId: "857760438028",
        appId: "1:857760438028:web:fbc358f1af3669cfa71b29",
        measurementId: "G-3ZG9CTX6MZ"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AppStateCart>(create: (_) => AppStateCart()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Service',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
    );
  }
}
