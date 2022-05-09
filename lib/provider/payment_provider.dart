import 'dart:convert';

import 'package:binary_app/model/payment_model.dart';
import 'package:binary_app/model/user_model.dart';
import 'package:binary_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../screens/Payment/load_payment.dart';


class PaymentProvider extends ChangeNotifier {
  PaymentModel paymentModel = new PaymentModel("", "", "", "", "", "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  PaymentModel? get getPaymentModel => paymentModel;

  bool validate() {
    if (formkey.currentState!.validate()) {
      // notifyListeners();
      return true;
    } else {
      // notifyListeners();
      return false;
    }
  }

  final _st_id = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _emailAddress = TextEditingController();
  final _phonenumber = TextEditingController();
  final _payment = TextEditingController();

  TextEditingController get studentId => _st_id;
  TextEditingController get firstNameController => _firstName;
  TextEditingController get lastNameController => _lastName;
  TextEditingController get emailController => _emailAddress;
  TextEditingController get phoneVontroller => _phonenumber;
  TextEditingController get paymentController => _payment;

  Future<void> startRegister(BuildContext context, String price) async {
    UserModel? _usermodel =
        Provider.of<UserProvider>(context, listen: false).getuserModel;

    paymentModel.uid = _usermodel!.uid;
    paymentModel.firstname = _firstName.text;
    paymentModel.lastname = _lastName.text;
    paymentModel.email = _usermodel.email;
    paymentModel.phone = _phonenumber.text;
    paymentModel.amount = price;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoadPaymnet()));

    notifyListeners();
  }
}
