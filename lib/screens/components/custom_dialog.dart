import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class DialogBox {
  Future<dynamic> dialogBox(
    BuildContext context,
    DialogType dialogType,
    String title,
    String desc,
    final Function() okPres,
  ) async {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: okPres,
    ).show();
  }
}
