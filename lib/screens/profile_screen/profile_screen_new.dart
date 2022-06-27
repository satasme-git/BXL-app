import 'dart:io';

import 'package:binary_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/constatnt.dart';
import '../components/custom_loader.dart';

class ProfileScreenNew extends StatefulWidget {
  const ProfileScreenNew({Key? key}) : super(key: key);

  @override
  State<ProfileScreenNew> createState() => _ProfileScreenNewState();
}

class _ProfileScreenNewState extends State<ProfileScreenNew> {
  final _formKey = GlobalKey<FormState>();
  var top = 0.0;
  late ScrollController _scrolController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrolController = ScrollController();
    _scrolController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrolController,
            slivers: [
              SliverAppBar(
                backgroundColor: HexColor("#283890"),
                pinned: true,
                leading: AnimatedOpacity(
                  opacity: top <= 130 ? 0.2 : 1.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    color: Colors.black,
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
                expandedHeight: 250,
                flexibleSpace: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: top <= 130 ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                value.getuserModel!.image == "null"
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(55),
                                        child: Image.asset(
                                          
                                          "assets/avatar.jpg",
                                          height: 30,
                                        ),
                                        //  Image.asset(value.getImageFile!.path),
                                      )
                                    : 
                                     CircleAvatar(
                                          minRadius: 10,
                                          maxRadius: 18,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              value.getuserModel!.image,
                                            ),
                                            radius: 24,
                                          ),
                                        ),
                                    
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(value.getuserModel!.email,style: GoogleFonts.poppins(fontSize: 12),),
                              ],
                            ),
                          ),
                          background: value.getImageFile == null
                              ? (value.getuserModel!.image != "null"
                                  ? Hero(
                                     tag: "profile",
                                    child: Image.network(
                                        value.getuserModel!.image,
                                        fit: BoxFit.cover,
                                      ),
                                  )
                                  : Image.asset("assets/avatar.jpg"))
                              :
                               Hero(
                                tag: "profile",
                                child: Image.file(
                                    File(value.getImageFile!.path),
                                    fit: BoxFit.cover,
                                    // scale: 6,
                                    width: double.infinity,
                                    // height: double.infinity,
                                  ),
                              ),
                        );
                      },
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: Consumer<UserProvider>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: size.height,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            customTextField(
                              MaterialCommunityIcons.account_outline,
                              "First Name",
                              "First Name",
                              false,
                              false,
                              value.fnameController,
                              (value) {
                                if (value!.isEmpty) {
                                  return ("Please enter first name");
                                }
                                return null;

                                // return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextField(
                              MaterialCommunityIcons.account_outline,
                              "Last Name",
                              "Last name",
                              false,
                              true,
                              value.lnameController,
                              (value) {
                                if (value!.isEmpty) {
                                  return ("Please enter last email");
                                }
                                return null;

                                // return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextField(
                              MaterialCommunityIcons.email_outline,
                              "Email Address",
                              "Email Address",
                              false,
                              true,
                              value.emailController,
                              (value) {
                                if (value!.isEmpty) {
                                  return ("Please enter your email");
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please Enter a valid email");
                                }
                                return null;
                                // return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextField(
                              MaterialCommunityIcons.phone_outline,
                              "Phone Number",
                              "Phone Number",
                              true,
                              false,
                              value.phoneController,
                              (value) {
                                if (value!.isEmpty) {
                                  return ("Please enter your email");
                                }
                                if (!RegExp('^(?:[+0]9)?[0-9]{10}')
                                    .hasMatch(value)) {
                                  return ("Please Enter a valid phone number");
                                }
                                return null;
                                // return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            value.isLoading
                                ? Container(
                                    height: 52,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: CustomLoader(),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(0.0),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        value.UpdateUser(context, _formKey,
                                            value.getuserModel!.uid);
                                      }
                                    },
                                    child: Ink(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue,
                                        // gradient: const LinearGradient(
                                        //     colors: [Colors.red, Colors.orange]),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(18),
                                        child: const Text('update Now',
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    final size = MediaQuery.of(context).size;
    const double defaultMargin = 265;
    const double defaultStart = 220;
    const double defaultEnd = defaultStart / 2;
    double top = defaultMargin;
    double scale = 1.0;
    if (_scrolController.hasClients) {
      double offset = _scrolController.offset;
      top -= offset;
      if (offset < defaultMargin - defaultStart) {
        scale = 1.0;
      } else if (offset < defaultStart - defaultEnd) {
        scale = (defaultMargin - defaultEnd - offset) / defaultEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(scale),
        child: SizedBox(
          width: 40,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => BottomSheet(size: size)),
              );
            },
            child: const Icon(Icons.camera_alt_outlined),
            backgroundColor: Colors.blue,
            splashColor: Colors.yellow,
          ),
        ),
      ),
    );
  }

  Padding customTextField(
    IconData icon,
    String hintText,
    String labelText,
    bool isPassword,
    bool isEmail,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(fontSize: 13, color: Constants.labelText),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
              obscureText: false,
              controller: controller,
              keyboardType:
                  isEmail ? TextInputType.emailAddress : TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Constants.iconColor,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Constants.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: hintText,
                labelText: hintText,
                hintStyle: const TextStyle(fontSize: 14, color: Constants.textColor1),
              ),
              validator: validator),
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Container(
          height: 100,
          width: size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Chose Profile Photo",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton.icon(
                    onPressed: () {
                      value.takePhoto(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera"),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      value.takePhoto(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Galary"),
                  ),
                ],
              )
            ],
          ),
          // color: Colors.amber,
        );
      },
    );
  }
}
