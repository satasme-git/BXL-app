import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  CustomLoader({
    this.loadertype = false,
    Key? key,
  }) : super(key: key);
  bool loadertype;
  @override
  Widget build(BuildContext context) {
    return loadertype
        ? SpinKitThreeBounce(
            color: Colors.lightBlue,
            size: 20,
            // lineWidth: 3,
          )
        : SpinKitRing(
            color: Colors.lightBlue,
            size: 28,
            lineWidth: 3,
          );
  }
}
