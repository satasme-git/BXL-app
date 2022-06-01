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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  String? errorMessage;

@override
  void dispose() {
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
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
                  padding: const EdgeInsets.only(top: 20, left: 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Hey",
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                color: Colors.blue[800],
                              ),
                              children: [
                                TextSpan(
                                  text: " There,",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900],
                                  ),
                                )
                              ]),
                        ),
                        Text(
                          "Recieve an email Reset \nyour password",
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.grey[800],
                          ),
                        ),
                         Text(
                          "( if not recieved please check spam)",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Consumer<RegistrationProvider>(
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
                                            child: const Center(
                                              child: CustomLoader(),
                                            ),
                                          )
                                        : MaterialButton(
                                            onPressed: () {
                                              value.resetPassword(
                                                  _formKey, context);
                                            },
                                            padding: EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Text(
                                              "Reset Password",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                  },
                                ),
                              ),
                              
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
