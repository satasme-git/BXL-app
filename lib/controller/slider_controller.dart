import 'package:binary_app/model/slider_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SliderController {
  CollectionReference sliders =
      FirebaseFirestore.instance.collection('sliders');
  Future<List<SliderModel>> getSliders() async {
    List<SliderModel> list = [];
    try {
      QuerySnapshot snapshot =
          await sliders.where('status', isEqualTo: 1).get();
      for (var item in snapshot.docs) {
        SliderModel model =
            SliderModel.fromMap(item.data() as Map<String, dynamic>);
        list.add(model);
      }
      return list;
    } catch (e) {
      return list;
    }
  }
}
