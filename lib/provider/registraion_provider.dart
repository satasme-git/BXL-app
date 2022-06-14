import 'package:binary_app/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final UserController _usercontroller = UserController();
  String? errorMessage;

  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();

  TextEditingController get emailController => _email;
  TextEditingController get usernameController => _username;
  TextEditingController get passwordController => _password;
  TextEditingController get confirmpasswordController => _confirmpassword;
  bool _isLoading = false;

  //get loading state
  bool get isLoading => _isLoading;

  Future<void> resetPassword(
    GlobalKey<FormState> _formKey,
    BuildContext context,
  ) async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);
      try {
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: _email.text)
              .then((value) => Navigator.of(context).pop());
          errorMessage = "Password Reset Email Sent";

          Fluttertoast.showToast(msg: errorMessage!);
        } catch (e) {
          rethrow;
        }

        setLoading();

        //   UtilFuntions.pageTransition(context,
        //                                 const LoginScreen(), const ForgotPassword());

      } on FirebaseAuthException catch (error) {
        setLoading();

        Fluttertoast.showToast(msg: error.toString());
        // Navigator.of(context).pop();
      }
    } else {
      setLoading();
    }
  }

  Future<void> startRegister(
    GlobalKey<FormState> _formKey,
    BuildContext context,
    // String name,
    // String email,
    // String password,
  ) async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);
      try {
        if (_password.text == _confirmpassword.text) {
          UserCredential userCredential =
              await _auth.createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          );
          if (userCredential.user!.uid.isNotEmpty) {
            await UserController().saveUserData(
                _username.text, _email.text, userCredential.user!.uid);
          }

          setLoading();
        } else {
          setLoading();
          errorMessage = "Passwords are mismatch";
          Fluttertoast.showToast(msg: errorMessage!);
        }
      } on FirebaseAuthException catch (error) {
        setLoading();
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    } else {
      setLoading();
    }
  }

  //change loading state
  void setLoading([bool val = false]) {
    _isLoading = val;
    notifyListeners();
  }
}
