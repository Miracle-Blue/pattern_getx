import 'package:get/get.dart';
import 'package:pattern_getx/controllers/home_controller.dart';
import 'package:pattern_getx/controllers/home_second_controller.dart';

class DIService {
  static Future<void> init() async {
    //Get.put<PaymentController>(PaymentController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<HomeSecondController>(() => HomeSecondController(), fenix: true);
  }
}