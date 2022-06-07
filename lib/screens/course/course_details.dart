import 'package:binary_app/controller/course_controller.dart';
import 'package:binary_app/provider/corse_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/util_functions.dart';
import '../Payment/payment_screen.dart';
import '../components/custom_loader.dart';
import '../courselist.dart';
import '../test_content.dart';

class CourseDetails extends StatefulWidget {
  String docid;

  CourseDetails({
    required this.docid,
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var s = false;
  var val;
  TextEditingController searchcont = new TextEditingController();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: "",
  );
  @override
  void initState() {
    _controller.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
            height: size.height / 1.12,
            width: size.width,
            child: Stack(
              children: [
                // Center(
                //   child: Container(
                //     child:  CustomLoader(),
                //   ),
                // ),
                list(),
                Positioned(
                    bottom: 0,
                    child: Consumer<CourseProvider>(
                      builder: (context, value, child) {
                        return Container(
                          height: 60,
                          width: size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: size.width / 3,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      const TextSpan(
                                        text: "LKR ",
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 87, 87, 87),
                                          fontSize: 22,
                                        ),
                                      ),
                                      TextSpan(
                                        text: value.getPrice,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0.0),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () {
                                    UtilFuntions.navigateTo(
                                        context, const PaymentScreen());
                                         _controller.pause();
                                  },
                                  child: Ink(
                                    width: size.width / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blue,
                                      // gradient: const LinearGradient(
                                      //     colors: [Colors.red, Colors.orange]),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(18),
                                      child: const Text('Enroll Now',
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        "Course Details",
        style: TextStyle(color: Colors.black),
      ),
      leading: Container(
        margin: EdgeInsets.all(10),
        // height: 25,
        // width: 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(3),
              icon: const Icon(
                MaterialCommunityIcons.chevron_left,
                size: 30,
              ),
              color: Colors.black,
              onPressed: () {
                UtilFuntions.goBack(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
    );
  }

  Widget list() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("course")
            .doc(widget.docid)
            .collection("Details")
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
          return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data!.docs.map((docReference) {
                _controller = YoutubePlayerController(
                  // initialVideoId: _ids.first,

                  initialVideoId: docReference['IntroVideo'],
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

                return Column(
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
                      InkWell(
                        onTap: () {
                          Provider.of<CourseProvider>(context, listen: false)
                              .loadSection();

                          UtilFuntions.pageTransition(context, TestContent(),
                              CourseDetails(docid: "1"));
                              _controller.pause();
                        },
                        child: Padding(
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
                                  "View course content ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                    ]);
              }).toList());
        });
  }
}
