import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_service_fetin/Screens/Welcome/welcome_screen.dart';
import 'package:food_service_fetin/constants.dart';
import 'package:provider/provider.dart';

import 'AppState.dart';

Future<void> main() async {
  await dotenv.load();

  final FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['APIKEY'] ?? 'API_URL not found',
    authDomain: dotenv.env['AUTHDOMAIN'] ?? 'AUTHDOMAIN not found',
    projectId: dotenv.env['PROJECTID'] ?? 'PROJECTID not found',
    storageBucket: dotenv.env['STORAGEBUCKET'] ?? 'STORAGEBUCKET not found',
    messagingSenderId: dotenv.env['MSGSENDERID'] ?? 'MSGSENDERID not found',
    appId: dotenv.env['APPID'] ?? 'APPID not found',
    measurementId: dotenv.env['MEASUREID'] ?? 'MEASUREID not found',
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: firebaseOptions,
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
