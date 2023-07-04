import 'package:authentications/services/login/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../services/auth/auth_service.dart';

class GlobalMiddleware extends GetMiddleware {
  final authController = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authController.authenticated || route == '/login'
        ? null
        : const RouteSettings(name: '/login');
  }
  //
  // @override
  // GetPage? onPageCalled(GetPage? page) {
  //   print('>>> Page ${page!.name} called');
  //   print('>>> User ${authController.username} logged');
  //   return page;
  // }
  //
  // @override
  // GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
  //   print('Bindings of ${page.toString()} are ready');
  //   return page;
  // }
  //
  // @override
  // Widget onPageBuilt(Widget page) {
  //   print('Widget ${page.toStringShort()} will be showed');
  //   return page;
  // }

}