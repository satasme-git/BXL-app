import 'package:binary_app/screens/Video/video.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Videos extends StatefulWidget {
//  const Videos({ Key? key }) : super(key: key);
  String docid;
  Videos({
    required this.docid,
  });

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Video",
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("videoLecture")
                .doc(widget.docid)
                .collection("VideoList")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    /*    child: SpinKitRing(
                  color: Colors.blue,
                )*/
                    );
                //  Center(child: LoadingFilling.square());
              }
              return ListView(
                  children: snapshot.data!.docs.map((docReference) {
                String id = docReference.id;
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          //   border: Border.all(color: Colors.blueAccent)
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                /* backgroundImage:
                                    NetworkImage(docReference['imageUrl']),*/
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Course Name :',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        docReference['VideoName'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Duration:',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          docReference['Duration'],
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                // ignore: deprecated_member_use
                                child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        //   border: Border.all(color: Colors.blueAccent)
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => videoplay(
                                                      Linkid: docReference[
                                                          "VideoId"],
                                                    )));
                                        print(docReference["VideoId"]);
                                      },
                                      child: Text('Watch Video'),
                                    )),
                              )
                            ]),
                      )),
                )
                    /*  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              //   border: Border.all(color: Colors.blueAccent)
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(docReference['imageUrl']),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Course Name :',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            docReference['CourseName'],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          'Course Fee :',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          docReference['CourseFee'],
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    // ignore: deprecated_member_use
                                    child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            //   border: Border.all(color: Colors.blueAccent)
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FreeClassVideo(
                                                          vdoLink: docReference[
                                                              'videoUrl'],
                                                          title: 'Intro',
                                                        )));
                                          },
                                          child: Icon(Icons.videocam_sharp),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {},
                              color: Color(0xff00007c),
                            ),
                          ]),
                        ),
                      ]),
                    ),
                  ),*/
                    );
              }).toList());
            }));
  }
}
