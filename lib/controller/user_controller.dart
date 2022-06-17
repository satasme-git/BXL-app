import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// import '../model/objects.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';
import '../screens/components/custom_dialog.dart';

class UserController {
  // Create a collection refferance
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');
  UserModel _userModel = new UserModel("", "", "", "", "", "", "", "");
  //get user data
  Future<UserModel?> getUserData(BuildContext context, String id) async {
    Logger().i("######################## : " + id.toString());
    // try {
    DocumentSnapshot snapshot = await users.doc(id).get();
    Logger().i(snapshot.data());
    UserModel userModel =
        UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    Logger().d("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + snapshot.data().toString());

    return userModel;
    // } catch (e) {
    //   Logger().e(e);
    // }
  }

  // Save user information
  Future<void> saveUserData(
    String name,
    String email,
    String uid,
  ) {
    return users
        .doc(uid)
        .set({
          'fname': name,
          'lname': "",
          'email': email,
          'uid': uid,
          'phone': "",
          'image': "null",
          'token': "",
          'status': "0",
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<UserModel> updateUserWithImage(File img, UserModel? userModel) async {
    _userModel = userModel!;
    UploadTask? task = uploadFile(img);
    final snapshot = await task!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    Logger().d("####################### : " + userModel.uid);
    await users.doc(userModel.uid).update({
      'email': userModel.email,
      'fname': userModel.fname,
      'lname': userModel.lname,
      'uid': userModel.uid,
      'image': downloadUrl,
    }).then((value) async {
      DocumentSnapshot snapshot = await users.doc(userModel!.uid).get();
      // result = 1;
      Logger().d(snapshot.data());
      userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    });
    return userModel!;
  }

  UploadTask? uploadFile(File file) {
    try {
      final fileName = basename(file.path);
      final destination = 'Users/$fileName';
      final user = FirebaseStorage.instance.ref(destination);

      Logger().i("******************** : " + destination);

      return user.putFile(file);
    } catch (e) {
      Logger().i(e);
      return null;
    }
  }

  Future<UserModel?> updateUser(BuildContext context, String fname,
      String lnane, String email, String phone, String uid) async {
    Provider.of<UserProvider>(context, listen: false).setLoading(true);
    await users.doc(uid).update({
      'fname': fname,
      'lname': lnane,
      'email': email,
      'phone': phone,
    }).then((value) async {
      DocumentSnapshot snapshot = await users.doc(uid).get();

      Logger().d(snapshot.data());
      _userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      print("User updated");

      DialogBox().dialogBox(
        context,
        DialogType.SUCCES,
        'SUCCESS',
        'Profile updated',
      );
      Provider.of<UserProvider>(context, listen: false).setLoading();
    }).catchError((error) => print("Failed to add user: $error"));
    Provider.of<UserProvider>(context, listen: false).setLoading();
    return _userModel;
  }

  Future<void> addUserToConv(BuildContext context, UserModel? userModel) async {
    bool isContained = false;
    var docid = "l5rpAUCIXQiBHOHq7tJl";

    var abc = await FirebaseFirestore.instance
        .collection("conversations")
        .where('id', isEqualTo: docid)
        .where("users", arrayContains: userModel!.uid)
        .get();

    for (var item in abc.docs) {
      isContained = true;
    }

    Logger().wtf("********************* : "+abc.docs.length.toString());
    if (isContained == false) {
      await conversations
          .doc(docid)
          .update({
            // "userArray": FieldValue.arrayUnion([userModel!.toJson]),
            "users": FieldValue.arrayUnion([userModel.uid]),
            "userArray": FieldValue.arrayUnion([userModel.toJson()])
          })
          .then((value) {})
          .then((value) => print("conversation Added"))
          .catchError((error) => print("Failed to add conversation: $error"));
    }
  }
}
