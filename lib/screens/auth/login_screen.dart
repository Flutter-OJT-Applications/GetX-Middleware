import 'package:authentications/screens/commons/common_widget.dart';
import 'package:authentications/services/auth/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginService> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.key,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Text('Login', style: CommonWidget.titleText()),
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: CommonWidget.inputStyle(placeholder: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Email cannot be empty!";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => TextFormField(
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordShowing,
                        decoration: CommonWidget.passwordStyle(
                          placeholder: 'Password',
                          isShow: controller.isPasswordShowing,
                          onShow: () {
                            controller.isPasswordShowing =
                                !controller.isPasswordShowing;
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Password cannot be null";
                          if (value.length < 6)
                            return "Password must be at least 6 characters";
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.offNamed('/sign-up');
                        },
                        style: CommonWidget.secondaryButtonStyle(),
                        child: const Text('Sign Up'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (controller.key.currentState!.validate()) {
                            final success = await controller.login();
                            if (!success) {
                              Get.snackbar('Failed to Login!',
                                  'Invalid email or password!',
                                  backgroundColor: Colors.pink,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(10),
                              );
                            } else {
                              Get.offNamed('/home');
                            }
                          }
                        },
                        style: CommonWidget.primaryButtonStyle(),
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
