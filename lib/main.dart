import 'dart:convert';

import 'package:authentications/models/user/user_model.dart';
import 'package:authentications/screens/commons/common_widget.dart';
import 'package:authentications/screens/configs/page_config.dart';
import 'package:authentications/services/auth/auth_service.dart';
import 'package:authentications/services/configs/entity_service.dart';
import 'package:authentications/services/configs/initial_binding.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:authentications/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final entityService = Get.put(EntityService());
  await entityService.initialize();
  final StorageService storageService = Get.put(StorageService());
  final AuthService authService = Get.put(AuthService());
  Get.put(UserService());
  await _checkLoggedUser(storageService, authService);

  runApp(const AuthenticationApp());
}

class AuthenticationApp extends StatelessWidget{
  const AuthenticationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authentication Example',
      initialBinding: InitialBinding(),
      initialRoute: '/home',
      getPages: PageConfig.pages,
      theme: CommonWidget.lightTheme,
    );
  }
}

Future<void> _checkLoggedUser(StorageService storageService, AuthService authController) async {
  final String? data = await storageService.storage.read(key: 'user');
  authController.authenticated = data != null;
  authController.username = data ?? "";
  if(data != null) {
    authController.principal = UserModel.fromJson(jsonDecode(data));
  }
  //


}