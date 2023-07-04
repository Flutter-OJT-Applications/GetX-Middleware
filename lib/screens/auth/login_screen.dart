import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginService> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Login'),
          onPressed: () async {
            controller.authController.authenticated = true;
            String name = "Mg Mg";
            await storageService.storage.write(key: 'user', value: name);
            controller.authController.username = name;
            Get.offNamed('/home');
          },
        ),
      ),
    );
  }
}