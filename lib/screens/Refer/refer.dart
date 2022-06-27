import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class refer extends StatefulWidget {
  const refer({Key? key}) : super(key: key);

  @override
  _referState createState() => _referState();
}

class _referState extends State<refer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              //  _globalKey.currentState?.openDrawer();
            },
          )
        ],
        title: Text(
          "Refer and Earn",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/refer.png"),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Refer to a friend and get a cash reward of 100rs",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Share this link with your friend. When they joined with us you'll get cash reward",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text("5014C"),
                  ),
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: "5014C"));
                      },
                      icon: Icon(Icons.copy))
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      openwhatsapp() async {
                        var whatsapp = "+919144040888";
                        var whatsappURl_android =
                            "whatsapp://send?phone=" + whatsapp + "&text=hello";
                        var whatappURL_ios =
                            "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

                        // android , web
                        if (await canLaunch(whatsappURl_android)) {
                          await launch(whatsappURl_android);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: new Text("whatsapp no installed")));
                        }
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      FontAwesomeIcons.facebookMessenger,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            )
            ,
             FlatButton(
                child: Text('Share text and link'),
                onPressed: share,
              ),
              // FlatButton(
              //   child: Text('Share local file'),
              //   onPressed: shareFile,
              // ),
          ],
        ),
      ),
    );
  }
  Future<void> share() async {
    await FlutterShare.share(
      title: 'Example share',
      text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Example Chooser Title'
    );
  }

  // Future<void> shareFile() async {
  //   List<dynamic> docs = await DocumentsPicker.pickDocuments;
  //   if (docs == null || docs.isEmpty) return null;

  //   await FlutterShare.shareFile(
  //     title: 'Example share',
  //     text: 'Example share text',
  //     filePath: docs[0] as String,
  //   );
  // }
}
