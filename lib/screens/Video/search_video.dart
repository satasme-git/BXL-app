import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../provider/corse_provider.dart';
import '../../provider/user_provider.dart';

class SearchVideo extends StatefulWidget {
  const SearchVideo({Key? key}) : super(key: key);

  @override
  State<SearchVideo> createState() => _SearchVideoState();
}

class _SearchVideoState extends State<SearchVideo> {
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
            icon: Icon(
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
                border: OutlineInputBorder(
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
          stream:
              FirebaseFirestore.instance.collection('videoLecture').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer2<CourseProvider, UserProvider>(
                    builder: (context, value, value2, child) {
                      return ListView.builder(
                          // separatorBuilder: (context, index) {
                          //   return Divider(
                          //     color: Colors.grey[300],
                          //     thickness: 5,
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
                                  if (data['Fee'] != 'free') {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                            "You haven't paid for this course"),
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
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Videos(
                                    //               docid: docReference.id,
                                    //             )));
                                  }

                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: ListTile(
                                  title: Text(
                                    data['VideoName'],
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
                                        data['Duration'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        data['Fee'] + " LKR",
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
                            if (data['VideoName']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase())) {
                              return ListTile(
                                title: Text(
                                  data['VideoName'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['Duration'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Text(
                                    //   data['instructor'],
                                    //   style: const TextStyle(
                                    //     fontSize: 10,
                                    //     color: Colors.black,
                                    //   ),
                                    // ),
                                    // RatingBar.builder(
                                    //   initialRating: 3,
                                    //   minRating: 1,
                                    //   direction: Axis.horizontal,
                                    //   allowHalfRating: true,
                                    //   itemCount: 5,
                                    //   itemSize: 15,
                                    //   itemPadding: const EdgeInsets.symmetric(
                                    //       horizontal: 0.0),
                                    //   itemBuilder: (context, _) => const Icon(
                                    //     Icons.star,
                                    //     color: Colors.amber,
                                    //   ),
                                    //   onRatingUpdate: (rating) {
                                    //     print(rating);
                                    //   },
                                    // ),
                                    Text(
                                      data['Fee'] + " LKR",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['image']),
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
