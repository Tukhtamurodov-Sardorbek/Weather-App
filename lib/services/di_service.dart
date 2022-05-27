import 'package:get/get.dart';

class DependencyInjectionService {
  static Future<void> init() async {
    //Get.put<PaymentController>(PaymentController());

    // Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    // Get.lazyPut<CurrentController>(() => CurrentController(), fenix: true);
  }
}