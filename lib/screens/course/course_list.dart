import 'package:binary_app/provider/corse_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../provider/user_provider.dart';
import '../../utils/util_functions.dart';
import '../Payment/Slippay.dart';
import '../Payment/payment_screen.dart';
import '../courselist.dart';
import 'course_details.dart';

class CourseList extends StatefulWidget {
  const CourseList({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var s = false;
  var val;
  TextEditingController searchcont = TextEditingController();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final YoutubePlayerController _controller = YoutubePlayerController(
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
          list(),
        ],
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
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    var consumer2 = Consumer2<CourseProvider, UserProvider>(
      builder: (context, value, value2, child) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("course").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    /*    child: SpinKitRing(
                  color: Colors.blue,
                )*/
                    );
                //  Center(child: LoadingFilling.square());
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: size.height,
                  child: GridView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: (1 / 1.22),
                      ),
                      children: snapshot.data!.docs.map((docReference) {
                        String id = docReference.id;

                        return GestureDetector(
                          onTap: () {
                            //   Provider.of<CourseProvider>(context, listen: false)
                            // .getAllPaidCourses(value2.getuserModel!.uid);

                            value.seachPayed(docReference['CourseName']);

                            // if (value.getPaid == "Yes") {
                              isPaied(docReference.id,
                                  docReference['CourseFee'], value);
                            // } else {
                            //   paymetDialog(value2, context);
                            // }
                          },
                          child: SizedBox(
                            height: 250,
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
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          // child: Image.asset(
                                          //   "assets/course.jpg",
                                          //   fit: BoxFit.fill,
                                          // ),
                                          child: Image.network(
                                            docReference['image'],
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                ),
              );
            });
      },
    );
    return consumer2;
  }

  void isPaied(String id, String cousreName, CourseProvider value) {
    Provider.of<CourseProvider>(context, listen: false).addItems(context);
    Provider.of<CourseProvider>(context, listen: false).addSection(id);
    Provider.of<CourseProvider>(context, listen: false).setPrice(cousreName);

    UtilFuntions.pageTransition(
        context,
        CourseDetails(
          docid: id,
        ),
        const courseList());


  }

  Future<dynamic> paymetDialog(UserProvider value2, BuildContext context) {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateBlueRocket,
    );
    return popup.show(
      title: 'Hello ' + value2.getuserModel!.fname + " !",
      content: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You have to pay for this course",
              style: GoogleFonts.poppins(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Online payment",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            OutlineButton(
              shape: const StadiumBorder(),
              highlightedBorderColor: Colors.red,
              borderSide: const BorderSide(width: 0.6, color: Colors.red),
              onPressed: () {
                UtilFuntions.pageTransition(
                  context,
                  const PaymentScreen(),
                  const courseList(),
                );
              },
              child: const Text('Online pay'),
            ),
            Text(
              "Bank payment",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            OutlineButton(
              shape: const StadiumBorder(),
              highlightedBorderColor: Colors.blue,
              borderSide: const BorderSide(width: 0.6, color: Colors.black),
              onPressed: () {
                UtilFuntions.pageTransition(
                  context,
                  const slipPay(),
                  const courseList(),
                );
              },
              child: const Text('Bank pay'),
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

    );
  }
}
