import 'package:binary_app/provider/chat_provider.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/Chat/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class aboutUs extends StatefulWidget {
  const aboutUs({Key? key}) : super(key: key);

  @override
  _aboutUsState createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "About Us",
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
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "BINARY",
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                color: Color(0xff3949ab),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Export Lanka Power Team",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                color: Color(0xff3949ab),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "How To Join With  Us",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            "assets/logo.png",
                            width: 100,
                            height: 100,
                          ),
                        )
                      ],
                    ),
                    Consumer2<ChatProvider, UserProvider>(
                      builder: (context, value, value2, child) {
                        return InkWell(
                          onTap: () {
                            Logger().d(
                                ">>>>>>>>>>>>>>>>>>>>>>>>>> : sadasdassdasdas erwrdrwe");
                            value.createConversation(
                                context, value2.getuserModel);
                          },
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed auctor lectus. Phasellus ut neque lacus. Etiam egestas eros elit, a dapibus nunc sodales a. Nulla rutrum finibus nulla, nec ornare risus lacinia et. Quisque vehicula urna libero, at vehicula lorem congue sed. Duis finibus eros in commodo rhoncus. In a ex rhoncus, lacinia sapien quis, convallis nisi. Integer nunc tellus, tristique quis pulvinar ut, imperdiet sit amet metus. Etiam ut ullamcorper libero.Sed sed auctor lectus. Phasellus ut neque lacus. Etiam egestas eros elit, a dapibus nunc sodales a. Nulla rutrum finibus nulla, nec ornare risus lacinia et. Quisque vehicula urna libero, at vehicula lorem congue sed. Duis finibus eros in commodo rhoncus. In a ex rhoncus, lacinia sapien quis, convallis nisi. Integer nunc tellus, tristique quis pulvinar ut, imperdiet sit amet metus. Etiam ut ullamcorper libero.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff3949ab),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Join With Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
