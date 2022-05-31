import 'package:get/get.dart';
import 'package:weather/pages/current_weather_page/controller/current_weather_page_controller.dart';
import 'package:weather/pages/forecast_weather_page/controller/forecast_page_controller.dart';
import 'package:weather/pages/home_page/controller/home_controller.dart';
import 'package:weather/utils/fetch_data.dart';

class DependencyInjectionService {
  static Future<void> init() async {
    //Get.put<PaymentController>(PaymentController());

    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ForecastController>(() => ForecastController(), fenix: true);
    Get.lazyPut<CurrentController>(() => CurrentController(), fenix: true);
    Get.lazyPut<FetchData>(() => FetchData(), fenix: true);
  }
}