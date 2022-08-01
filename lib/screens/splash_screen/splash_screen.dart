import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../provider/slider_provider.dart';
import '../../provider/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Provider.of<SliderProvider>(context, listen: false).fetchSliders();
      Provider.of<UserProvider>(context, listen: false).initializeUser(context);
      // UtilFunctions.navigateTo(context, const GettingStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
        // AnimatedSplashScreen(
        //   splashIconSize: 200,
        //   // customTween: ,
        //   backgroundColor: Colors.white,
        //   splash: Container(
        //     height: 400,
        //     child: Column(
        //       children: [
        //         Container(
        //           // height: 200,
        //           width: 140,
        //           child: const Image(
        //             image: AssetImage(
        //               "assets/logo.png",
        //             ),
        //           ),
        //         ),
        //         const SpinKitRing(
        //           color: Colors.black,
        //           size: 28.0,
        //           lineWidth: 2,
        //         ),
        //         const SizedBox(
        //           height: 10,
        //         ),
        //         const Text(
        //           "loading informations...",
        //         ),
        //       ],
        //     ),
        //   ),
        //   nextScreen: getStarted(),
        //   splashTransition: SplashTransition.fadeTransition,
        //   pageTransitionType: PageTransitionType.leftToRight,
        // );
        Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              child: Image.asset(
                'assets/logo.png',
                scale: 0.5,
              ),
            ),
            const SpinKitRing(
              color: Colors.black,
              size: 28.0,
              lineWidth: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "loading informations...",
            ),
          ],
        ),
      ),
    );
  }
}
