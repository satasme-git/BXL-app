import 'dart:convert';
import 'dart:typed_data';
import 'package:binary_app/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../utils/util_functions.dart';
import '../courselist.dart';

class SuccessStories extends StatelessWidget {
  const SuccessStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formatDate = DateFormat('yyyyMMddhhmm').format(now);

    return Scaffold(
        appBar: _appBar(),
        // body: WebView(
        //   initialUrl:
        //       'https://bxladmin.monthekristho.com/onepay-php-main/payment.php',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
        body: Consumer<PaymentProvider>(
          builder: (context, value, child) {
            return Container(
              margin: EdgeInsets.only(top: 0),
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse("https://bxl.lk/success-stories/"),
                  body: Uint8List.fromList(utf8.encode(
                      "firstname=${value.getPaymentModel!.firstname}&lastname=${value.getPaymentModel!.lastname}&email=${value.getPaymentModel!.email}&tele=${value.getPaymentModel!.phone}&stuid=${value.getPaymentModel!.uid}&pay=${value.getPaymentModel!.amount}&ref=${formatDate}")),
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                  },
                ),

                // onWebViewCreated: (controller) {},
              ),
            );
          },
        ));
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: HexColor("#283890"),
    elevation: 0,
    title: const Text(
      "Success stories",
      style: TextStyle(fontSize: 14, color: Colors.white),
    ),
    automaticallyImplyLeading: false,
    actions: const [
      // Icon(
      //   MaterialCommunityIcons.dots_vertical,
      //   size: 20,
      // ),
      // SizedBox(
      //   width: 20,
      // ),
    ],
    leading: Container(
      margin: const EdgeInsets.all(10),
      // height: 25,
      // width: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
      child: Builder(
        builder: (BuildContext context) {
          return IconButton(
            padding: const EdgeInsets.all(3),
            icon: const Icon(
              MaterialCommunityIcons.chevron_left,
              size: 30,
            ),
            color: Colors.white,
            onPressed: () {
              UtilFuntions.goBack(context);
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    ),
  );
}
