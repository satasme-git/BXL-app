import 'dart:typed_data';

import 'package:binary_app/provider/registraion_provider.dart';
import 'package:binary_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  SignatureScreen({Key? key}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  Uint8List? exportedImage;
  SignatureController controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.yellowAccent);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Signature(
            controller: controller,
            width: size.width,
            backgroundColor: Colors.lightBlue[100]!,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: size.width,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<RegistrationProvider>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            iconSize: 36,
                            onPressed: () async {
                              exportedImage = await controller.toPngBytes();
                              value.setSignature(context, exportedImage);

                              UtilFuntions.goBack(context);
                              // value.exportedImage =
                              //     await controller.toPngBytes();
                            },
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        iconSize: 36,
                        onPressed: () {
                          controller.clear();
                          UtilFuntions.goBack(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // Text("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),
              ),
        ],
      ),
    );
  }
}
