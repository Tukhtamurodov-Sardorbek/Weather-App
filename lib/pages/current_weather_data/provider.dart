import 'package:flutter/material.dart';
import 'package:weather/services/hive_service.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  bool _noData = false;
  List<String> _dates = [];
  List<String> _location = [];
  List _currentWeather = [];
  List _upcomingDaysWeather = [];
  List _hourlyWeatherData = [];

  bool get noData => _noData;
  List<String> get dates => _dates;
  List<String> get location => _location;
  List get currentWeather => _currentWeather;
  List get upcomingDaysWeather => _upcomingDaysWeather;
  List get hourlyWeatherData => _hourlyWeatherData;

  /// Load data
  void loadData() {
    _dates = List<String>.from(HiveService.loadData(HiveService.key(StorageKeys.DATE)));
    _location = List<String>.from(HiveService.loadData(HiveService.key(StorageKeys.LOCATION)));
    _currentWeather = HiveService.loadData(HiveService.key(StorageKeys.CURRENT_WEATHER));
    _upcomingDaysWeather = HiveService.loadData(HiveService.key(StorageKeys.FUTURE_WEATHER));
    _hourlyWeatherData = HiveService.loadData(HiveService.key(StorageKeys.HOUR));
    notifyListeners();
  }

  void onInit() {
    _noData = HiveService.loadString(HiveService.key(StorageKeys.IS_EMPTY)) == 'true';
    print('*** No Data: $_noData ***');
    notifyListeners();
    if(!_noData){
      loadData();
    }
  }
}
