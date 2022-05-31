import 'package:get/get.dart';
import 'package:weather/services/hive_service.dart';
import 'package:weather/utils/fetch_data.dart';

class CurrentController extends GetxController{
  bool noData = false;
  List<String> dates = [];
  List<String> location = [];
  List currentWeather = [];
  List upcomingDaysWeather = [];
  List hourlyWeatherData = [];
  /// Load data
  void loadData() {
    // print('Loading data');
    dates = List<String>.from(HiveService.loadData(HiveService.key(StorageKeys.DATE)));
    location = List<String>.from(HiveService.loadData(HiveService.key(StorageKeys.LOCATION)));
    currentWeather = HiveService.loadData(HiveService.key(StorageKeys.CURRENT_WEATHER));
    upcomingDaysWeather = HiveService.loadData(HiveService.key(StorageKeys.FUTURE_WEATHER));
    hourlyWeatherData = HiveService.loadData(HiveService.key(StorageKeys.HOUR));
    update();
  }

  updateData() async{
    await FetchData().fetchData();
  }

  @override
  void onInit() {
    noData = HiveService.loadData(HiveService.key(StorageKeys.DATE)).isEmpty;
    update();
    if(!noData){
      loadData();
    }

    super.onInit();
  }

}