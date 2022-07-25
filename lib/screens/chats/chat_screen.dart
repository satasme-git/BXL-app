import 'dart:math';

import 'package:binary_app/model/objects.dart';
import 'package:binary_app/provider/chat_provider.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/Chat/chatScreen.dart';
import 'package:binary_app/screens/chats/chat_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_text/link_text.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../controller/chat_controller.dart';
import '../../utils/util_functions.dart';
import 'conversation_setting.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.convId, required this.index})
      : super(key: key);

  final String convId;
  final int index;
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<MessageModel> list = [];
  final ChatProvider _controller = ChatProvider();
  // final TextEditingController _controller1 = TextEditingController();

  // bool emojiShowing = false;

  // _onEmojiSelected(Emoji emoji) {
  //   _controller1
  //     ..text += emoji.emoji
  //     ..selection = TextSelection.fromPosition(
  //         TextPosition(offset: _controller1.text.length));
  // }

  // _onBackspacePressed() {
  //   _controller
  //     ..text = _controller.text.characters.skipLast(1).toString()
  //     ..selection = TextSelection.fromPosition(
  //         TextPosition(offset: _controller.text.length));
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: HexColor("#efe7e1"),
            appBar: PreferredSize(
                child: AppBarSection(index: widget.index),
                preferredSize: Size.fromHeight(size.height / 12)),

            body: Stack(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: ChatController().getMessage(widget.convId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("no messages"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                      //  CircularProgressIndicator();
                    }
                    list.clear();
                    for (var item in snapshot.data!.docs) {
                      Map<String, dynamic> data =
                          item.data() as Map<String, dynamic>;

                      var model = MessageModel.fromJson(data);
                      list.add(model);
                    }
                    Logger().w(snapshot.data!.docs.length);
                    return AnimationLimiter(
                      child: ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.only(bottom: 60),
                        itemCount: list.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Consumer<UserProvider>(
                                    builder: (context, value, child) {
                                      String mystring = list[index].sendarName;
                                      String upperLeter =
                                          mystring[0].toUpperCase();

                                      return Column(
                                        children: [
                                          list[index].senderid ==
                                                  value.getuserModel!.uid
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    ChatBubble(
                                                      clipper:
                                                          ChatBubbleClipper5(
                                                              type: BubbleType
                                                                  .sendBubble),
                                                      alignment:
                                                          Alignment.topRight,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      backGroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              227,
                                                              253,
                                                              216),
                                                      child: Container(
                                                        constraints:
                                                            BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                        ),
                                                        child: list[index]
                                                                    .messageType !=
                                                                "image"
                                                            ? LinkText(
                                                                list[index]
                                                                    .message,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                textStyle:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              )
                                                            : Column(
                                                                children: [
                                                                  list[index].messageUrl ==
                                                                          "null"
                                                                      ? const Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 30),
                                                                            child:
                                                                                CircularProgressIndicator(),
                                                                          ),
                                                                        )
                                                                      : Image
                                                                          .network(
                                                                          list[index]
                                                                              .messageUrl,
                                                                          // height: 45,
                                                                          width:
                                                                              230,

                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                  LinkText(
                                                                    list[index]
                                                                        .message,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                ],
                                                              ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      timeago.format(DateTime
                                                          .parse(list[index]
                                                              .messageTime)),
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 11,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    list[index].image == "null"
                                                        ? Container(
                                                            height: 45,
                                                            width: 45,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(Random()
                                                                  .nextInt(
                                                                      0xffffffff)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          45),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                upperLeter,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 30,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        45),
                                                            child:
                                                                Image.network(
                                                              list[index].image,
                                                              height: 45,
                                                              width: 45,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                    ChatBubble(
                                                      clipper: ChatBubbleClipper1(
                                                          type: BubbleType
                                                              .receiverBubble),
                                                      backGroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 0),
                                                        constraints:
                                                            BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                        ),
                                                        child: list[index]
                                                                    .messageType ==
                                                                "image"
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    list[index]
                                                                        .sendarName,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              5,
                                                                              121,
                                                                              9),
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Image.network(
                                                                    list[index]
                                                                        .messageUrl,
                                                                    // height: 45,
                                                                    width: 230,

                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  LinkText(
                                                                    list[index]
                                                                        .message,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                    // You can optionally handle link tap event by yourself
                                                                    // onLinkTap: (url) => ...
                                                                  ),
                                                                ],
                                                              )
                                                            : Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    list[index]
                                                                        .sendarName,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              5,
                                                                              121,
                                                                              9),
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                  LinkText(
                                                                    list[index]
                                                                        .message,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                    // You can optionally handle link tap event by yourself
                                                                    // onLinkTap: (url) => ...
                                                                  ),
                                                                ],
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    // height: size.height / 16,
                    color: Colors.white,
                    child: Consumer<ChatProvider>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 8, bottom: 8, right: 8),
                              child: Icon(Ionicons.happy_outline,
                                  size: 30, color: Colors.grey),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: value.messageController,
                                onChanged: (text) {
                                  value.updateRightDoorLock(text);
                                },
                                //  maxLines: 4,
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  // borderSide: BorderSide.,
                                  // borderRadius: BorderRadius.circular(20),

                                  hintText: "Message",
                                ),
                              ),
                              // Text("sdsad")
                            ),
                            InkWell(
                              onTap: () {
                                value.sendMessage(context);
                                value.messageController.clear();
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                child: value.isRightDoorLock
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Ionicons.send,
                                          size: 22,
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: ((builder) =>
                                                BottomSheet(size: size)),
                                          );
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          child: Icon(
                                            Ionicons.camera_outline,
                                            size: 22,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                              ),
                              // child: Row(
                              //   children: [
                              //     Icon(
                              //       Ionicons.camera_outline,
                              //       size: 22,
                              //       color: Colors.grey[600],
                              //     ),
                              //     SizedBox(width: 10,),
                              //     Padding(
                              //       padding: const EdgeInsets.all(6.0),
                              //     //   child: Container(
                              //     //     padding: EdgeInsets.all(10),
                              //     //     decoration: BoxDecoration(
                              //     //       color: Colors.grey[300],
                              //     //       borderRadius: BorderRadius.circular(30),
                              //     //     ),
                              //         child:
                              //         Center(
                              //           child: Icon(
                              //             Ionicons.send,
                              //             size: 22,
                              //             color: Colors.grey[600],
                              //           ),
                              //         ),
                              //     //   ),
                              //     ),
                              //   ],
                              // ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // bottomNavigationBar:
          );
        });
  }
}

