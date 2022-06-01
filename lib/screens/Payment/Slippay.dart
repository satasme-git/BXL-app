import 'package:binary_app/provider/slip_provider.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/util_functions.dart';
import 'package:skeletons/skeletons.dart';

class slipPay extends StatefulWidget {
  const slipPay({Key? key}) : super(key: key);

  @override
  State<slipPay> createState() => _slipPayState();
}

class _slipPayState extends State<slipPay> {
  var carMake, carMakeModel;
  var setDefaultMake = true, setDefaultMakeModel = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer2<SlipProvider, UserProvider>(
              builder: (context, value, value2, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Hey",
                                  style: TextStyle(
                                    fontSize: 25,
                                    letterSpacing: 2,
                                    color: Colors.blue[800],
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " There,",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900],
                                      ),
                                    )
                                  ]),
                            ),
                            Text(
                              "Please upload payment slip here to \nselected course",
                              style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Select course",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('course')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) return Container();

                          if (setDefaultMake) {
                            carMake = snapshot.data!.docs[0].get('CourseName');
                            debugPrint('setDefault make: $carMake');
                          }
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                boxShadow: <BoxShadow>[
                                  //blur radius of shadow
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: DropdownButton(
                                isExpanded: true,
                                value: carMake,
                                items: snapshot.data!.docs.map((value) {
                                  String id = value.id;

                                  return DropdownMenuItem(
                                    value: value.get('CourseName'),
                                    child: Text(
                                      '${value.get('CourseName')}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (values) {
                                  value.setCurrentValue(values.toString());
                                  // debugPrint('selected onchange: $values');
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Select Image",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DottedBorder(
                      dashPattern: [8, 4],
                      strokeWidth: 0.5,
                      child: ClipRect(
                        child: Container(
                          color: Colors.grey[100],
                          child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 1,
                              child: value.getImg.path != ""
                                  ? IconButton(
                                      icon: Image.file(
                                        value.getImg,
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.fill,
                                      ),
                                      onPressed: () {
                                        value.selectImage();
                                      },
                                      iconSize: 180,
                                    )
                                  : Center(
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              value.selectImage();
                                            },
                                            icon: Image(
                                              image: AssetImage(
                                                "assets/upload1.png",
                                              ),
                                              fit: BoxFit.fill,
                                              // width: 200,
                                            ),
                                            iconSize: 160,
                                          ),
                                          // Text("Upload slip here")
                                        ],
                                      ),
                                    )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
                        value.startAddSlipData(
                            context, value2.getuserModel!.uid);
                      },
                      child: Ink(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          // gradient: const LinearGradient(
                          //     colors: [Colors.red, Colors.orange]),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          child:
                              const Text('Submit', textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    if (value.geSelectedCourse != "")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text("Upload history"),
                          list(),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget list() {
    var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Consumer2<SlipProvider,UserProvider>(
      builder: (context, value,value2, child) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("coursepay_details")
                .where('courseName', isEqualTo: value.geSelectedCourse)
                .where('uid', isEqualTo: value2.getuserModel!.uid)
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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: SizedBox(
                  height: size.height / 3,
                  child: ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return ListTile(
                          title: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.2)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Container(
                                child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Image.network(
                                      doc['img'],
                                      width: 80,
                                      //   // height: height,
                                      fit: BoxFit.fill,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;

                                        return const SkeletonAvatar(
                                          style: SkeletonAvatarStyle(
                                            width: 80,
                                            // height: double.infinity,
                                          ),
                                        );
                                      },
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(
                                    // width: 50,
                                    child: Text(
                                      doc['create_at'],
                                      // overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ));
                    }).toList(),
                  ),
                ),
              );
            });
      },
    );
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text(
      "Course payments",
      style: TextStyle(color: Colors.black54, fontSize: 15),
    ),
    leading: Container(
      margin: EdgeInsets.all(10),
      // height: 25,
      // width: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
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
