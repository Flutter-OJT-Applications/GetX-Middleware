import 'package:authentications/screens/configs/page_config.dart';
import 'package:authentications/services/auth/auth_service.dart';
import 'package:authentications/services/configs/initial_binding.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final StorageService storageService = Get.put(StorageService());
  final AuthService authController = Get.put(AuthService());
  await _checkLoggedUser(storageService, authController);

  runApp(const AuthenticationApp());
}

class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Authentication Example',
      initialBinding: InitialBinding(),
      initialRoute: '/home',
      getPages: PageConfig.pages,
    );
  }
}

Future<void> _checkLoggedUser(storageService, authController) async {
  final String? data = await storageService.storage.read(key: 'useremail');
  authController.authenticated = data != null;
  authController.useremail = data ?? "";
  authController.userpassword = data ?? "";
}