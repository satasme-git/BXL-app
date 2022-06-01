import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:path/path.dart';

class SlipController {
  CollectionReference res =
      FirebaseFirestore.instance.collection('coursepay_details');
  CollectionReference course_pay =
      FirebaseFirestore.instance.collection('corse_pay');
  // FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late QueryDocumentSnapshot<Object?> sp_id;
  Future<void> saveSlipData(File img, String coursename, String uid) async {
    UploadTask? task = uploadFile(img);
    final snapshot = await task!.whenComplete(() {});
    final downloadurl = await snapshot.ref.getDownloadURL();

    DateTime now = DateTime.now();
    String day = DateFormat('yyyy-MM-dd').format(now);
    //get the unique document id auto generated
    String docId = res.doc().id;

    var collectionReference = FirebaseFirestore.instance
        .collection('corse_pay')
        .where('uid', isEqualTo: uid)
        .where('courseName', isEqualTo: coursename);

    QuerySnapshot corse_paysnapshot = await collectionReference.get();
// print(">>>>>>>>>>>>>>>>>>>>PPPPP :"+sp_id.id.toString());
    Logger()
        .d(">>>>>>>>>>>>>>>>> : " + corse_paysnapshot.docs.length.toString());
    if (corse_paysnapshot.docs.length == 0) {
      String cpdocId = course_pay.doc().id;
      await course_pay.doc(cpdocId).set({
        'cpid': cpdocId,
        'courseName': coursename,
        'uid': uid,
        'create_at': day,
        'status': 0,
      });
    }

    for (int i = 0; i < corse_paysnapshot.docs.length; i++) {
      sp_id = corse_paysnapshot.docs[i];
      sp_id.id;
      print(">>>>>>>>>>>>>>>>>>>>PPPPP :" + sp_id.id.toString());
    }


    if (sp_id.id != "") {
      await res.doc(docId).set({
        'cpdid': docId,
        'cpid': docId,
        'courseName': coursename,
        'img': downloadurl,
        'uid': uid,
        'create_at': day,
        'status': 0,
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
