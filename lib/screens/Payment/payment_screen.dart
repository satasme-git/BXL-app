import 'package:binary_app/provider/corse_provider.dart';
import 'package:binary_app/provider/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';



class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool validate() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

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
            child: Consumer2<PaymentProvider,CourseProvider>(
              builder: (context, value,value2, child) {
                return SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 50,
                        // ),
                        // Text("Add Payment infromations"),
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child:
                                Image.asset('assets/3004575.png', scale: 0.5),
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
                              "Rs "+value2.getPrice,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          value: value,
                          lbltxt: "First Name",
                          inputtxt: "First Name",
                          hinttxt: "Enter first name here",
                          controller: value.firstNameController,
                        ),
                        CustomTextField(
                          value: value,
                          lbltxt: "Last Name",
                          inputtxt: "Last Name",
                          hinttxt: "Enter last name here",
                          controller: value.lastNameController,
                        ),
                        CustomTextField(
                          value: value,
                          lbltxt: "Phone Number",
                          inputtxt: "Phone Number",
                          hinttxt: "Enter phone number here",
                          controller: value.phoneVontroller,
                        ),
                        // CustomTextField(
                        //   value,
                        //   value.firstNameController,
                        //   "Student Number",
                        //   "Enter Student Number here",
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // CustomTextField(
                        //   value,
                        //   value.studentId,
                        //   "First Name",
                        //   "Enter first name here",
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // CustomTextField(
                        //   value,
                        //   value.studentId,
                        //   "Second Name",
                        //   "Enter second name here",
                        // ),
                        // TextFormField(
                        //   controller: value.firstNameController,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Required *";
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   decoration: InputDecoration(
                        //     labelStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 12,
                        //     ),
                        //     contentPadding: EdgeInsets.all(15),
                        //     labelText: "First Name",
                        //     hintText: "Enter first name here",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // TextFormField(
                        //   controller: value.lastNameController,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Required *";
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   decoration: InputDecoration(
                        //     labelStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 12,
                        //     ),
                        //     contentPadding: EdgeInsets.all(15),
                        //     labelText: "Second Name",
                        //     hintText: "Enter second name here",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   controller: value.emailController,
                        //   validator: MultiValidator([
                        //     EmailValidator(errorText: "Not a valid email"),
                        //     RequiredValidator(errorText: "Required *")
                        //   ]),
                        //   decoration: InputDecoration(
                        //     contentPadding: EdgeInsets.all(15),
                        //     labelText: "Email Address",
                        //     hintText: "Enter email  here",
                        //     labelStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 12,
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   controller: value.phoneVontroller,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Required *";
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   decoration: InputDecoration(
                        //     labelStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 12,
                        //     ),
                        //     contentPadding: EdgeInsets.all(15),
                        //     labelText: "Whatsapp number",
                        //     hintText: "Enter phone number here",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   controller: value.paymentController,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "Required *";
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        //   decoration: InputDecoration(
                        //     labelStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 12,
                        //     ),
                        //     contentPadding: EdgeInsets.all(15),
                        //     labelText: "Payment Name",
                        //     hintText: "Enter Payemt here",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                            if (validate()) {
                              value.startRegister(
                                context,value2.getPrice
                              );
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

//   TextFormField CustomTextField(
//     PaymentProvider value,
//     TextEditingController controller,
//     String lbltxt,
//     String hinttxt,
//   ) {
//     return TextFormField(
//       controller: controller,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "Required *";
//         } else {
//           return null;
//         }
//       },
//       decoration: InputDecoration(
//         labelStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 12,
//         ),
//         contentPadding: EdgeInsets.all(15),
//         labelText: lbltxt,
//         hintText: hinttxt,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(
//             color: Colors.grey,
//             width: 0.1,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(
//             color: Colors.red,
//             width: 0.3,
//           ),
//         ),
//       ),
//     );
//   }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.value,
    required this.lbltxt,
    required this.inputtxt,
    required this.hinttxt,
    required this.controller,
    Key? key,
  }) : super(key: key);
  PaymentProvider value;
  String lbltxt;
  TextEditingController controller;
  String inputtxt;
  String hinttxt;
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
          validator: (value) {
            if (value!.isEmpty) {
              return "Required *";
            } else {
              return null;
            }
          },
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
            onPressed: () {},
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    ),
  );
}
