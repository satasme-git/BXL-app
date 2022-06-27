import 'package:binary_app/model/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../model/user_model.dart';

// import '../model/objects.dart';

class SlipController {
  final uuid = Uuid();
  String? cp_id;
    Coursemodel? coursemodel;
   CollectionReference course = FirebaseFirestore.instance.collection('course');

  CollectionReference res =
      FirebaseFirestore.instance.collection('coursepay_details');
  CollectionReference course_pay =
      FirebaseFirestore.instance.collection('course_pay');
  // FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String sp_id = "";
  Future<void> saveSlipData(
      File img, String coursename, UserModel userModel) async {
    UploadTask? task = uploadFile(img);
    final snapshot = await task!.whenComplete(() {});
    final downloadurl = await snapshot.ref.getDownloadURL();

    DateTime now = DateTime.now();
    String day = DateFormat('yyyy-MM-dd').format(now);
    //get the unique document id auto generated
    String docId = res.doc().id;


 QuerySnapshot snapshot_course = await course.where('CourseName', isEqualTo: coursename).get();

      //querying all the docs in this snapshot
      for (var item in snapshot_course.docs) {
       
        // mapping to a single model
         coursemodel = Coursemodel.fromJson(item.data() as Map<String, dynamic>);
        //ading to the model
   
      }




    // var collectionReference = FirebaseFirestore.instance
    //     .collection('corse_pay')
    //     .where('uid', isEqualTo: userModel.uid)
    //     .where('courseName', isEqualTo: coursename);

        //  QuerySnapshot corse_paysnapshot = await course_pay
        // .where('uid', isEqualTo: userModel.uid)
        //  .where('CourseName', isEqualTo: coursename)
        //  .get();

    // QuerySnapshot corse_paysnapshot = await collectionReference.get();
    cp_id = userModel.uid + "" + coursename;

    final cpdocId = uuid.v5(Uuid.NAMESPACE_URL, cp_id);


     DocumentSnapshot snapshot1 = await course_pay.doc(cpdocId).get();

    //  Logger().d(">>>>>>>>>>>>>>>>>>>>>>>>>>>  mo data: "+snapshot1.exists.toString());

    if (snapshot1.exists == false) {
     
    
      await course_pay.doc(cpdocId).set({
        'cpid': cpdocId,
        'courseName': coursename,
        'courseFee': coursemodel!.CourseFee,
        'uid': userModel.uid,
        'userName': userModel.fname + "" + userModel.lname,
        'email': userModel.email,
        'pay_amount':0,
        'create_at': day,
        'updated_at': day,
        'user': userModel.toJson(),
        'status': 1,
      }).then((value) async {
        await res.doc(docId).set({
          'cpdid': docId,
          'cpid': cpdocId,
          'courseName': coursename,
          'img': downloadurl,
          'uid': userModel.uid,
          'userName': userModel.fname + "" + userModel.lname,
          'create_at': day,
          'status': 0,
        });
      });
    } else {
      await course_pay.doc(cpdocId).update({
        'updated_at': day,
      }).then((value) async {
        await res.doc(docId).set({
          'cpdid': docId,
          'cpid': cpdocId,
          'courseName': coursename,
          'img': downloadurl,
          'uid': userModel.uid,
          'userName': userModel.fname + "" + userModel.lname,
          'create_at': day,
          'status': 0,
        });
      });
    }

    Logger().i(downloadurl);
  
  }

//upload image to th firebase
  UploadTask? uploadFile(File file) {
    try {
      final filename = basename(file.path);
      final destination = "paymentslip/$filename";
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
