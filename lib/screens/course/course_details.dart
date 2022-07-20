import 'package:binary_app/provider/corse_provider.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/util_functions.dart';
import '../Payment/Slippay.dart';
import '../Payment/payment_screen.dart';
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
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var s = false;
  var val;
  TextEditingController searchcont = TextEditingController();

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
    // FocusScope.of(context).requestFocus(FocusNode());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.12,
              width: size.width,
              child: Stack(
                children: [
                  list(),
                  Positioned(
                      bottom: 0,
                      child: Consumer2<CourseProvider, UserProvider>(
                        builder: (context, value, value2, child) {
                          return Container(
                            height: 60,
                            width: size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width / 3,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                          text: "LKR ",
                                          style: TextStyle(
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
                                  Consumer<CourseProvider>(
                                    builder: (context, value, child) {
                                      return value.getPaidFoCourse == "0"
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              onPressed: () {
                                                paymetDialog(
                                                    value2.getuserModel!.fname,
                                                    context);
                                              },
                                              child: Ink(
                                                width: size.width / 2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.blue,
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(18),
                                                  child: const Text(
                                                      'Enroll Now',
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                              ),
                                            )
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Ink(
                                                width: size.width / 2,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey[400],
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(18),
                                                  child: const Text(
                                                    'Enrolled',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            );
                                    },
                                  )
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
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: const Text(
        "Course Details",
        style: TextStyle(color: Colors.black),
      ),
      leading: Container(
        margin: const EdgeInsets.all(10),
        // height: 25,
        // width: 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: const EdgeInsets.all(3),
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
            return const Center(
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

                  // initialVideoId: docReference['IntroVideo'],
                  initialVideoId:
                      YoutubePlayer.convertUrlToId(docReference['IntroVideo'])!,
                  flags: const YoutubePlayerFlags(
                    mute: false,
                    autoPlay: false,
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
                                        fontSize: 22,
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
                                    child: Text(
                                      docReference['Description'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.justify,
                                      // maxLines: 6,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
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
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Language",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                                Text(
                                  docReference['language'],
                                  style: const TextStyle(
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
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Last Update",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                ),
                                Text(
                                  docReference['updated_at'],
                                  style: const TextStyle(
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
                              color: Colors.blue,
                              border: Border.all(color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                "Course Fee " +
                                    docReference['CourseFee'] +
                                    " LKR",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
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
                            const SizedBox(
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
                                        padding: EdgeInsets.all(10.0),
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
                                        padding: EdgeInsets.all(10.0),
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
                                        padding: EdgeInsets.all(10.0),
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
                                        padding: EdgeInsets.all(10.0),
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

                          UtilFuntions.pageTransition(context,
                              const TestContent(), CourseDetails(docid: "1"));
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

  static Future<dynamic> paymetDialog(String fname, BuildContext context) {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateGreenRocket,
    );
    return popup.show(
      title: 'Hello ' + fname + " !",
      content: SizedBox(
        // height: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("You have to choose an option"),
            const Text("to pay for this course"),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PaymentType(
                  color: const Color.fromARGB(255, 23, 202, 32),
                  icon: Icons.credit_card_outlined,
                  maintext: "Online",
                  subtext: "pay",
                  onTap: () {
                    UtilFuntions.pageTransition(
                      context,
                      const PaymentScreen(),
                      CourseDetails(docid: "1"),
                    );
                  },
                ),
                PaymentType(
                  color: Colors.red,
                  icon: MaterialCommunityIcons.cloud_check_outline,
                  maintext: "Upload",
                  subtext: "bank slip",
                  onTap: () {
                    UtilFuntions.pageTransition(
                      context,
                      const slipPay(),
                      CourseDetails(docid: "1"),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        popup.button(
          label: 'Close',
          onPressed: Navigator.of(context).pop,
        ),
      ],
      // bool barrierDismissible = false,
      // Widget close,
    );
  }
}

class PaymentType extends StatelessWidget {
  const PaymentType({
    required this.color,
    required this.icon,
    required this.maintext,
    required this.subtext,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Color color;
  final IconData icon;
  final String maintext;
  final String subtext;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 135,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maintext,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtext,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
