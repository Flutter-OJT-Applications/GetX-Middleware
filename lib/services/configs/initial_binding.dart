import 'package:authentications/services/user/user_service.dart';
import 'package:get/instance_manager.dart';


class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(() => UserService());
  }
}