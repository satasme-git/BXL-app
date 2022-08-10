import 'package:animate_do/animate_do.dart';
import 'package:binary_app/provider/registraion_provider.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/constatnt.dart';
import '../utils/util_functions.dart';
import 'components/custom_loader.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<UserProvider>(context, listen: false).gelLastId(context);

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
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
                FadeInRight(
                  child: Padding(
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
                ),
                SizedBox(
                  height: 40,
                ),
                FadeInUp(
                  child: Consumer<RegistrationProvider>(
                    builder: (context, value, child) {
                      return Container(
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
                                customTextField(
                                    MaterialCommunityIcons.account_outline,
                                    "Username",
                                    "Username",
                                    false,
                                    false,
                                    value.usernameController, (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter username");
                                  }

                                  // return null;
                                }, false, false),
                                SizedBox(
                                  height: 10,
                                ),
                                customTextField(
                                    MaterialCommunityIcons.email_outline,
                                    "Email Address",
                                    "Email Address",
                                    false,
                                    true,
                                    value.emailController, (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter your email");
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please Enter a valid email");
                                  }
                                  // return null;
                                }, false, false),
                                customTextField(
                                    MaterialCommunityIcons.key_outline,
                                    "Password",
                                    "Password",
                                    false,
                                    false,
                                    value.passwordController, (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter password");
                                  }

                                  // return null;
                                }, true, true),
                                customTextField(
                                    MaterialCommunityIcons.key_outline,
                                    "Confirm Password",
                                    "Confirm Password",
                                    false,
                                    false,
                                    value.confirmpasswordController, (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter confirm password");
                                  }

                                  // return null;
                                }, true, true),
                                const SizedBox(
                                  height: 30,
                                ),
                                Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xff3949ab),
                                  child: Consumer<RegistrationProvider>(
                                    builder: (context, value, child) {
                                      return value.isLoading
                                          ? Container(
                                              height: 48,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.blue.withOpacity(.3),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: CustomLoader(
                                                    loadertype: false),
                                              ),
                                            )
                                          : MaterialButton(
                                              onPressed: () {
                                                value.startRegister(
                                                    _formKey, context);
                                              },
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 15, 20, 15),
                                              minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: const Text(
                                                "Signup",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                    },
                                  ),
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
                                        UtilFuntions.pageTransition(
                                            context,
                                            const LoginScreen(),
                                            const Signup());
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
                      );
                    },
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
    if (_formKey.currentState!.validate()) {}
  }

  postDetailsToFirestore() async {
    String timestamp;

    DateTime now = DateTime.now();
    String formatDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    timestamp = formatDate;
    print(timestamp);
  }

  Padding customTextField(
    IconData icon,
    String hintText,
    String labelText,
    bool isPassword,
    bool isEmail,
    TextEditingController controller,
    String? Function(String?)? validator,
    bool suffics,
    bool obscure,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: TextStyle(fontSize: 13, color: Constants.labelText),
          ),
          SizedBox(
            height: 8,
          ),
          Consumer<UserProvider>(
            builder: (context, value, child) {
              return TextFormField(
                // obscureText: obscure,
                obscureText: obscure == true ? value.isObscure : false,
                controller: controller,
                keyboardType:
                    isEmail ? TextInputType.emailAddress : TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    icon,
                    color: Constants.iconColor,
                  ),
                  suffixIcon: suffics
                      ? IconButton(
                          onPressed: () {
                            value.changeObscure();
                          },
                          icon: Icon(value.isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )
                      : null,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Constants.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: hintText,
                  labelText: hintText,
                  hintStyle:
                      TextStyle(fontSize: 14, color: Constants.textColor1),
                ),
                validator: validator,
              );
            },
          )
        ],
      ),
    );
  }
}
