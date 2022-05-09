import 'dart:io';

import 'package:binary_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircleImageAvatar extends StatelessWidget {
  const CircleImageAvatar({
    Key? key,
    required this.radius,
    this.selector = true,
    required this.onTap,
  }) : super(key: key);

  final double radius;
  final bool selector;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white,
          child: Stack(
            children: [
              ClipRRect(
                // Image.asset(
                //    "assets/avatar.jpg",
                // )
                borderRadius: BorderRadius.circular(55),
                child: value.getImageFile == null
                    ? (value.getuserModel!.image != "null"
                        ? Image.network(value.getuserModel!.image)
                        : Image.asset("assets/avatar.jpg"))
                    : Image.file(
                        File(value.getImageFile!.path),
                        fit: BoxFit.fitWidth,
                        // scale: 6,
                        width: double.infinity,
                        // height: double.infinity,
                      ),
                //  Image.asset(value.getImageFile!.path),
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 0, bottom: 0),
              Align(
                alignment: Alignment.bottomRight,
                child: selector == true
                    ? InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      )
                    : null,
              ),
              // )
            ],
          ),
        );
      },
    );
  }
}
