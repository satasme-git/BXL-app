import 'package:binary_app/model/user_model.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/home.dart';
import 'package:binary_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/util_functions.dart';
import 'components/custom_loader.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      controller: usernameController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Username Here",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
      autofocus: false,
      controller: emailController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Email Here",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final passwordField = Consumer<UserProvider>(
      builder: (context, value, child) {
        return TextFormField(
          autofocus: false,
          controller: passwordController,
          textInputAction: TextInputAction.done,
          obscureText: value.isObscure,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.vpn_key),
              suffixIcon: IconButton(
                onPressed: () {
                  value.changeObscure();
                },
                icon: Icon(
                    value.isObscure ? Icons.visibility : Icons.visibility_off),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Enter Password Here",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        );
      },
    );
    final confirmpasswordField = Consumer<UserProvider>(
      builder: (context, value, child) {
        return TextFormField(
          autofocus: false,
          validator: (value) {
            if (confirmpasswordController.text != passwordController.text) {
              return "Password don't match";
            }
            return null;
          },
          controller: confirmpasswordController,
          textInputAction: TextInputAction.done,
          obscureText: value.isObscure,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.vpn_key),
              suffixIcon: IconButton(
                onPressed: () {
                  value.changeObscure();
                },
                icon: Icon(
                    value.isObscure ? Icons.visibility : Icons.visibility_off),
              ),
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              hintText: "Enter Confirm Password Here",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        );
      },
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: Color(0xff3949ab),
      child: Consumer<UserProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: CustomLoader(),
                  ),
                )
              : MaterialButton(
                  onPressed: () {
                    value.startRegister(
                      _formKey,
                      context,
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                    );
                    // signUp(emailController.text, passwordController.text);
                  },
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                );
        },
      ),
    );
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "SignUp",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: Color(0xFFECF3F9),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Welcome to",
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                color: Colors.blue[800],
                              ),
                              children: [
                                TextSpan(
                                  text: " Binary,",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900],
                                  ),
                                )
                              ]),
                        ),
                        Text(
                          "SignUp to Continue",
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Username",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                usernameField,
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Email",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                emailField,
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Password",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                passwordField,
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Confirm Password",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                confirmpasswordField,
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: loginButton,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? "),
                              GestureDetector(
                                onTap: () {
                                  UtilFuntions.pageTransition(context,
                                      const LoginScreen(), const Signup());
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => LoginScreen()));
                                },
                                child: Center(
                                  child: Text(
                                    " Signin",
                                    style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      // try {
      //   await _auth
      //       .createUserWithEmailAndPassword(email: email, password: password)
      //       .then((value) => {postDetailsToFirestore()})
      //       .catchError((e) {
      //     Logger().d(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> : " + e!.message);
      //     Fluttertoast.showToast(msg: e!.message);
      //   });
      // } on FirebaseAuthException catch (error) {
      //   switch (error.code) {
      //     case "invalid-email":
      //       errorMessage = "Your email address appears to be malformed.";
      //       break;
      //     case "wrong-password":
      //       errorMessage = "Your password is wrong.";
      //       break;
      //     case "user-not-found":
      //       errorMessage = "User with this email doesn't exist.";
      //       break;
      //     case "user-disabled":
      //       errorMessage = "User with this email has been disabled.";
      //       break;
      //     case "too-many-requests":
      //       errorMessage = "Too many requests";
      //       break;
      //     case "operation-not-allowed":
      //       errorMessage = "Signing in with Email and Password is not enabled.";
      //       break;
      //     default:
      //       errorMessage = "An undefined Error happened.";
      //   }
      //   Fluttertoast.showToast(msg: errorMessage!);
      //   print(error.code);
      // }
    }
  }

  postDetailsToFirestore() async {
    String timestamp;

    DateTime now = DateTime.now();
    String formatDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    timestamp = formatDate;
    print(timestamp);
    // calling our firestore
    // calling our user model
    // sedning these values

    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // User? user = _auth.currentUser;

    // UserModel userModel = UserModel();

    // // writing all the values
    // userModel.email = user!.email;
    // userModel.uid = user.uid;
    // userModel.userName = usernameController.text;
    // userModel.userNumber = usernameController.text;

    // await firebaseFirestore
    //     .collection("users")
    //     .doc(user.uid)
    //     .set(userModel.toMap());
    // Fluttertoast.showToast(msg: "Account created successfully :) ");
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('email', emailController.text);
    // // Navigator.pushAndRemoveUntil(
    // //     (context),
    // //     MaterialPageRoute(builder: (context) => HomeScreen()),
    // //     (route) => false);

    // UtilFuntions.pageTransitionwithremove(
    //     context, const HomeScreen(), const Signup());
  }
}
