import 'package:authentications/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthService>();
    return Scaffold(
      appBar: AppBar(title: Text('${authController.principal.name}')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(authController.isAdmin ? 'This is admin Home Page.':'This is user Home Page.'),
            ElevatedButton(onPressed: () async{
              await authController.logout();
              Get.offNamed('/login');
            }, child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}