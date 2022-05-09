import 'package:binary_app/screens/test_content.dart';
import 'package:binary_app/screens/test_screen2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/corse_provider.dart';
import '../utils/util_functions.dart';

class TestScreen3 extends StatefulWidget {
  const TestScreen3({Key? key}) : super(key: key);

  @override
  State<TestScreen3> createState() => _TestScreen3State();
}

class _TestScreen3State extends State<TestScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Provider.of<CourseProvider>(context, listen: false)
                .loadSection();

            UtilFuntions.pageTransition(
                context, TestContent(), const TestScreen3());
          },
          child: Container(
            child: Text("Scren 3"),
          ),
        ),
      ),
    );
  }
}
