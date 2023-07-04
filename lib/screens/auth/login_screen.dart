import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/services/prefs/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/registration.dart';

class LoginScreen extends GetView<LoginService> {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                // Retrieve the entered email and password
                final email = _emailController.text;
                final password = _passwordController.text;

                // Perform login logic here
                // For simplicity, let's assume the login is successful

                // Set authentication status
                controller.authService.authenticated = true;

                // Store user information in storage
                await storageService.storage
                    .write(key: 'useremail', value: email);
                await storageService.storage
                    .write(key: 'userpassword', value: password);
                controller.authService.useremail = email;
                controller.authService.userpassword = password;

                // Navigate to the home screen
                Get.offNamed('/home');
              },
            ),
            const SizedBox(height: 16.0),
            TextButton(
              child: const Text('Register'),
              onPressed: () {
                // Perform registration logic here
                // Navigate to the registration screen
                Get.to(() => RegistrationScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
