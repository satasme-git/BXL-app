import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../provider/corse_provider.dart';
import '../../provider/user_provider.dart';
import '../../utils/util_functions.dart';
import 'course_details.dart';

class SeachPage extends StatefulWidget {
  const SeachPage({Key? key}) : super(key: key);

  @override
  State<SeachPage> createState() => _SeachPageState();
}

class _SeachPageState extends State<SeachPage> {
  String name = "";
  TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot> getUserPasTripSreamSnapshots(
      BuildContext context) async* {
    final uid = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              MaterialCommunityIcons.chevron_left,
              size: 30,
            ),
            color: Colors.white,
          ),
          backgroundColor: HexColor("#283890"),
          elevation: 5,
          title: Container(
            height: 38,
            child: TextField(
              autofocus: true,
              cursorColor: Colors.black,
              maxLines: 1,
              style: TextStyle(fontSize: 17),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context).iconTheme.color),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                hintText: 'Search....',
              ),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('course').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer2<CourseProvider, UserProvider>(
                    builder: (context, value, value2, child) {
                      return ListView.builder(
                          // separatorBuilder: (context, index) {
                          //   return Divider(
                          //     color: Colors.grey[300],
                          //     // thickness: 0,
                          //   );
                          // },
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;
                            var doc_id = snapshots.data!.docs[index].id;

                            if (name.isEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  UtilFuntions.pageTransition(
                                    context,
                                    CourseDetails(
                                      docid: doc_id,
                                    ),
                                    const SeachPage(),
                                  );
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: ListTile(
                                  title: Text(
                                    data['CourseName'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['duration'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        data['instructor'],
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
                                        data['CourseFee'] + " LKR",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['image']),
                                  ),
                                ),
                              );
                            }
                            if (data['CourseName']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase())) {
                              return GestureDetector(
                                onTap: () {
                                  UtilFuntions.pageTransition(
                                    context,
                                    CourseDetails(
                                      docid: doc_id,
                                    ),
                                    const SeachPage(),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    data['CourseName'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['duration'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        data['instructor'],
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
                                        data['CourseFee'] + " LKR",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['image']),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          });
                    },
                  );
          },
        ));
  }
}
