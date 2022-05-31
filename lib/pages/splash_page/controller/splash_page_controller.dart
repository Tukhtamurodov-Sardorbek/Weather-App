import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather/models/weather_data_model.dart';
import 'package:weather/pages/home_page/ui/home_page_ui.dart';
import 'package:weather/services/hive_service.dart';
import 'package:weather/services/http_service.dart';
import 'package:weather/utils/fetch_data.dart';

class SplashController extends GetxController{
  bool hasInternet = false;
  bool showMessage = false;


  /// Entry point
  Future fetchDataFromServer() async {
    debugPrint('********************* Start *********************');
    await FetchData().fetchData();
    nextPage();
    debugPrint('********************* Finish *********************');
  }

  void nextPage(){
    Future.delayed(const Duration(seconds: 6), () {
      Get.off(() => const HomePage());
    });
  }

  @override
  void onInit() {
    Future.microtask(() async {
      hasInternet = await InternetConnectionChecker().hasConnection;
      update();
      print('Internet: $hasInternet');
      if(hasInternet){
        fetchDataFromServer();
      } else{
        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
        nextPage();
        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
      }
    });
    showMessage = HiveService.loadString(HiveService.key(StorageKeys.PERMISSION)) == 'true';
    super.onInit();
  }

}