class AppBarSection extends StatelessWidget {
  const AppBarSection({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#283890"),
      padding: const EdgeInsets.only(left: 0, right: 20, top: 30),
      child: Consumer2<ChatProvider, UserProvider>(
        builder: (context, value, value2, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 0, right: 0, bottom: 10, top: 10),
                    // height: 25,
                    // width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent),
                    child: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 3, bottom: 3),
                          icon: const Icon(
                            MaterialCommunityIcons.chevron_left,
                            color: Colors.white,
                            size: 30,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            UtilFuntions.goBack(context);
                          },
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      UtilFuntions.pageTransition(context,
                          const ConversationSettings(), const chatScreen());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Hero(
                        tag: "profgroup$index",
                        child: Image.network(
                          value.conv.image,
                          height: 45,
                          width: 45,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.conv.conversation_name,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          // "30 members",
                          "${value.conv.users.length} members",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[200]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Icon(
                MaterialCommunityIcons.dots_vertical,
                color: Colors.white,
                size: 20,
              )
            ],
          );
        },
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
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 278,
      width: size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Consumer<ChatProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        iconcreation(
                          Icons.insert_drive_file,
                          Colors.indigo,
                          "Document",
                          () {
                            //  value.takePhoto(ImageSource.gallery);
                          },
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        iconcreation(
                          Icons.camera_alt,
                          Colors.pink,
                          "Camera",
                          () {
                            value.takePhoto(ImageSource.camera);
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        iconcreation(
                          Icons.insert_photo,
                          Colors.purple,
                          "Gallery",
                          () {
                            value.takePhoto(ImageSource.gallery);
                            Navigator.pop(context);
                            UtilFuntions.pageTransition(
                                context, const ChatImage(), const chatScreen());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        iconcreation(
                          Icons.headset,
                          Colors.orange,
                          "Audio",
                          () {
                            //  value.takePhoto(ImageSource.camera);
                          },
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        iconcreation(
                          Icons.location_pin,
                          Colors.red,
                          "Location",
                          () {
                            //  value.takePhoto(ImageSource.camera);
                          },
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        iconcreation(
                          Icons.person,
                          Colors.blue,
                          "Contact",
                          () {
                            //  value.takePhoto(ImageSource.camera);
                          },
                        ),
                      ],
                    )
                  ],
                );
              },
            )),
      ),
    );
    //   return Consumer<UserProvider>(
    //     builder: (context, value, child) {
    //       return Container(
    //         height: 100,
    //         width: size.width,
    //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //         child: Column(
    //           children: [
    //             Text(
    //               "Chose Profile Photo",
    //               style: TextStyle(
    //                 fontSize: 20,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 FlatButton.icon(
    //                   onPressed: () {
    //                      value.takePhoto(ImageSource.camera);
    //                   },
    //                   icon: Icon(Icons.camera),
    //                   label: Text("Camera"),
    //                 ),
    //                 FlatButton.icon(
    //                   onPressed: () {
    //                     value.takePhoto(ImageSource.gallery);
    //                   },
    //                   icon: Icon(Icons.image),
    //                   label: Text("Galary"),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //         // color: Colors.amber,
    //       );
    //     },
    //   );
  }

  Widget iconcreation(
      IconData icon, Color color, String text, Function() onTap) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            InkWell(
              onTap: onTap,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: color,
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
