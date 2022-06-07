import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/home.dart';
import 'package:binary_app/screens/profile_screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/util_functions.dart';
import '../Chat/chatHome.dart';
import '../Payment/Slippay.dart';
import '../Payment/payment_screen.dart';
import '../Refer/refer.dart';
import '../aboutus/aboutus.dart';
import '../login.dart';
import 'custom_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 30,
          child: Row(
            children: [
              Text(
                "Powerd by satasme holdings (Pvt) Ltd, Sri lanka.",
                style: GoogleFonts.poppins(
                  color: Colors.grey[700],
                  fontSize: 10
                ),
              ),
              // Icon(icon)
            ],
          ),
        ),
        body: Container(
          // color: Color.fromRGBO(50,75,205,1),
          child: Consumer<UserProvider>(
            builder: (context, value, child) {
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                      accountEmail: Text(''),
                      // decoration: BoxDecoration(
                      //   color: Colors.transparent,
                      // ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xff283593),
                            Color(0xff2196f3),

                            // Color.fromRGBO(247, 148, 29, 1),
                            // Color.fromRGBO(254, 203, 48, 1),
                            // Colors.blue,
                            // Colors.purple,
                          ],
                        ),
                      ),
                      accountName: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: value.getuserModel!.image == ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(55),
                                      child: Image.asset(
                                        "assets/avatar.jpg",
                                      ),
                                      //  Image.asset(value.getImageFile!.path),
                                    )
                                  : CircleAvatar(
                                      radius: 25.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          "${value.getuserModel!.image}",
                                        ),
                                        radius: 24,
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  value.getuserModel!.fname +
                                      " " +
                                      value.getuserModel!.lname,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  value.getuserModel!.email,
                                  style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Column(
                    children: [
                      CustomListTile(
                        text: "Profile",
                        iconleading: MaterialCommunityIcons.account_outline,
                        onTap: () async {
                          UtilFuntions.pageTransition(context,
                              const ProfileScreen(), const CustomDrawer());
                          // UtilFunctions.navigateTo(context, const GettingStarted());

                          // MaterialPageRoute(builder: (context) => ProfileScreen());
                        },
                      ),
                      Divider(), //
                      CustomListTile(
                        text: "Careers",
                        iconleading: MaterialCommunityIcons.routes,
                        onTap: () {},
                      ),
                      Divider(), //
                      CustomListTile(
                        text: "Payment",
                        iconleading: MaterialCommunityIcons.wallet_outline,
                        onTap: () async {
                          UtilFuntions.pageTransition(
                              context, const slipPay(), const CustomDrawer());
                        },
                      ),
                      Divider(), //
                      CustomListTile(
                        text: "Chat",
                        iconleading:
                            MaterialCommunityIcons.message_text_outline,
                        onTap: () async {
                          Navigator.of(context).pop();
                          await Future.delayed(
                              Duration(milliseconds: 200)); // wait some time
                          UtilFuntions.pageTransition(
                              context, const chatHome(), const HomeScreen());
                        },
                      ),
                      Divider(), //
                      CustomListTile(
                        text: "About Us",
                        iconleading:
                            MaterialCommunityIcons.alert_circle_outline,
                        onTap: () async {
                          Navigator.of(context).pop();
                          await Future.delayed(
                              Duration(milliseconds: 200)); // wait some time
                          UtilFuntions.pageTransition(
                              context, const aboutUs(), const HomeScreen());
                        },
                      ),
                      Divider(), //
                      CustomListTile(
                        text: "Refer & Earn",
                        iconleading:
                            MaterialCommunityIcons.account_arrow_right_outline,
                        onTap: () async {
                          Navigator.of(context).pop();
                          await Future.delayed(
                              Duration(milliseconds: 200)); // wait some time
                          UtilFuntions.pageTransition(
                              context, const refer(), const HomeScreen());
                        },
                      ),

                      Divider(), //here is a divider
                      SizedBox(
                        height: 30,
                      ),
                      CustomListTile(
                        text: "Logout",
                        iconleading: MaterialCommunityIcons.power,
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((_) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
