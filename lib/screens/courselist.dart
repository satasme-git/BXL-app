import 'package:binary_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/corse_provider.dart';
import '../utils/util_functions.dart';
import 'Payment/Slippay.dart';
import 'Payment/payment_screen.dart';
import 'course/course_details.dart';

class courseList extends StatefulWidget {
  const courseList({Key? key}) : super(key: key);

  @override
  _courseListState createState() => _courseListState();
}

class _courseListState extends State<courseList> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  var s = false;
  var val;
  TextEditingController searchcont = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFECF3F9),
      appBar: AppBar(
        backgroundColor: Color(0xFFECF3F9),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "All Courses",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.menu,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       _globalKey.currentState?.openDrawer();
        //     },
        //   )
        // ],
      ),
      key: _globalKey,
      // endDrawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.all(10),
      //     children: [
      //       Column(
      //         children: [
      //           DrawerHeader(
      //             child: Padding(
      //               padding: const EdgeInsets.all(12.0),
      //               child: CircleAvatar(
      //                 backgroundImage: AssetImage(
      //                   "assets/image.png",
      //                 ),
      //                 radius: 30,
      //               ),
      //             ),
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.person),
      //             title: Text(
      //               "Profile",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //             onTap: () {
      //               /*  Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => profile()));*/
      //             },
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.business_center),
      //             title: Text(
      //               "Careers",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //             onTap: () {
      //               /*  Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => profile()));*/
      //             },
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.payment),
      //             title: Text(
      //               "Payment",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //             onTap: () {
      //               /*  Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => profile()));*/
      //             },
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.home),
      //             title: Text(
      //               "About Us",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //             onTap: () {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => aboutUs()));
      //             },
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.sell),
      //             title: Text(
      //               "Refer & Earn",
      //               style: TextStyle(fontSize: 18),
      //             ),
      //             onTap: () {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => refer()));
      //             },
      //           ),
      //           Center(
      //             child: Container(
      //               decoration: BoxDecoration(
      //                   color: Colors.blue[900],
      //                   borderRadius: BorderRadius.circular(10)),
      //               child: ListTile(
      //                 leading: Icon(Icons.logout, color: Colors.white),
      //                 title: Text(
      //                   "Logout",
      //                   style: TextStyle(fontSize: 18, color: Colors.white),
      //                 ),
      //                 onTap: () async {
      //                   SharedPreferences prefs =
      //                       await SharedPreferences.getInstance();
      //                   prefs.remove('email');
      //                   FirebaseAuth.instance.signOut().then((_) {
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => LoginScreen()));
      //                   });
      //                 },
      //               ),
      //             ),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
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
                            width: 250,
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
                SizedBox(
                  height: 10,
                ),
                list(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget list() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Consumer2<CourseProvider, UserProvider>(
      builder: (context, value, value2, child) {
        //                             //////////////////// add data to CoursePaymodel

        //               Logger().d(">>>>>>>>>>>>>>>>>>>>>>>>  add data to CoursePaymodel"+value2.getuserModel!.uid);
        //             StreamBuilder(
        //               stream: FirebaseFirestore.instance
        //                   .collection("course_pay")
        //                   // .where('uid', isEqualTo: value2.getuserModel!.uid)
        //                   // .where('status', isEqualTo: 2)
        //                   .snapshots(),
        //               builder: (BuildContext context,
        //                   AsyncSnapshot<QuerySnapshot> snapshot) {
        //                          Logger().d(">>>>>>>>>>>>>>>>>>>>>>>> eror couser mdel ");
        //                 if (snapshot.hasError) {

        //                   return Text('something went wrong');

        //                 }

        //                 if (snapshot.connectionState == ConnectionState.waiting) {
        //                    Logger().d(">>>>>>>>>>>>>>>>>>>>>>>> no eror couser mdel ");
        //                   return const CustomLoader();
        //                 }
        //                 for (var item in snapshot.data!.docs) {
        //                    Logger().d(">>>>>>>>>>>>>>>>>>>>>>>> yes couser mdel ");
        //                   //mapping to a single model
        //                   CoursePaymodel model = CoursePaymodel.fromJson(
        //                       item.data() as Map<String, dynamic>);

        //                       Logger().d(">>>>>>>>>>>>>>>>>>>>>>>> fgfgfgfgfgf"+item.data().toString());
        //                   //  ading to the model
        //                   // _list.add(model);
        //                 }
        //                 return Text("adad");
        //               },
        //             );

        // //////////////////// end of add data to CoursePaymodel
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("course").snapshots(),
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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: size.height,
                  child: GridView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
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

                            if (value.getPaid == "Yes") {
                                

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
                                  const courseList());

                              value.setPayed();
                            } else {
                              final popup = BeautifulPopup(
                                context: context,
                                template: TemplateBlueRocket,
                              );
                              popup.show(
                                title: 'Hello ' +
                                    value2.getuserModel!.fname +
                                    " !",
                                content: Container(
                                  height: 300,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "You have to pay for this course",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
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
                                        shape: StadiumBorder(),
                                        highlightedBorderColor: Colors.red,
                                        borderSide: BorderSide(
                                            width: 0.6, color: Colors.red),
                                        onPressed: () {
                                          UtilFuntions.pageTransition(
                                            context,
                                            const PaymentScreen(),
                                            const courseList(),
                                          );
                                        },
                                        child: Text('Online pay'),
                                      ),
                                      Text(
                                        "Bank payment",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      OutlineButton(
                                        shape: StadiumBorder(),
                                        highlightedBorderColor: Colors.blue,
                                        borderSide: BorderSide(
                                            width: 0.6, color: Colors.black),
                                        onPressed: () {
                                          UtilFuntions.pageTransition(
                                            context,
                                            const slipPay(),
                                            const courseList(),
                                          );
                                        },
                                        child: Text('Bank pay'),
                                      ),

                                      //  Text(">>>>>>>>>>"),
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
                          },
                          child: Container(
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
                                          borderRadius: BorderRadius.only(
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
                                              if (loadingProgress == null)
                                                return child;
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
  }
}
