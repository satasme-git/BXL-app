import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/slider_controller.dart';
import '../model/slider_model.dart';

class SliderProvider extends ChangeNotifier {
  List<SliderModel> _sliders = [];
  List<SliderModel> get getSliders => _sliders;
  final SliderController _sliderController = SliderController();

  Future<void> fetchSliders() async {
    try {
      _sliders.clear();

      await _sliderController.getSliders().then((value) {
        _sliders = value;

        for (var i = 0; i < _sliders.length; i++) {
          Logger().w(_sliders[i].image);
        }
        // Logger().w(_sliders.length)j;
        notifyListeners();
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
