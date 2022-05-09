import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:logger/logger.dart';

import '../model/user_model.dart';
import 'package:path/path.dart';

import '../screens/home.dart';
import '../utils/util_functions.dart';

class UserController {
  // Create a collection refferance
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserModel? _userModel;
  //get user data
  Future<UserModel?> getUserData(BuildContext context, String id) async {
    Logger().i("######################## : " + id.toString());
    try {
      DocumentSnapshot snapshot = await users.doc(id).get();
      Logger().i(snapshot.data());
      UserModel userModel =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      // Logger().d("@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + userModel.image);

     
      return userModel;
    } catch (e) {
      Logger().e(e);
    }
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
          'status': "0",
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<UserModel> updateUserWithImage(File img, UserModel? userModel) async {
    _userModel = userModel;
    UploadTask? task = uploadFile(img);
    final snapshot = await task!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    Logger().d("####################### : " + userModel!.uid);
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

  Future<UserModel?> updateUser(
      String fname, String lnane, String email, String phone, String uid) async{
   await  users
        .doc(uid)
        .update({
          'fname': fname,
          'lname': lnane,
          'email': email,
          'phone': phone,
         
        })
        .then((value) async{ 
          DocumentSnapshot snapshot = await users.doc(uid).get();
  
      Logger().d(snapshot.data());
      _userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
          print("User updated");
        })
        .catchError((error) => print("Failed to add user: $error"));
        return _userModel;
  }
}
