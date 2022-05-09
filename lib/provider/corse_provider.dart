import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/test_content.dart';

class CourseProvider extends ChangeNotifier {
  Map<String, dynamic> userSearchItems = {};
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Map<String, dynamic> get getItems => userSearchItems;

  Map<String, dynamic> section = {};
  Map<String, dynamic> get getSection => section;

  List<DataList> data = [];
  List<DataList> data2 = [];

  List<DataList> get getDataList => data;
  String price = "";
  String get getPrice => price;

  Future<void> setPrice(String val) async {
    price = val;

    notifyListeners();
  }

  Future<void> addItems(BuildContext context) async {
    firebaseFirestore.collection('sub_section').get().then(
      (value) {
        userSearchItems = {};
        var i = 1;
        value.docs.forEach(
          (result) {
            String id = i.toString();
            userSearchItems[id] = {
              "id": result.id.toString(),
              "name": result.get('name'),
              "section_id": result.get('section_id'),
              "video_id": result.get('video_id'),
              "vid": result.get('vid'),
              "duration": result.get('duration')
            };
            notifyListeners();
            i++;
          },
        );
      },
    );
  }

  Future<void> addSection(var id) async {
    firebaseFirestore
        .collection('Section')
        .where('course_id', isEqualTo: id)
        .get()
        .then(
      (value) {
        section = {};
        var i = 1;
        value.docs.forEach(
          (result) {
            String id = i.toString();
            section[id] = {
              "id": result.id.toString(),
              "course_id": result.get('course_id'),
              "section": result.get('section')
            };

            notifyListeners();
            i++;
          },
        );
      },
    );
  }

  Future<void> loadSection() async {
    data = [];
    data2 = [];
    for (var item in getSection.values) {
      for (var item2 in getItems.values) {
        if (item['id'] == item2['section_id']) {
          data2.add(
              DataList(item2['name'], item2['video_id'], item2['duration']));
          // data2.add(DataList(item2['video_id']));
        }
      }
      data.add(DataList(
        item['section'].toString(),
        "",
        "",
        data2,
      ));
      data2 = [];
    }
  }
}
