import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationTest extends StatefulWidget {
  const NotificationTest({Key? key}) : super(key: key);

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseMessaging.instance
                    .subscribeToTopic("myTopic");
                
              },
              child: Text("subscribe to topic"),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseMessaging.instance
                    .unsubscribeFromTopic("myTopic");
              },
              child: Text("Unsubscribe to topic"),
            ),
              ElevatedButton(
              onPressed: ()  {
                  callOnFcmApiSendPushNotifications(title:"fcm by api",body: "its work fine");
              },
              child: Text("send message"),
            ),
          ],
        ),
      ),
    );
  }

    Future<bool> callOnFcmApiSendPushNotifications(
      {required String title, required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/myTopic",
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':'AAAAQW7i1Ec:APA91bEKXeJzuOTqyVsC-tKnAyAJ_B4qFcZtChXtWXr29mIJp50ZLcVHFYdsDBaoJ1nM8BhYRTV8W_VbiY-4xMW-Z7S1s0uGpeyI9Gkrjv1mjb-FStqpOatDYNevmPgNMaFPQZr36vhC'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error'+response.body.toString());
      // on failure do sth
      return false;
    }
  }


}
