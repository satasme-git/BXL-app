import 'package:binary_app/screens/Chat/chatScreen.dart';
import 'package:binary_app/screens/Chat/groupChat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatHome extends StatefulWidget {
  const chatHome({Key? key}) : super(key: key);

  @override
  State<chatHome> createState() => _chatHomeState();
}

class _chatHomeState extends State<chatHome> {
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => chatScreen()));
                },
                child: Container(
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Image.asset("assets/logo.png", width: 50, height: 50),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("BXL Community",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white)))
                  ]),
                  decoration: BoxDecoration(
                      color: Colors.lightGreen[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            list()
          ],
        ),
      ),
    );
  }

  Widget list() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Userchats")
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
            height: 1500,
            child: Column(
                children: snapshot.data!.docs.map((docReference) {
              String id = docReference.id;
              return Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => chatScreenG(
                                        name: docReference['name'],
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lightGreen[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/logo.png",
                                  width: 50, height: 50),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(docReference['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)))
                          ]),
                        ),
                      )));
            }).toList()),
          );
        });
  }
}
