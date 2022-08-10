import 'package:binary_app/provider/slip_provider.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/provider/video_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../utils/util_functions.dart';
import '../components/custom_loader.dart';

class SlipPayVideo extends StatefulWidget {
  const SlipPayVideo({Key? key}) : super(key: key);

  @override
  State<SlipPayVideo> createState() => _SlipPayVideoState();
}

class _SlipPayVideoState extends State<SlipPayVideo> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [];
  var setDefaultMake = true, setDefaultMakeModel = true;
  var carMake, carMakeModel;
  String? selectedLocation;
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
            child: Consumer3<SlipProvider, UserProvider, VideoProvider>(
              builder: (context, value1, value2, value3, child) {
                return AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      // crossAxisAlignment: CrossAxisAlignment.start,
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
                                          text:
                                              " ${value2.getuserModel.fname},",
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
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Video name",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Consumer<VideoProvider>(
                          builder: (context, value, child) {
                            return Text(
                              value.getvideoModel!.VideoName,
                              style: TextStyle(color: Colors.black),
                            );
                          },
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Center(
                        //   child: StreamBuilder<QuerySnapshot>(
                        //     stream: FirebaseFirestore.instance
                        //         .collection('course')
                        //         .snapshots(),
                        //     builder: (BuildContext context,
                        //         AsyncSnapshot<QuerySnapshot> snapshot) {
                        //       if (!snapshot.hasData) return Container();

                        //       if (setDefaultMake) {
                        //         carMake =
                        //             snapshot.data!.docs[0].get('CourseName');
                        //         // debugPrint('setDefault make: $carMake');
                        //       }
                        //       return DecoratedBox(
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(5),
                        //             border: Border.all(
                        //                 color: Colors.grey, width: 0.5),
                        //             boxShadow: const <BoxShadow>[
                        //               //blur radius of shadow
                        //             ]),
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 15),
                        //           child: DropdownButton(
                        //             isExpanded: true,
                        //             isDense: false,
                        //             value: carMake,
                        //             items: snapshot.data!.docs.map((value) {
                        //               String id = value.id;

                        //               return DropdownMenuItem(
                        //                 value: value.get('CourseName'),
                        //                 child: Text(
                        //                   '${value.get('CourseName')}',
                        //                   overflow: TextOverflow.ellipsis,
                        //                 ),
                        //               );
                        //             }).toList(),
                        //             onChanged: (values) {
                        //               value1.setCurrentValue(values.toString());
                        //               setState(() {
                        //                 carMake = values.toString();
                        //                 setDefaultMake = false;
                        //               });

                        //               // debugPrint('selected onchange: $values');
                        //             },
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        const Text(
                          "Select Image",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            DottedBorder(
                              dashPattern: const [8, 4],
                              strokeWidth: 0.5,
                              child: ClipRect(
                                child: Container(
                                  color: Colors.grey[100],
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      heightFactor: 1,
                                      child: value1.getImg.path != ""
                                          ? IconButton(
                                              icon: Image.file(
                                                value1.getImg,
                                                width: double.infinity,
                                                height: 180,
                                                fit: BoxFit.fill,
                                              ),
                                              onPressed: () {
                                                value1.selectImage();
                                              },
                                              iconSize: 180,
                                            )
                                          : Center(
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      value1.selectImage();
                                                    },
                                                    icon: const Image(
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
                            Positioned(
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    value1.clearImagePicker();
                                  },
                                  child: Container(
                                    child: const Icon(Icons.close),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        value1.isLoading
                            ? Container(
                                height: 48,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: CustomLoader(loadertype: false),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0.0),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  value1.startAddSlipDataforVideo(
                                      context,
                                      value2.getuserModel,
                                      value3.getvideoModel!);
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
                                    child: const Text('Submit',
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                        if (value1.geSelectedCourse != "")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 30,
                              ),
                              // Text("Upload history"),
                              // list(),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: const Text(
      "Video payments",
      style: TextStyle(color: Colors.black54, fontSize: 15),
    ),
    leading: Container(
      margin: const EdgeInsets.all(10),
      // height: 25,
      // width: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
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
