import 'package:get/get.dart';
import 'package:pattern_getx/controllers/home_controller.dart';
import 'package:pattern_getx/controllers/home_second_controller.dart';

class ControllersBinding implements Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<HomeController>(HomeController());
    Get.put<HomeSecondController>(HomeSecondController());
  }
}