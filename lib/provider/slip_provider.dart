import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../controller/slip_controller.dart';
import '../screens/components/custom_dialog.dart';
import '../screens/test_content.dart';

class SlipProvider extends ChangeNotifier {
  final SlipController _slipController = SlipController();
  String _selectedCourse = "";
  final ImagePicker _picker = ImagePicker();
  File _image = File("");
  File get getImg => _image;
  bool _isLoading = false;
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

  Future<void> startAddSlipData(BuildContext context, String uid) async {
    try {
      if (inputValidation()) {
        setLoading(true);
        
        await _slipController.saveSlipData(_image, _selectedCourse, uid).then((value){
          _image.delete();
          _selectedCourse="";
           notifyListeners();
        });

        setLoading();
        DialogBox().dialogBox(
          context,
          DialogType.SUCCES,
          'Success.',
          'Successfuly upload slip',
          
        );
      } else {
        setLoading();
        DialogBox().dialogBox(
          context,
          DialogType.ERROR,
          'Error.',
          'Please select an image',
        );
      }
    } catch (e) {
      setLoading();
      // DialogBox().dialogBox(
      //   context,
      //   DialogType.ERROR,
      //   'Incorrect information.',
      //   'Please enter correct information',
      // );
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
