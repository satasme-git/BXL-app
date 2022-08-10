import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../provider/corse_provider.dart';
import '../../provider/user_provider.dart';
import '../../provider/video_provider.dart';
import '../../utils/util_functions.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFECF3F9),
        appBar: AppBar(
          backgroundColor: Color(0xFFECF3F9),
          elevation: 0,
          title: const Text(
            "Notifications",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          leading: Container(
            margin: const EdgeInsets.all(10),
            // height: 25,
            // width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent),
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
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
                : Consumer3<CourseProvider, UserProvider, VideoProvider>(
                    builder: (context, value, value2, value3, child) {
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

                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.08),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        //Center(child: CircularProgressIndicator()),
                                        SizedBox(
                                          // width: size.width / 2,
                                          height: size.height / 9,
                                          child: const ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 10,
                                          bottom: 10,
                                          top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // ListTile(
                              //   title: Text(
                              //     data['VideoName'],
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: GoogleFonts.poppins(
                              //         color: Colors.black,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              //   subtitle: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         data['Duration'],
                              //         maxLines: 1,
                              //         overflow: TextOverflow.ellipsis,
                              //         style: GoogleFonts.poppins(
                              //             color: Colors.black54,
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       Text(
                              //         data['Fee'] + " LKR",
                              //         style: GoogleFonts.poppins(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //   leading: CircleAvatar(
                              //     backgroundImage: NetworkImage(data['image']),
                              //   ),
                              // ),
                            );
                          });
                    },
                  );
          },
        ));
  }
}
