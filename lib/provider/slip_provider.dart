import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:binary_app/model/course_model.dart';
import 'package:binary_app/screens/Payment/slip_pay_video.dart';
import 'package:binary_app/screens/Video/Videolist.dart';
import '../model/objects.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../controller/slip_controller.dart';
import '../screens/Payment/Slippay.dart';
import '../screens/Payment/view_all_slips.dart';
import '../screens/components/custom_dialog.dart';
import '../utils/util_functions.dart';

class SlipProvider extends ChangeNotifier {
  final SlipController _slipController = SlipController();
  String _selectedCourse = "AAA";
  final ImagePicker _picker = ImagePicker();
  File _image = File("");
  File get getImg => _image;

  bool _isLoading = false;
  //get loading state
  bool get isLoading => _isLoading;
  String get geSelectedCourse => _selectedCourse;

  //validate fields
  bool inputValidation() {
    var isValid = false;
    if (_image.path.isEmpty || _selectedCourse.isEmpty) {
      isValid = false;

      print(">>>>>>>>>>>>> false ; " + _image.path + " / " + _selectedCourse);
    } else {
      isValid = true;
      print(">>>>>>>>>>>>> true ");
    }
    return isValid;
  }

  Future<void> selectImage() async {
    try {
      // Pick an image
      final XFile? pickFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickFile != null) {
        _image = File(pickFile.path);
        notifyListeners();
      } else {
        Logger().e("no image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> clearImagePicker() async {
    _image = File("");
    notifyListeners();
  }

  Future<void> startAddSlipData(BuildContext context, UserModel userModel,
      Coursemodel coursemodel) async {
    try {
      if (inputValidation()) {
        setLoading(true);

        await _slipController
            .saveSlipData(_image, coursemodel.CourseName, userModel)
            .then((value) {
          _image = File("");

          _image.delete();
          // _selectedCourse = "";
          notifyListeners();
        });

        setLoading();
        DialogBox().dialogBox(
          context,
          DialogType.SUCCES,
          'Success.',
          'Successfully uploaded the slip.\n We will get back to you soon',
          () {
            UtilFuntions.pageTransition(
                context, const ViewAllSlips(), const slipPay());
          },
        );
      } else {
        setLoading();
        DialogBox().dialogBox(context, DialogType.ERROR, 'Error.',
            'Please select an image', () {});
      }
    } catch (e) {
      setLoading();
      DialogBox().dialogBox(context, DialogType.ERROR, 'Somthing went wrong!',
          'Please try again', () {});
    }
  }

  Future<void> startAddSlipDataforVideo(
      BuildContext context, UserModel userModel, VideoModel videoModel) async {
    try {
      if (inputValidation()) {
        setLoading(true);

        await _slipController
            .saveSlipDataforVideo(_image, videoModel, userModel)
            .then((value) {
          _image = File("");

          _image.delete();

          notifyListeners();
        });

        setLoading();
        DialogBox().dialogBox(
          context,
          DialogType.SUCCES,
          'Success.',
          'Successfully uploaded the slip.\n We will get back to you soon',
          () {
            UtilFuntions.pageTransition(
                context, const Videolist(), const SlipPayVideo());
          },
        );
      } else {
        setLoading();
        DialogBox().dialogBox(context, DialogType.ERROR, 'Error.',
            'Please select an image', () {});
      }
    } catch (e) {
      setLoading();
      DialogBox().dialogBox(context, DialogType.ERROR, 'Somthing went wrong!',
          'Please try again', () {});
    }
  }

  //change loading state
  void setLoading([bool val = false]) {
    _isLoading = val;
    notifyListeners();
  }

  void setCurrentValue(String value) {
    _selectedCourse = value;

    notifyListeners();
  }
}
