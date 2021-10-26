import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/instance_manager.dart';
import 'package:jokes_app/controllers/jokes/sbmited_jokes_controller.dart';
import 'controllers/auth_controller/auth_controller.dart';
import 'controllers/jokes/jokes_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    // Get.put<JokesController>(JokesController());
    // Get.put<SubmitedJokesController>(SubmitedJokesController());
  }
}
