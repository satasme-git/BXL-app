import 'package:binary_app/screens/Video/Videolist2.dart';
import 'package:binary_app/screens/Video/video.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Videolist extends StatefulWidget {
  const Videolist({Key? key}) : super(key: key);

  @override
  _VideolistState createState() => _VideolistState();
}

class _VideolistState extends State<Videolist> {
  var s;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECF3F9),
        appBar: AppBar(
          backgroundColor: Color(0xFFECF3F9),
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
            "All Videos",
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
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                //  s = true;
                                //val = searchcont.text;
                              });
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 200,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const TextField(
                                //  controller: searchcont,
                                decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Search Courses...',
                            ))),
                      ),
                      if (s == true) ...{
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  s = false;
                                });
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.blue,
                              )),
                        )
                      }
                    ],
                  ),
                ),
                Vlist(),
              ],
            ),
          ),
        ));
  }

  Widget Vlist() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("videoLecture").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                /*    child: SpinKitRing(
                  color: Colors.blue,
                )*/
                );
            //  Center(child: LoadingFilling.square());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: size.height,
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: snapshot.data!.docs.map((docReference) {
                    String id = docReference.id;
                    return GestureDetector(
                      onTap: () {
                        if (docReference['Fee'] != 'free') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("You haven't paid for this course"),
                              content: Text(''),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Go Back')),
                                ElevatedButton(
                                    onPressed: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Text('Pay now'))
                              ],
                            ),
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Videos(
                                        docid: docReference.id,
                                      )));
                        }
                      },
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.08),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                //Center(child: CircularProgressIndicator()),
                                Center(
                                  child: ClipRRect(
                                    
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    child: Image.network(
                                      docReference['image'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 10, bottom: 10, top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    docReference['VideoName'],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    docReference['Duration'],
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList()),
            ),
          );
        });
  }
}
