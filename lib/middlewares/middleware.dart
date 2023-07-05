import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/auth/auth_service.dart';

class GlobalMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.authenticated || route == '/login' || route == '/sign-up'
        ? null
        : const RouteSettings(name: '/login');
  }

}