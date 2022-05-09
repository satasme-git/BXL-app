import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LecDetails extends StatefulWidget {
  const LecDetails({Key? key}) : super(key: key);

  @override
  State<LecDetails> createState() => _LecDetailsState();
}

class _LecDetailsState extends State<LecDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "All Courses",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Date: 2022/05/01'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Time: 8.00 PM'),
                ],
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                    onPressed: () {
                      _launchURL();
                    },
                    child: Text('Join Now')),
              ),
            )
          ],
        ));
  }

  _launchURL() async {
    const url =
        'https://us05web.zoom.us/j/2845889752?pwd=Zi8reFR0ZHZlaGlnK0xMeTlYUkluZz09';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
