import 'dart:io';

import 'package:binary_app/provider/chat_provider.dart';
import 'package:binary_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../utils/constatnt.dart';

class ChatImage extends StatefulWidget {
  const ChatImage({Key? key}) : super(key: key);

  @override
  State<ChatImage> createState() => _ChatImageState();
}

class _ChatImageState extends State<ChatImage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Consumer<ChatProvider>(
            builder: (context, value, child) {
              return Center(
                child: Image.file(
                  File(value.getImageFile!.path),
                  fit: BoxFit.fitWidth,
                  // scale: 6,
                  width: double.infinity,
                  // height: double.infinity,
                ),
              );
            },
          ),
          Positioned(
              bottom: 15,
              left: 5,
              right: 5,
              child: Consumer<ChatProvider>(
                builder: (context, value, child) {
                  return Container(
                      width: size.width,
                      // height: 100,
                      color: Colors.black,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: value.captionController,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Add a caption',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25.7),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                                value.captionWithImage(context);
                               
                                Navigator.pop(context);
                              },
                              child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 500),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius:
                                            BorderRadius.circular(35)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(
                                        Ionicons.send,
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          //  TextFormField()
                        ],
                      ));
                },
              )),
        ],
      ),
      //  Stack(
      //   childrColor.fromARGB(255, 175, 80, 80)      //      Positioned(
      //       bottom: 0,
      //       child: Container(
      //         width: size.width,
      //         // height: size.height / 16,
      //         color: Colors.red,
      //         child: Consumer<ChatProvider>(
      //           builder: (context, value, child) {
      //             return Row(
      //               children: [
      //                 const Padding(
      //                   padding:
      //                       EdgeInsets.only(left: 8, bottom: 8, right: 8),
      //                   child: Icon(Ionicons.happy_outline,
      //                       size: 30, color: Colors.grey),
      //                 ),
      //                 Expanded(
      //                   child: TextFormField(
      //                     controller: value.messageController,
      //                     onChanged: (text) {
      //                       value.updateRightDoorLock(text);
      //                     },
      //                     //  maxLines: 4,
      //                     minLines: 1,
      //                     maxLines: 5,
      //                     keyboardType: TextInputType.multiline,
      //                     decoration: const InputDecoration(
      //                       border: InputBorder.none,
      //                       hintText: "Message",
      //                     ),
      //                   ),
      //                   // Text("sdsad")
      //                 ),
      //                 InkWell(
      //                   onTap: () {
      //                     value.sendMessage(context);
      //                     value.messageController.clear();
      //                   },
      //                 ),
      //               ],
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //     // Container(
      //     //   width: size.width,
      //     //   height: size.height,
      //     //   child: Center(
      //     //     child: Image.file(
      //     //       File(value.getImageFile!.path),
      //     //       fit: BoxFit.fitWidth,
      //     //       // scale: 6,
      //     //       width: double.infinity,
      //     //       // height: double.infinity,
      //     //     ),
      //     //   ),
      //     // ),

      //   ],
      // ),
    );
  }
}
