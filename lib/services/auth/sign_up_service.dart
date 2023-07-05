import 'dart:convert';

import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/repositories/user/user_repository.dart';
import 'package:authentications/services/configs/entity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'auth_service.dart';

class SignUpService extends GetxController{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final UserRepository userRepo = UserRepository();

  final _isPasswordShowing = false.obs;
  final _isConfirmPasswordShowing = false.obs;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  void clearForms(){
    emailController.clear();
    passwordController.clear();
  }

  Future<bool> signUpUser() async {
    UserModel user = UserModel();
    user.name = nameController.text;
    user.email = emailController.text;
    user.password = passwordController.text;
    user.roleId = 2;
    final id = await userRepo.create(user);
    if(id ==null)return false;
    user.id = id;
    await authService.authenticateUser(user);
    return true;
  }

  AuthService get authService => Get.find<AuthService>();
  EntityService get entityService => Get.find<EntityService>();

  bool get isPasswordShowing => _isPasswordShowing.value;
  set isPasswordShowing(bool value) => _isPasswordShowing.value = value;
  bool get isConfirmPasswordShowing => _isConfirmPasswordShowing.value;
  set isConfirmPasswordShowing(bool value) => _isConfirmPasswordShowing.value = value;
}