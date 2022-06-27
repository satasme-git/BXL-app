import 'package:binary_app/screens/Video/search_video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../provider/corse_provider.dart';
import '../../provider/user_provider.dart';
import '../../utils/util_functions.dart';
import '../components/custom_loader.dart';

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
        backgroundColor: const Color(0xFFECF3F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFECF3F9),
          elevation: 0,
          title: const Text(
            "All Videossss",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              MaterialCommunityIcons.chevron_left,
              size: 30,
            ),
            color: Colors.black,
          ),
        ),
        body: Consumer<CourseProvider>(
          builder: (context, value, child) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        height: 42,
                        child: TextField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 17),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.search,
                                color: Theme.of(context).iconTheme.color),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Search....',
                          ),
                          onTap: () {
                            UtilFuntions.pageTransition(context,
                                const SearchVideo(), const Videolist());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    value.isLoading? const CustomLoader():const SizedBox(),
                    Vlist(),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget Vlist() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("videoLecture").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
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
                  padding: const EdgeInsets.only(bottom: 170),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: snapshot.data!.docs.map((docReference) {
                    var coursePrice = NumberFormat("###.00#", "en_US");
                    String price =
                        coursePrice.format(double.parse(docReference['Fee']));

                    String id = docReference.id;
                    return Consumer2<CourseProvider, UserProvider>(
                      builder: (context, value, value2, child) {
                        return GestureDetector(
                          onTap: () {
                            isPaied(docReference.id, docReference['vid'],
                                docReference['corse_id'], value, value2);

                            // if (docReference['Fee'] != 'free') {
                            //   showDialog(
                            //     context: context,
                            //     builder: (context) => AlertDialog(
                            //       title: const Text(
                            //           "You haven't paid for this course"),
                            //       content: const Text(''),
                            //       actions: [
                            //         ElevatedButton(
                            //             onPressed: () {
                            //               Navigator.pop(context);
                            //             },
                            //             child: const Text('Go Back')),
                            //         ElevatedButton(
                            //             onPressed: () {
                            //               // Navigator.pop(context);
                            //             },
                            //             child: const Text('Pay now'))
                            //       ],
                            //     ),
                            //   );
                            // } else {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => Videos(
                            //                 docid: docReference.id,
                            //               )));
                            // }
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
                                      child: SizedBox(
                                        // width: 260,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          child: Image.network(
                                            docReference['image'],

                                            //   // height: height,
                                            fit: BoxFit.fill,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }

                                              return const SkeletonAvatar(
                                                style: SkeletonAvatarStyle(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                              );
                                            },
                                          ),
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
                                      Text(
                                        docReference['VideoName'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 12,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                      Text(
                                        "Rs ${price.toString()}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList()),
            ),
          );
        });
  }

  void isPaied(String id, String vid, String courseid, CourseProvider value,
      UserProvider value2) async {

    await value.getcoursebyid(courseid, vid, value2.getuserModel, context);
  }
}
