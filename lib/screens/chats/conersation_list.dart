import 'package:binary_app/controller/chat_controller.dart';
import 'package:binary_app/model/objects.dart';
import 'package:binary_app/provider/chat_provider.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/Chat/chatScreen.dart';
import 'package:binary_app/screens/chats/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../utils/util_functions.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({Key? key}) : super(key: key);

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  List<ConversationModel> list = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFECF3F9),
      appBar: AppBar(
        backgroundColor: HexColor("#283890"),
        elevation: 0,
        title: const Text(
          "conversations",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: const [
          Icon(
            MaterialCommunityIcons.dots_vertical,
            size: 20,
          ),
          // Image.network(
          //   "https://placekitten.com/640/360",
          //   height: 45,
          //   width: 45,
          //   loadingBuilder: (BuildContext context, Widget child,
          //       ImageChunkEvent? loadingProgress) {
          //     if (loadingProgress == null) return child;
          //     return Center(
          //       child: CircularProgressIndicator(
          //         value: loadingProgress.expectedTotalBytes != null
          //             ? loadingProgress.cumulativeBytesLoaded /
          //                 loadingProgress.expectedTotalBytes!
          //             : null,
          //       ),
          //     );
          //   },
          // ),
          SizedBox(
            width: 20,
          ),
        ],
        leading: Container(
          margin: EdgeInsets.all(10),
          // height: 25,
          // width: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent),
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                padding: EdgeInsets.all(3),
                icon: const Icon(
                  MaterialCommunityIcons.chevron_left,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  UtilFuntions.goBack(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        width: size.width,
        height: size.height,
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: ChatController().getConversation(value.getuserModel!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("no converasation");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                list.clear();
                for (var item in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      item.data() as Map<String, dynamic>;

                  var model = ConversationModel.fromJson(data);
                  list.add(model);
                }
                Logger().w(snapshot.data!.docs.length);
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ConversationCard(
                      model: list[index],
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 10,
                    color: const Color.fromARGB(255, 245, 245, 245),
                  ),
                  itemCount: list.length,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    required this.model,
    Key? key,
  }) : super(key: key);

  final ConversationModel model;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Provider.of<ChatProvider>(context, listen: false).setConv(model);
        UtilFuntions.pageTransition(
            context, Chat(convId: model.id), const ConversationList());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          // BoxShadow(
          //   color: Colors.black12,
          //   blurRadius: 20,
          //   offset: Offset(0, 10),
          // )
        ]),
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    model.image == "null"
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Hero(
                              tag: "profgroup",
                              child: Image.asset(
                                "assets/avatar.jpg",
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Hero(
                              tag: "profgroup",
                              child: Image.network(
                                model.image,
                                height: 45,
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: size.width / 1.9,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.conversation_name,
                            // model.userArray
                            //     .firstWhere((element) => element.uid != "")
                            //     .fname,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Container(
                                // width: 50,
                                child: Text(
                                  model.lastMessageSender + " : ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Text(
                                  model.lastMessage,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  timeago.format(DateTime.parse(model.lastMessageTime)),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}