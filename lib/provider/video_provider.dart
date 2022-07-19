import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/video_controller.dart';
import '../model/objects.dart';

class VideoProvider extends ChangeNotifier {
  VideoModel? _videoModel;
  //user controller object
  VideoModel? get getvideoModel => _videoModel;
  final VideoController _videocontroller = VideoController();
  Future<void> fetchSingleVideo(BuildContext context, String id) async {
    Logger().d(">>>>>>>>>>>>>>>>> : " + id);
    _videoModel = await _videocontroller.getVideoData(context, id);

    // notifyListeners();
  }
}
