import 'package:binary_app/model/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CourseController {
  // FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // CollectionReference users =
  // FirebaseFirestore.instance.collection('users');
  // final _firestore = FirebaseFirestore.instance;

  CollectionReference course = FirebaseFirestore.instance.collection('course');

  Future<List<DocumentSnapshot>> getProduceID() async {
    var data = await FirebaseFirestore.instance.collection('Section').get();

    // var data = await FirebaseFirestore.instance
    //     .collection('course').where('type', isEqualTo: '1')
    //     // .doc("DwrBjyNabsR1u4mB2OeP")
    //     // .collection('Section').where('course_id', isEqualTo: 'DwrBjyNabsR1u4mB2OeP')
    //     .get();
    var productId = data.docs;
    Logger().d(">>>>>>>>>>>>>>>>>>>>>>>>> : " + productId.toString());
    return productId;
  }

  Future<Coursemodel> getCourseById(docid) async {
    DocumentSnapshot snapshot = await course.doc(docid).get();

    Logger().d(
        "(((((((((((((((>>>>>>>>>>>>>>>>>>>>>>>>>))))))))))))))) : " + docid);
    return Coursemodel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  CollectionReference courses = FirebaseFirestore.instance.collection('course');

  Future<Coursemodel?> getCourseData(BuildContext context, String id) async {
    DocumentSnapshot snapshot = await courses.doc(id).get();
    Logger().i(snapshot.data());
    Coursemodel coursemodel =
        Coursemodel.fromJson(snapshot.data() as Map<String, dynamic>);
    Logger().d("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + snapshot.data().toString());

    return coursemodel;
  }
}
