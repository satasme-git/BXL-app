import 'dart:io';

import 'package:binary_app/model/objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import '../model/user_model.dart';

class ChatController {
  CollectionReference chats_groups =
      FirebaseFirestore.instance.collection('chats_groups');
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');

  CollectionReference messageCollection =
      FirebaseFirestore.instance.collection('message');
  //retreive chat groups
  Stream<QuerySnapshot> getGroups() {
    // return users.where('uid',)
    return chats_groups.where('status', isEqualTo: 0).snapshots();
  }

  Future<ConversationModel> createConversation(
      UserModel user, UserModel peeruser) async {
    //generate random id

    String docid = conversations.doc().id;
    await conversations
        .doc(docid)
        .set({
          'id': docid,
          'users': [user.uid, user.uid],
          'userArray': [user.toJson(), user.toJson()],
          'lastMessage': "started convocation",
          'lastMessageTime': DateTime.now().toString(),
          'createdBy': user.uid,
          'created_at': DateTime.now(),
        })
        .then((value) => print("conversation Added"))
        .catchError((error) => print("Failed to add conversation: $error"));

    DocumentSnapshot snapshot = await conversations.doc(docid).get();

    return ConversationModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  //retrive conversation
  Stream<QuerySnapshot> getConversation(String uid) => conversations
      .orderBy('created_at', descending: true)
      .where('users', arrayContainsAny: [uid]).snapshots();

//send - retrive message
  Future<void> sendMessage(String conid, String sendarName, String senderid,
      String image, String message) async {
    try {
      //save message data in db
      await messageCollection.add({
        "id": conid,
        "sendarName": sendarName,
        "senderid": senderid,
        "message": message,
        "image": image,
        "messageUrl": "null",
        "messageType": "text",
        "messageTime": DateTime.now().toString(),
        "created_at": DateTime.now(),
      });

//update the conversation
      await conversations.doc(conid).update({
        'lastMessage': message,
        'lastMessageSender': sendarName,
        'lastMessageTime': DateTime.now().toString(),
        'created_at': DateTime.now(),
      });
    } catch (e) {}
  }

  //recieve message stream
  Stream<QuerySnapshot> getMessage(String convid) => messageCollection
      .orderBy('created_at', descending: true)
      .where('id', isEqualTo: convid)
      .snapshots();

  //upload image to th firebase
  UploadTask? uploadFile(File file) {
    try {
      final filename = basename(file.path);
      final destination = "bxlChatImages/$filename";
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<void> captionWithImage(String conid,File img, String caption,UserModel userModel) async {
    try {
      //save message data in db
    var  orderRef = await messageCollection.add({
        "id": conid,
        "sendarName": userModel.fname,
        "senderid": userModel.uid,
        "message": caption,
        "image":userModel.image,
        "messageUrl": "null",
        "messageType": "image",
        "messageTime": DateTime.now().toString(),
        "created_at": DateTime.now(),
      });

//update the conversation
      await conversations.doc(conid).update({
        'lastMessage': caption,
        'lastMessageSender': userModel.fname,
        'lastMessageTime': DateTime.now().toString(),
        'created_at': DateTime.now(),
      });
 

    UploadTask? task = uploadFile(img);
    final snapshot = await task!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();


// Logger().d(">>>>>>>>>>>>>>> 000---8888 :"+orderRef.id.toString());
     await messageCollection.doc(orderRef.id).update({
      
        "messageUrl": downloadUrl,
       
      });
       } catch (e) {}
  }
}
