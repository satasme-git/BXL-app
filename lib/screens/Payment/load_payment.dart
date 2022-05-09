import 'dart:convert';
import 'dart:typed_data';

import 'package:binary_app/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoadPaymnet extends StatelessWidget {
  LoadPaymnet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    DateTime now = DateTime.now();
    String formatDate = DateFormat('yyyyMMddkkmm').format(now);

    return Scaffold(
        // appBar: _appBar(),
        // body: WebView(
        //   initialUrl:
        //       'https://bxladmin.monthekristho.com/onepay-php-main/payment.php',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
        body: Consumer<PaymentProvider>(
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.only(top: 38),
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(
                  "https://bxladmin.monthekristho.com/onepay-php-main/payment.php"),
              method: 'POST',
              body: Uint8List.fromList(utf8.encode(
                  "firstname=${value.getPaymentModel!.firstname}&lastname=${value.getPaymentModel!.lastname}&email=${value.getPaymentModel!.email}&tele=${value.getPaymentModel!.phone}&stuid=${value.getPaymentModel!.uid}&pay=100&ref=${formatDate}")),
              headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            ),
            onConsoleMessage: (controller, consoleMessage) {
              print("############################### : " +
                  consoleMessage.message.toString());
              // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
            },

            // onWebViewCreated: (controller) {},
          ),
        );
      },
    ));
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text(
      "Course Details",
      style: TextStyle(color: Colors.black),
    ),
    leading: Container(
      margin: EdgeInsets.all(10),
      // height: 25,
      // width: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      // child: Builder(
      //   builder: (BuildContext context) {
      //     return IconButton(
      //       padding: EdgeInsets.all(3),
      //       icon: const Icon(
      //         MaterialCommunityIcons.chevron_left,
      //         size: 30,
      //       ),
      //       color: Colors.black,
      //       onPressed: () {},
      //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //     );
      //   },
      // ),
    ),
  );
}
