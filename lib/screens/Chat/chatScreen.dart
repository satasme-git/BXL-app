import 'package:binary_app/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({Key? key}) : super(key: key);

  @override
  _chatScreenState createState() => _chatScreenState();
}

var ctime;
var limit = 2;
String userName = '';
var messg;
TextEditingController msg = TextEditingController();
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
time() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ctime = prefs.getString('time');
  print(ctime);
}

class _chatScreenState extends State<chatScreen> {
  @override
  void initState() {
    // TODO: implement initState

    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          userName = doc["fname"];
        });
        print(userName);
      });
    });

    super.initState();
    time();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              child: TextField(
                  controller: msg,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Enter your message',
                    filled: true,
                    fillColor: Colors.grey[100],
                  )),
            ),
            IconButton(
              iconSize: 25,
              icon: Icon(
                Icons.send,
                color: Colors.blue,
              ),
              onPressed: () {
                if (msg.text != '') {
                  createuser();
                  msg.clear();
                } else {
                  print("cant send empty messages");
                  print(ctime);
                  print(userName);
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Messages", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      /*persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.78,
                child: TextField(
                    controller: msg,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter your message',
                      filled: true,
                      fillColor: Colors.grey[100],
                    )),
              ),
              IconButton(
                iconSize: 35,
                icon: Icon(
                  Icons.send,
                  color: Colors.green,
                ),
                onPressed: () {
                  createuser();
                  msg.clear();
                },
              ),
            ],
          )
        ],*/
      body: chat(),
    );
  }

  Widget chat() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .where('time', isGreaterThan: ctime)
            .orderBy('time', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                /*    child: SpinKitRing(
                  color: Colors.blue,
                )*/
                );
            //  Center(child: LoadingFilling.square());
          }
          return SizedBox(
            height: 1000,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 74),
              child: ListView(
                  children: snapshot.data!.docs.map((docReference) {
                String id = docReference.id;
                return Center(
                    child: Container(
                        // width: double.infinity,
                        //height: MediaQuery.of(context).size.height * 0.9,
                        decoration: BoxDecoration(
                            //color: Colors.blueAccent,
                            //   border: Border.all(color: Colors.blueAccent)
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: <Widget>[
                            if (docReference['uid'] ==
                                auth.currentUser?.uid) ...[
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green[300],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(docReference['msg'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(docReference['time'],
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ] else ...[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(docReference['name'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(docReference['msg'],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              )),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(docReference['time'],
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]

                            /* Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    docReference['msg'],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )*/
                          ]),
                        )));
              }).toList()),
            ),
          );
        });
  }

  Future<void> createuser() async {
    const KEY_MSG = "msg";
    const KEY_UID = "uid";
    const KEY_TIME = "time";
    const KEY_CTIME = "ctime";
    const KEY_NAME = "name";

    await _fireStore.collection('chat').doc().set({
      KEY_MSG: msg.text,
      KEY_UID: auth.currentUser?.uid,
      KEY_TIME: DateTime.now().toString(),
      KEY_CTIME: DateFormat('yyyy-MM-dd KK:MM').format(DateTime.now()),
      KEY_NAME: userName,
    });
  }
}
