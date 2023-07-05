import 'dart:convert';

import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/repositories/user/user_repository.dart';
import 'package:authentications/services/commons/password_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'auth_service.dart';


class LoginService extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserRepository userRepo = UserRepository();

  final _isPasswordShowing = false.obs;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  void clearForms(){
    emailController.clear();
    passwordController.clear();
  }

  Future<bool> login() async{
    final data = await userRepo.getUserByEmail(emailController.text);
    if(data == null){
      return false;
    }
    final match = (PasswordUtil.encryptPassword(passwordController.text)==data.password);
    if(match){
      await authService.authenticateUser(data);
    }
    return match;
  }

  AuthService get authService => Get.find<AuthService>();
  bool get isPasswordShowing => _isPasswordShowing.value;
  set isPasswordShowing(bool value) => _isPasswordShowing.value = value;
}