import 'dart:convert';

import 'package:binary_app/model/user_model.dart';
import 'package:binary_app/screens/home.dart';

import 'package:binary_app/screens/startPage/startpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/user_controller.dart';
import '../screens/login.dart';
import '../utils/util_functions.dart';
import 'dart:io';

import 'corse_provider.dart';

class UserProvider extends ChangeNotifier {
  // final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  UserModel? _userModel;
  //user controller object
  UserModel? get getuserModel => _userModel;
  final UserController _usercontroller = UserController();
  bool _isLoading = false;
  //get loading state
  bool get isLoading => _isLoading;

  //show hide password text
  bool _isObscure = true;
  //get obscure state
  bool get isObscure => _isObscure;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  XFile? get getImageFile => _imageFile;

  File _image = File("");

  final fname = TextEditingController();
  TextEditingController get fnameController => fname;
  final lname = TextEditingController();
  TextEditingController get lnameController => lname;
  final email = TextEditingController();
  TextEditingController get emailController => email;
  final phone = TextEditingController();
  TextEditingController get phoneController => phone;

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source:source// ImageSource.gallery,
    );

    _imageFile = pickedFile;
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage();
      notifyListeners();
    } else {
      Logger().e("no image selected");
    }

    notifyListeners();
  }

  Future<void> uploadImage() async {
    UserModel _usermodel =
        await _usercontroller.updateUserWithImage(_image, _userModel);
    _userModel = _usermodel;
    notifyListeners();
  }

  //change obscure state
  void changeObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  //initialize and check whther the user signed in or not
  void initializeUser(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {

      
      if (user == null) {
        Logger().i('User is currently signed out!');
        UtilFuntions.navigateTo(context, const getStarted());
      } else {
        Logger().i('User is signed in!' + user.uid);
        await fetchSingleUser(context, user.uid).then((value) => {
              UtilFuntions.navigateTo(context, const HomeScreen()),
            });
      }
    });
  }

  Future<void> fetchSingleUser(BuildContext context, String id) async {
    
     Provider.of<CourseProvider>(context, listen: false).getAllPaidCourses(id);

    _userModel = await _usercontroller.getUserData(context, id);
    fname.text=_userModel!.fname;
    lname.text=_userModel!.lname;
    email.text=_userModel!.email;
    phone.text=_userModel!.phone;

    notifyListeners();
  }



  //login function
  Future<void> startLogin(
    GlobalKey<FormState> _formKey,
    BuildContext context,
    String email,
    String password,
  ) async {
    if (_formKey.currentState!.validate()) {
      try {
        setLoading(true);
        // ignore: unused_local_variable
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Fluttertoast.showToast(msg: "Login Successful");
        var time = Timestamp.now().toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('time', time);

        setLoading();
        UtilFuntions.pageTransitionwithremove(
          context,
          const HomeScreen(),
          const LoginScreen(),
        );
      } on FirebaseAuthException catch (e) {
        setLoading();
        if (e.code == 'user-not-found') {
          print('No user found for the email.');
          Fluttertoast.showToast(msg: 'No user found for the email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
        }
      }
    } else {
      setLoading();
    }
  }

  //change loading state
  void setLoading([bool val = false]) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> UpdateUser(BuildContext context, GlobalKey<FormState> _formKey, String uid) async {

    _userModel = await _usercontroller.updateUser(context,
        fname.text, lname.text, email.text, phone.text, uid);
        // await _auth.r
    notifyListeners();
  }
}
