import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/cat_model.dart';
import '../model/corse_pay_model.dart';
import '../screens/test_content.dart';

class CourseProvider extends ChangeNotifier {
  Map<String, dynamic> userSearchItems = {};
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference course_pay =
      FirebaseFirestore.instance.collection('course_pay');

  Map<String, dynamic> get getItems => userSearchItems;

  Map<String, dynamic> section = {};
  Map<String, dynamic> get getSection => section;

  List<DataList> data = [];
  List<DataList> data2 = [];

  List<DataList> get getDataList => data;
  String price = "";
  String get getPrice => price;

  String _paid = "no";
  String get getPaid => _paid;

  List<CoursePaymodel> _list = [];

  List<CoursePaymodel> get payedCourseList => _list;

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

  Future<void> getAllPaidCourses(String uid) async {
    _list.clear();
    try {
      //query for fetch relevent products
      QuerySnapshot snapshot = await course_pay
          .where('uid', isEqualTo: uid)
          .where('status', isEqualTo: 2)
          .get();

      //querying all the docs in this snapshot
      for (var item in snapshot.docs) {
        // mapping to a single model
        CoursePaymodel model =
            CoursePaymodel.fromJson(item.data() as Map<String, dynamic>);
        //ading to the model
        _list.add(model);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void seachPayed(String val) {
    String course_Name = val;

    for (var i = 0; i < payedCourseList.length; i++) {
      String courseName = payedCourseList[i].courseName;
      if (courseName == course_Name) {
        _paid = "Yes";
      }
    }

    notifyListeners();
  }

  void setPayed() {
    _paid = "no";

    notifyListeners();
  }
}
