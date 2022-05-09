import 'dart:io';
import 'package:binary_app/model/user_model.dart';
import 'package:binary_app/screens/Chat/chatHome.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:binary_app/screens/Chat/chatScreen.dart';
import 'package:binary_app/screens/Content.dart';
import 'package:binary_app/screens/Refer/refer.dart';
import 'package:binary_app/screens/Video/Videolist.dart';
import 'package:binary_app/screens/aboutus/aboutus.dart';
import 'package:binary_app/screens/courselist.dart';
import 'package:binary_app/screens/Video/video.dart';
import 'package:binary_app/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

import '../provider/corse_provider.dart';
import '../provider/user_provider.dart';
import '../utils/util_functions.dart';
import 'components/custom_drawer.dart';
import 'course/course_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }*/

  /*@override
  initState() {
    super.initState();
    // secureScreen();
  }*/

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var s = false;
  var val;
  TextEditingController searchcont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
          backgroundColor: Color(0xFFECF3F9),
          //backgroundColor: Colors.lightBlue[50],
          /*         floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => chatScreen()));

                // Add your onPressed code here!
              },
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.message)),*/
          appBar: AppBar(
            backgroundColor: HexColor("#283890"),
            elevation: 0,

            /* leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _globalKey.currentState?.openDrawer();
                }),*/
          ),
          key: _globalKey,
          endDrawer: CustomDrawer(),
          endDrawerEnableOpenDragGesture: true,
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    if (FirebaseAuth.instance.currentUser != null) Name(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
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
                                    s = true;
                                    val = searchcont.text;
                                  });
                                },
                                icon: Icon(
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
                                child: TextField(
                                    controller: searchcont,
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
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.blue,
                                  )),
                            )
                          }
                        ],
                      ),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * 0.175,
                // width: double.infinity,
                decoration: BoxDecoration(
                  //  image: DecorationImage(
                  //alignment: Alignment.topCenter,
                  // image: AssetImage('Assets/Images/Header.png'),
                  // fit: BoxFit.cover),
                  color: HexColor("#283890"),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                  /*  boxShadow: [
                          BoxShadow(
                            color: Color(0xAA6EB1E6),
                            offset: Offset(9, 9),
                            blurRadius: 6,
                          ),
                        ],*/
                ),
                alignment: Alignment.center,
              ),
              if (s == false) ...{
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CardTitle(
                        title: "Corse",
                      ),
                      CardTitle(
                        title: "Videos",
                      ),
                      CardTitle(
                        title: "Marketing",
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Populer Courses",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                /*  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                    ),
                  ])),*/
                SizedBox(height: 245, child: course()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Programs",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            UtilFuntions.pageTransition(context,
                                const courseList(), const HomeScreen());
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => courseList(),
                            //   ),
                            // );
                          },
                          child: Container(
                            width: size.width / 2.2,
                            height: 140,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white,
                                    // Color(0xff0d47a1),
                                    // Color(0xff2196f3),
                                  ],
                                  begin: FractionalOffset(1.0, 1.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.book_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: const [
                                            Text(
                                              "Courses",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              "10+ Courses",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 95, 95, 95),
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          MaterialCommunityIcons
                                              .arrow_right_circle,
                                          size: 30,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            UtilFuntions.pageTransition(
                                context, const Videolist(), const HomeScreen());
                            // UtilFuntions.pageTransition(context,
                            //         const Videolist(), const HomeScreen());
                          },
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue[300],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: const [
                                            Text(
                                              "Videos",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              "20+ Videos",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 95, 95, 95),
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          MaterialCommunityIcons
                                              .arrow_right_circle,
                                          size: 30,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            width: size.width / 2.2,
                            height: 140,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                              gradient: const LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white
                                    // Color(0xff0d47a1),
                                    // Color(0xff2196f3),
                                  ],
                                  begin: FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, left: 12, right: 12, bottom: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#F59300"),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 15),
                                child: Text(
                                  "Refer and earn",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Text(
                                  "Refer your friend",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "and win cryptocoins",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 20),
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => refer()));
                                    },
                                    child: Text(
                                      "Refer Now",
                                      style:
                                          TextStyle(color: Colors.amber[700]),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(width: 85),
                        Expanded(
                            child: Image.asset('assets/referal.png',
                                width: 60, height: 60))
                      ],
                    ),
                    width: double.infinity,
                    height: 180,
                  ),
                ),
                ///////////////////////////////////////////////////
                ///
              } else ...{
                Search()
              }
            ],
          ))),
    );
  }

  Widget course() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("course").snapshots(),
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
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((docReference) {
                String id = docReference.id;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      // padding: EdgeInsets.only(left: 30),
                      width: 260,
                      // height: 120,
                      // color: Colors.amber,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<CourseProvider>(context,
                                      listen: false)
                                  .addItems(context);
                              Provider.of<CourseProvider>(context,
                                      listen: false)
                                  .addSection(docReference.id);

                              Provider.of<CourseProvider>(context,
                                      listen: false)
                                  .setPrice(docReference['CourseFee']);
                              UtilFuntions.pageTransition(
                                context,
                                CourseDetails(
                                  docid: docReference.id,
                                ),
                                const HomeScreen(),
                              );
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => CourseDetails(
                              //               docid: docReference.id,
                              //             )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                docReference['image'],
                                width: 260,
                                //   // height: height,
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;

                                  return const SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  );
                                },

                                // docReference['image'],
                                // loadingBuilder: (BuildContext context,
                                //     Widget child,
                                //     ImageChunkEvent? loadingProgress) {
                                //   if (loadingProgress == null) return child;
                                //   return Center(
                                //     child: CircularProgressIndicator(
                                //       value:
                                //           loadingProgress.expectedTotalBytes !=
                                //                   null
                                //               ? loadingProgress
                                //                       .cumulativeBytesLoaded /
                                //                   loadingProgress
                                //                       .expectedTotalBytes!
                                //               : null,
                                //     ),
                                //   );
                                // },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 79,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  docReference['duration'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 115,
                              width: 260,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 236,
                                          height: 35,
                                          child: Text(
                                            docReference['CourseName'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          docReference['instructor'],
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        ),
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 15,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(
                                          "LKR  " + docReference['CourseFee'],
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList());
        });
  }

  Widget Name() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(""),
            );
            //  Center(child: LoadingFilling.square());
          }
          return SizedBox(
            height: 80,
            child: ListView(
              children: snapshot.data!.docs.map((docReference) {
                String id = docReference.id;
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 2,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Welcome ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.amber,
                                  fontSize: 25,
                                ),
                              ),
                              TextSpan(
                                text: docReference['fname'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                          ),
                          Text(
                            "What you want to learn today",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Color.fromARGB(255, 209, 208, 208)),
                          ),
                        ],
                      ),
                      Consumer<UserProvider>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5, right: 20.0),
                            child: value.getuserModel!.image == "null"
                                ? CircleAvatar(
                                    radius: 22,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(55),
                                      child: Image.asset(
                                        "assets/avatar.jpg",
                                      ),
                                      //  Image.asset(value.getImageFile!.path),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 22.0,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        "${value.getuserModel!.image}",
                                      ),
                                      radius: 21,
                                    ),
                                  ),
                          );
                        },
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  Widget Search() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("course")
            .where('CourseName', isEqualTo: val)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("No files"),
            );
            //  Center(child: LoadingFilling.square());
          }
          return SizedBox(
            height: 200,
            child: ListView(
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
                                builder: (context) => courseDetails(
                                      docid: docReference.id,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /* CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  'https://www.iconbunny.com/icons/media/catalog/product/1/2/120.9-teacher-i-icon-iconbunny.jpg'),
                                            ),*/

                                Image.asset("assets/course.png",
                                    width: 234, height: 112),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            docReference['CourseName'],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              docReference['CourseFee'] +
                                                  " LKR",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                                /*  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
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
                                                                  builder: (context) =>
                                                                      courseDetails(
                                                                        docid:
                                                                            docReference
                                                                                .id,
                                                                      )));
                                                          print(docReference.id);
                                                        },
                                                        child: Text('View Details'),
                                                      )),
                                                ),
                                              ],
                                            )*/
                              ]),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: ListView(
//       padding: EdgeInsets.all(10),
//       children: [
//         Column(
//           children: [
//             DrawerHeader(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage(
//                         "assets/image.png",
//                       ),
//                       radius: 30,
//                     ),
//                   ),
//                   Text("Celvin",
//                       style: TextStyle(
//                           fontSize: 23, fontWeight: FontWeight.w600)),
//                   Text("Edit Profile",
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w600)),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading:
//                   Icon(MaterialCommunityIcons.home_outline, size: 28),
//               title: Text(
//                 "Home",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 /*  Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => profile()));*/
//               },
//             ),
//             ListTile(
//               leading:
//                   Icon(MaterialCommunityIcons.account_outline, size: 28),
//               title: Text(
//                 "Profile",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 /*  Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => profile()));*/
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                   MaterialCommunityIcons.briefcase_variant_outline,
//                   size: 26),
//               title: Text(
//                 "Careers",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 /*  Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => profile()));*/
//               },
//             ),
//             ListTile(
//               leading: Icon(MaterialCommunityIcons.credit_card_outline,
//                   size: 27),
//               title: Text(
//                 "Payment",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => PaymentScreen()));
//               },
//             ),
//             ListTile(
//               leading:
//                   Icon(MaterialCommunityIcons.message_outline, size: 26),
//               title: Text(
//                 "Chat",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => chatHome()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.home, size: 30),
//               title: Text(
//                 "About Us",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => aboutUs()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.sell, size: 30),
//               title: Text(
//                 "Refer & Earn",
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => refer()));
//               },
//             ),
//             Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue[900],
//                     borderRadius: BorderRadius.circular(10)),
//                 child: ListTile(
//                   title: Text(
//                     "Logout",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                   onTap: () async {
//                     SharedPreferences prefs =
//                         await SharedPreferences.getInstance();
//                     prefs.remove('email');
//                     prefs.remove('time');
//                     FirebaseAuth.instance.signOut().then((_) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()));
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     ));
//   }
// }

class CardTitle extends StatelessWidget {
  const CardTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 110,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blueAccent,
              width: 0.8,
            ),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}