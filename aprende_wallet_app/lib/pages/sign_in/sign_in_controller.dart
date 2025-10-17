
import 'package:aprende_wallet_app/Services/session_service.dart';
import 'package:aprende_wallet_app/Services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxString message = ''.obs;
  RxBool success = false.obs;
  UsersService userService = UsersService();
  SessionService sessionService = SessionService();

  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/sign-up');
  }

  void goToResetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/reset-password');
  }

  void login(BuildContext context) async{
   
  }
}
