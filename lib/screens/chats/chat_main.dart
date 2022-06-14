import 'package:binary_app/controller/chat_controller.dart';
import 'package:binary_app/controller/user_controller.dart';

import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/chats/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../model/chat_group_model.dart';
import '../../utils/util_functions.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({Key? key}) : super(key: key);

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {
  List<ChatGroupModel> list = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "conversation",
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Image.network(
            "https://placekitten.com/640/360",
            height: 45,
            width: 45,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        width: size.width,
        height: size.height,
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: ChatController().getGroups(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("no groups");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                list.clear();
                for (var item in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      item.data() as Map<String, dynamic>;

                  var model = ChatGroupModel.fromJson(data);
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
                    color: Color.fromARGB(255, 245, 245, 245),
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

  final ChatGroupModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // UtilFuntions.pageTransition(context, const Chat(convId: model.i), const ChatMain());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
            boxShadow: [
              // BoxShadow(
              //   color: Colors.black12,
              //   blurRadius: 20,
              //   offset: Offset(0, 10),
              // )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: model.image != "null"
                      ? Image.network(
                          model.image,
                          height: 45,
                          width: 45,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          "assets/avatar.jpg",
                          height: 45,
                          width: 45,
                          fit: BoxFit.fill,
                        ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.group_name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                       model.last_msg,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              "1 min ago",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
