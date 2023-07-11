import 'package:authentications/middlewares/middleware.dart';
import 'package:authentications/screens/auth/login_screen.dart';
import 'package:authentications/screens/auth/sign_up_screen.dart';
import 'package:authentications/screens/home/home_screen.dart';
import 'package:authentications/services/auth/sign_up_service.dart';
import 'package:authentications/services/auth/login_service.dart';
import 'package:get/get.dart';

import '../../services/todo/todo_service.dart';
import '../todo/todo_detail_screen.dart';

class PageConfig {
  static final List<GetPage> pages = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TodoService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/sign-up',
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() {
        Get.put(SignUpService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/todo-details',
      page: () => const TodoDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(TodoService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
  ];
}
