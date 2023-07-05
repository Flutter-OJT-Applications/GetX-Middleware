import 'package:authentications/services/auth/sign_up_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../commons/common_widget.dart';

class SignUpScreen extends GetView<SignUpService> {
  const SignUpScreen({super.key});

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
                    child: Text('Sign Up', style: CommonWidget.titleText()),
                  ),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: CommonWidget.inputStyle(placeholder: 'Name'),
                    validator: (value) {
                      if(value == null || value.isEmpty) return "Name cannot be empty!";
                      if(value.length < 4) return 'Name must be at least 4 characters';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: CommonWidget.inputStyle(placeholder: 'Email'),
                    validator: (value) {
                      if(value == null || value.isEmpty) return "Email cannot be empty!";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => TextFormField(
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
                        if(value == null || value.isEmpty) return "Password cannot be empty!";
                        if(value.length < 6) return "Password must be at least 6 characters";
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                        () => TextFormField(
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.isConfirmPasswordShowing,
                      decoration: CommonWidget.passwordStyle(
                        placeholder: 'Password',
                        isShow: controller.isConfirmPasswordShowing,
                        onShow: () {
                          controller.isConfirmPasswordShowing =
                          !controller.isConfirmPasswordShowing;
                        },
                      ),
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Password cannot be empty!";
                            if(value.length < 6) return "Password must be at least 6 characters";
                            if(controller.passwordController.text != value)return "Password don't match'";
                            return null;
                          },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.offNamed('/login');
                        },
                        style: CommonWidget.secondaryButtonStyle(),
                        child: const Text('Sign In'),
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          if(controller.key.currentState!.validate()){
                            final success = await controller.signUpUser();
                            if(success) {
                              Get.offNamed('/home');
                            }else{
                              Get.snackbar('Failed to Sign Up', 'Something went wrong!', backgroundColor: Colors.pink);
                            }

                          }
                        },
                        style: CommonWidget.primaryButtonStyle(),
                        child: const Text('Sign Up'),
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
