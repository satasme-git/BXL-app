import 'package:binary_app/screens/test_content.dart';
import 'package:binary_app/screens/test_screen3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/corse_provider.dart';
import '../utils/util_functions.dart';

class TestScreen2 extends StatefulWidget {
  const TestScreen2({Key? key}) : super(key: key);

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Provider.of<CourseProvider>(context, listen: false)
                .addItems(context);
            Provider.of<CourseProvider>(context, listen: false)
                .addSection(context);
                 Provider.of<CourseProvider>(context, listen: false)
                .loadSection();


            UtilFuntions.pageTransition(
                context, TestContent(), const TestScreen2());
          },
          child: Container(
            child: Text("nestaa"),
          ),
        ),
      ),
    );
  }
}
