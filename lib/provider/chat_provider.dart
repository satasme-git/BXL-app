import 'dart:io';

import 'package:binary_app/controller/chat_controller.dart';
import 'package:binary_app/model/objects.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:binary_app/screens/Chat/chatScreen.dart';
import 'package:binary_app/screens/chats/chat_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// import '../model/objects.dart';

import '../utils/util_functions.dart';

class ChatProvider extends ChangeNotifier {
  final ChatController _chatController = ChatController();
  late ConversationModel _conversationModel;

  ConversationModel get conv => _conversationModel;

  final TextEditingController _message = TextEditingController();
  TextEditingController get messageController => _message;

  final TextEditingController _caption = TextEditingController();
  TextEditingController get captionController => _caption;

  bool isRightDoorLock = true;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  XFile? get getImageFile => _imageFile;

  File _image = File("");

  void updateRightDoorLock(String val) {
    if (val != "") {
      isRightDoorLock = true;
    } else {
      isRightDoorLock = false;
    }
    notifyListeners();
  }

  void setConv(ConversationModel model) {
    _conversationModel = model;
    notifyListeners();
  }

  //create a conversation function

  Future<void> createConversation(
      BuildContext context, UserModel peermodel) async {
    try {
      //get user model
      UserModel? userModel =
          Provider.of<UserProvider>(context, listen: false).getuserModel;
      _conversationModel =
          await _chatController.createConversation(userModel, peermodel);

      notifyListeners();

      UtilFuntions.pageTransition(
          context, const chatScreen(), const ChatMain());
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> sendMessage(BuildContext context) async {
    List<String> words = [
      "boru",
      "hora",
      "borukaraya",
      "palhora",
      "bitch",
      "keriya",
      "keri",
      "fuck",
      "Huththa",
      "Pakaya",
      "payya"
    ];
    var string = _message.text;

    bool existed = false;
    words.forEach((item) {
      // string.toUpperCase().contains(item.toUpperCase());
      if (string.toUpperCase().contains(item.toUpperCase())) {
        existed = true;
      }
    });

    try {
      if (_message.text.isNotEmpty) {
        if (existed) {
          Fluttertoast.showToast(msg: "Can't chatting this type of words");
        } else {
          UserModel userModel =
              Provider.of<UserProvider>(context, listen: false).getuserModel;
          await _chatController.sendMessage(
            _conversationModel.id,
            userModel.fname,
            userModel.uid,
            userModel.image,
            _message.text,
          );
          isRightDoorLock = false;
        }

        notifyListeners();
      } else {
        Logger().e(" Error ");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void takePhoto(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source // ImageSource.gallery,
            );

    _imageFile = pickedFile;
    if (pickedFile != null) {
      _image = File(pickedFile.path);

      notifyListeners();
    } else {
      Logger().e("no image selected");
    }

    notifyListeners();
  }

  Future<void> captionWithImage(BuildContext context) async {
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).getuserModel;
    // await _chatController.sendMessage(
    //   _conversationModel.id,
    //   userModel.fname ,
    //   userModel.uid,
    //   userModel.image,
    //   _message.text,
    // );
    await _chatController.captionWithImage(
        _conversationModel.id, _image, _caption.text, userModel);

    notifyListeners();
  }
}
