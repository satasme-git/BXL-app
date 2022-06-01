import 'package:binary_app/provider/payment_provider.dart';
import 'package:binary_app/provider/registraion_provider.dart';
import 'package:binary_app/provider/slip_provider.dart';
import 'package:binary_app/screens/home.dart';
import 'package:binary_app/screens/login.dart';
import 'package:binary_app/screens/signup.dart';
import 'package:binary_app/screens/startPage/startpage.dart';
import 'package:binary_app/screens/test_content.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'provider/corse_provider.dart';
import 'provider/user_provider.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/test_screen2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CourseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistrationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SlipProvider(),
        ),
      ],
      child: MyApp(email: email),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({this.email, Key? key}) : super(key: key);

  // This widget is the root of your application.
  String? email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BXL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // home: email == null ? splashScreen() : HsplashScreen(),
    );
  }
}

class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xff3949ab),
      splash: Container(
        child: Image(
          image: AssetImage(
            "assets/logo.png",
          ),
          width: 200,
        ),
      ),
      nextScreen: getStarted(),
      // splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

class HsplashScreen extends StatelessWidget {
  const HsplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xff3949ab),
      splash: Container(
        child: Image(
          image: AssetImage(
            "assets/logo.png",
          ),
          width: 200,
        ),
      ),

      nextScreen: HomeScreen(),
      //splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
