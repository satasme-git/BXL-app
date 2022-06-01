import 'package:binary_app/provider/corse_provider.dart';
import 'package:binary_app/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/util_functions.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  // bool validate() {
  //   if (formkey.currentState!.validate()) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      // body:WebView(
      //   initialUrl: 'https://flutter.dev',
      // )
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Consumer2<PaymentProvider, CourseProvider>(
              builder: (context, value, value2, child) {
                return SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      text: "Online",
                                      style: TextStyle(
                                        fontSize: 25,
                                        letterSpacing: 2,
                                        color: Colors.blue[800],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " Pay,",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[900],
                                          ),
                                        )
                                      ]),
                                ),
                                Text(
                                  "Please fill all fields for \nonline payments",
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
                          height: 20,
                        ),
                        SizedBox(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                                  Image.asset('assets/3004575.png', scale: 2),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Payment Amount : ",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "Rs " + value2.getPrice,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            value: value,
                            lbltxt: "First Name",
                            inputtxt: "First Name",
                            hinttxt: "Enter first name here",
                            controller: value.firstNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please enter first name");
                              }

                              // return null;
                            },
                            keyboardtype: false),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            value: value,
                            lbltxt: "Last Name",
                            inputtxt: "Last Name",
                            hinttxt: "Enter last name here",
                            controller: value.lastNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please enter last name");
                              }

                              // return null;
                            },
                            keyboardtype: false),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            value: value,
                            lbltxt: "Phone Number",
                            inputtxt: "Phone Number",
                            hinttxt: "Enter phone number here",
                            controller: value.phoneVontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please enter phone name");
                              }
                              if (!RegExp("( *?[0-9a-zA-Z] *?){9,}")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid phone number");
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                              //To remove first '0'
                              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                              //To remove first '94' or your country code
                              FilteringTextInputFormatter.deny(RegExp(r'^94+')),
                            ],
                            keyboardtype: true),

                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0.0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              value.startRegister(context, value2.getPrice);
                            }
                          },
                          child: Ink(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                              // gradient: const LinearGradient(
                              //     colors: [Colors.red, Colors.orange]),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              child: const Text('Pay Here',
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.value,
    required this.lbltxt,
    required this.inputtxt,
    required this.hinttxt,
    required this.controller,
    required this.validator,
    this.inputFormatters,
    required this.keyboardtype,
    Key? key,
  }) : super(key: key);
  PaymentProvider value;
  String lbltxt;
  TextEditingController controller;
  String inputtxt;
  String hinttxt;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  bool keyboardtype;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lbltxt,
          style: GoogleFonts.poppins(
            color: Colors.grey[800],
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              contentPadding: EdgeInsets.all(15),
              labelText: inputtxt,
              hintText: hinttxt,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 0.1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 0.3,
                ),
              ),
            ),
            inputFormatters: inputFormatters,
            keyboardType:
                keyboardtype == true ? TextInputType.number : TextInputType.text
            //==true?keyboardType:TextInputType.number,
            ),
      ],
    );
  }
}

AppBar _appBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text(
      "Course Details",
      style: TextStyle(color: Colors.black54, fontSize: 15),
    ),
    leading: Container(
      margin: EdgeInsets.all(10),
      // height: 25,
      // width: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
      child: Builder(
        builder: (BuildContext context) {
          return IconButton(
            padding: EdgeInsets.all(3),
            icon: const Icon(
              MaterialCommunityIcons.chevron_left,
              size: 30,
            ),
            color: Colors.black,
            onPressed: () {
              UtilFuntions.goBack(context);
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    ),
  );
}
