import 'package:binary_app/provider/corse_provider.dart';
import 'package:binary_app/screens/LectureDet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controller/course_controller.dart';
import 'Payment/Slippay.dart';

class courseDetails extends StatefulWidget {
  final CourseController _locationController = CourseController();

  String docid;

  courseDetails({
    required this.docid,
  });
  //const courseDetails({Key? key}) : super(key: key);

  @override
  _courseDetailsState createState() => _courseDetailsState();
}

class _courseDetailsState extends State<courseDetails> {
  Map<String, dynamic> userSearchItems = {};
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final List<String> _ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState

    // firebaseFirestore.collection('sub_section').get().then(
    //   (value) {
    //     value.docs.forEach(
    //       (result) {
    //         // print("************ : " + result.id.toString());
    //          userSearchItems.addAll(result.data());
    //           print("************ : " + userSearchItems.toString());
    //       },
    //     );
    //   },
    // );
    // print("????????????????????????");
    // Map<String, dynamic> aa =
    //     Provider.of<CourseProvider>(context, listen: false).getItems;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var item;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Course Details",
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
              .collection("course")
              .doc(widget.docid)
              .collection("Details")
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
              YoutubePlayerController _controller = YoutubePlayerController(
                // initialVideoId: _ids.first,
                initialVideoId:
                    YoutubePlayer.convertUrlToId(docReference['IntroVideo'])!,
                flags: const YoutubePlayerFlags(
                  mute: false,
                  autoPlay: true,
                  disableDragSeek: false,
                  loop: false,
                  isLive: false,
                  forceHD: false,
                  enableCaption: true,
                ),
              );
              String id = docReference['IntroVideo'];

              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.blueAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, right: 15, left: 15, bottom: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    docReference['CourseName'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(docReference['Description'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.justify,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ]),
                          ],
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: const [
                      //     Expanded(
                      //       child: Divider(
                      //         thickness: 8,
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Created By",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                                Text(
                                  docReference['instructor'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Language",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                                Text(
                                  docReference['language'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(width: size.width / 2.8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rating",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                      size: 12,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Last Update",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                                Text(
                                  docReference['updated_at'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //             "Language",
                      //             style: TextStyle(
                      //                 fontSize: 13, color: Colors.grey[600]),
                      //           ),
                      //           const Text(
                      //             "English",
                      //             style: TextStyle(
                      //               fontSize: 13,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //             "Last Update",
                      //             style: TextStyle(
                      //                 fontSize: 13, color: Colors.grey[600]),
                      //           ),
                      //           const Text(
                      //             "12-02-2022",
                      //             style: TextStyle(
                      //               fontSize: 13,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                "Course Fee " +
                                    docReference['CourseFee'] +
                                    " LKR",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What You'll Learn",
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        MaterialCommunityIcons
                                            .check_circle_outline,
                                        color: Colors.blueGrey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            "to change some of the text in the HTML"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        MaterialCommunityIcons
                                            .check_circle_outline,
                                        color: Colors.blueGrey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            "to change some of the text in the HTML"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        MaterialCommunityIcons
                                            .check_circle_outline,
                                        color: Colors.blueGrey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            "to change some of the text in the HTML"),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        MaterialCommunityIcons
                                            .check_circle_outline,
                                        color: Colors.blueGrey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            "to change some of the text in the HTML"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /* GestureDetector(
                                 
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.blue[900]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "Buy Now",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )*/

                              SizedBox(
                                width: size.width * 0.9,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        docReference['CourseFee'] + " LKR",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue[900],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: FlatButton(
                                          onPressed: () async {
                                            final QuerySnapshot result =
                                                await _fireStore
                                                    .collection('Userchats')
                                                    .where('name',
                                                        isEqualTo: docReference[
                                                            'CourseName'])
                                                    .where('uid',
                                                        isEqualTo: FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.uid)
                                                    .get();

                                            final int documents = result.size;

                                            if (documents > 0) {
                                              print("already exist");

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LecDetails(),
                                                ),
                                              );
                                            } else {
                                              /////////////////////////////////
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "Buy this Course for " +
                                                            docReference[
                                                                'CourseFee'],
                                                      ),
                                                      content: const Text(
                                                        "You haven't enrolled for this course",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          child:
                                                              Text("Buy Now"),
                                                          onPressed: () async {
                                                            var time =
                                                                DateTime.now()
                                                                    .toString();
                                                            SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            prefs.setString(
                                                                docReference[
                                                                    'CourseName'],
                                                                time);

                                                            print("done");
                                                            const KEY_UID =
                                                                "uid";
                                                            const KEY_CHATNAME =
                                                                "name";

                                                            await _fireStore
                                                                .collection(
                                                                    'Userchats')
                                                                .doc()
                                                                .set({
                                                              KEY_UID: auth
                                                                  .currentUser
                                                                  ?.uid,
                                                              KEY_CHATNAME:
                                                                  docReference[
                                                                      'CourseName']
                                                            });
                                                          },
                                                        ),
                                                        TextButton(
                                                          child:
                                                              Text("Go Back"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text(
                                                              "Buy Using payment Slip"),
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        slipPay(),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });

                                              ///////////
                                            }

                                            /////////////////////////////////////////////////////////////
                                            /*  */
                                          },
                                          child: const Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15),
                                            child: Text('Enroll',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Consumer<CourseProvider>(
                        builder: (context, values, child) {
                          return Column(children: <Widget>[
                            for (item in values.getSection.values) Text("LL"),
                            for (var item2 in values.getItems.values)
                              if (item == item2['section_id'])
                                Consumer<CourseProvider>(
                                  builder: (context, value, child) {
                                    return Text(">>>>" + item);
                                  },
                                )
                            // if (item == item2['section_id'])
                            //   Text(
                            //       "Asasa" + item2['section_id'].toString()),
                          ]);

                          //   InkWell(
                          //     onTap: () async {
                          //       print("##################### 7777 :" +
                          //           values.getItems.toString());

                          //       print(userSearchItems.values.toSet());

                          //       firebaseFirestore
                          //           .collection('Section')
                          //           .get()
                          //           .then(
                          //         (value) {
                          //           var i = 0;
                          //           value.docs.forEach(
                          //             (result) {
                          //               print("************ : " +
                          //                   result.id.toString());

                          //               values.getItems.values.forEach((valuess) {
                          //                 if (result.id ==
                          //                     valuess['section_id']) {
                          //                   print("))))))))))))))))))))))))  : " +
                          //                       valuess['name'].toString());
                          //                 }
                          //               });

                          //               i++;
                          //             },
                          //           );
                          //         },
                          //       );
                          //     },
                          //     child: Container(
                          //       child: Text(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"),
                          //     ),
                          //   ),
                          // ],
                          // );
                        },
                      )
                    ]),
              );
            }).toList());
          }),
    );
  }
}
