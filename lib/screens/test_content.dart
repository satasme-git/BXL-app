import 'package:binary_app/provider/corse_provider.dart';
import 'package:binary_app/utils/util_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import 'Video/video.dart';

class TestContent extends StatefulWidget {
  const TestContent({Key? key}) : super(key: key);

  @override
  State<TestContent> createState() => _TestContentState();
}

class _TestContentState extends State<TestContent> {
  @override
  void initState() {
    // TODO: implement initState
    List<DataList> list =
        Provider.of<CourseProvider>(context, listen: false).getDataList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Consumer<CourseProvider>(
          builder: (context, value, child) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                primary: true,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    DataPopUp(value.data[index]),
                itemCount: value.data.length,
              ),
            );
          },
        ));
  }
}

class DataList {
  DataList(this.title, this.videoid, this.duration, this.status,
      [this.children = const <DataList>[]]);
  final String title;
  final String videoid;
  final String duration;
  final String status;
  final List<DataList> children;
}

class DataPopUp extends StatefulWidget {
  const DataPopUp(this.popup);
  final DataList popup;
  @override
  State<DataPopUp> createState() => _DataPopUpState();
}

class _DataPopUpState extends State<DataPopUp> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Widget _buildTiles(DataList root) {
    if (root.children.isEmpty)
      // ignore: curly_braces_in_flow_control_structures
      return ListTile(
        dense: true,
        contentPadding:
            const EdgeInsets.only(left: 40.0, right: 15.0, top: 0, bottom: 0.0),
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        selectedColor: Colors.red,
        leading: const Icon(
            MaterialCommunityIcons.checkbox_blank_circle_outline,
            size: 15,
            color: Colors.deepPurpleAccent),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                root.title,
                style: const TextStyle(height: 0.5),
                overflow: TextOverflow.ellipsis,
                 maxLines: 1,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Text(
                    "duration :",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    root.duration,
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Consumer<UserProvider>(
          builder: (context, value, child) {
            return InkWell(
              onTap: () {
                root.status == "0"
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => videoplay(Linkid: root.videoid),
                        ),
                      )
                    : UtilFuntions.paymetDialog(
                        value.getuserModel!.fname, context);

                // UtilFuntions().paymetDialog(value,context);
              },
              child: root.status == "0"
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[300]),
                      child: const Icon(MaterialCommunityIcons.video_check,
                          size: 15, color: Colors.deepPurpleAccent),
                    )
                  : Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[300]),
                      child: const Icon(MaterialCommunityIcons.video_3d_off,
                          size: 15, color: Colors.grey),
                    ),
            );
          },
        ),
      );
    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        initiallyExpanded: true,
        key: PageStorageKey<DataList>(root),
        title: SizedBox(
          child: Text(
            root.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        children: root.children.map(_buildTiles).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.popup);
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: const Text(
      "Course Content",
      style: TextStyle(color: Colors.black, fontSize: 16),
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
