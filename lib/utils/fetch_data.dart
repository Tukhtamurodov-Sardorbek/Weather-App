import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/services/hive_service.dart';
import 'package:weather/services/http_service.dart';
import 'package:weather/models/weather_data_model.dart';

class FetchData extends ChangeNotifier{
  Weather? _weatherData;
  Position? position;

  Weather? get weatherData => _weatherData;
  set weatherData (Weather? data){
    _weatherData = data;
    notifyListeners();
  }

  updateDialogVisibility(bool showDialog){
    HiveService.storeString(HiveService.key(StorageKeys.PERMISSION), showDialog.toString());
  }

  /// Location
  Future<Position> _getGeoLocationPosition() async {
    debugPrint('~~~~~~~~~~ Location Requesting ~~~~~~~~~~');
    // #Getting the position coordinates
    bool isEnabled;
    LocationPermission permission;

    // Check if the location services are enabled.
    isEnabled = await Geolocator.isLocationServiceEnabled();

    // In case the location services are disabled => request to enable it
    if (!isEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      while (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

    // In case the location services are denied forever => handle appropriately.
    if (permission == LocationPermission.deniedForever) {
      Future.delayed(const Duration(milliseconds: 500), (){
        updateDialogVisibility(true);
      });
      Future.delayed(const Duration(seconds: 5), (){
        updateDialogVisibility(false);
        // exit(0);
      });
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }


    // In case it is granted => access the position of the device.
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    debugPrint('~~~~~~~~~~ Location Requesting Finish ~~~~~~~~~~');
    return _position;

  }

  /// Request Weather Data
  Future _weather(String latLong) async {
    debugPrint('~~~~~~~~~~ Fetch Request ~~~~~~~~~~');
    // My location: 41.32,69.25
    String? weather = await WeatherService.GET(
      WeatherService.FORECAST_WEATHER_API,
      WeatherService.paramGet(latLong),
    );
    debugPrint('~~~~~~~~~~ Fetched Data ~~~~~~~~~~');
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    print(weather);
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

    // In success case
    if(weather != null){
      weatherData = await WeatherService.parseResponse(weather);
    }
    if (weatherData != null) {
      /// Store data appropriately
      _datesAndLocation(weatherData!);
      _currentData(weatherData!);
      _upcomingDaysData(weatherData!);
      _hourlyData(weatherData!);
    }
  }

  /// Store dates & location in Local Database
  void _datesAndLocation(Weather weatherData) {
    String currentDate = weatherData.location.localtime.substring(0, 10).trim();
    String nextFirstDate = weatherData.forecast.forecastDay[1].date;
    String nextSecondDate = weatherData.forecast.forecastDay[2].date;
    List<String> location = [
      weatherData.location.region,
      weatherData.location.country
    ];

    /// Store the data in local database
    HiveService.storeData(HiveService.key(StorageKeys.DATE), [currentDate, nextFirstDate, nextSecondDate]);
    HiveService.storeData(HiveService.key(StorageKeys.LOCATION), location);
  }
  /// Store current weather data in Local Database
  void _currentData(Weather weatherData){
    /// Store current weather data
    String conditionText = weatherData.current.condition.text;
    String conditionIconURL = weatherData.current.condition.icon;
    double tempC = weatherData.current.tempC;
    double feelsLikeC = weatherData.current.feelslikeC;
    double pressureIn = weatherData.current.pressureIn;
    int cloud = weatherData.current.cloud;
    int humidity = weatherData.current.humidity;
    double windKph = weatherData.current.windKph;
    double gustKph = weatherData.current.gustKph;
    double windDegree = weatherData.current.windDegree;
    String windDirection = weatherData.current.windDir;

    /// Store current astro
    String sunRise = weatherData.forecast.forecastDay.first.astro.sunRise;
    String sunSet = weatherData.forecast.forecastDay.first.astro.sunSet;


    /// Current Weather Data List
    List currentData = [
      conditionIconURL, // 0
      conditionText, // 1
      tempC, // 2
      feelsLikeC, // 3
      pressureIn, // 4
      cloud, // 5
      humidity, // 6
      windKph, // 7
      windDegree, // 8
      windDirection, // 9
      gustKph, // 10
      sunRise, // 11
      sunSet // 12
    ];

    /// Store the data in local database
    HiveService.storeData(HiveService.key(StorageKeys.CURRENT_WEATHER), currentData);
  }
  /// Store upcoming weather data in Local Database
  void _upcomingDaysData(Weather weatherData){
    List data = [];

    for(int i = 1; i < 3; i++){
      /// Day
      double maxTempC = weatherData.forecast.forecastDay[i].day.maxtempC;
      double minTempC = weatherData.forecast.forecastDay[i].day.mintempC;
      double avgTempC = weatherData.forecast.forecastDay[i].day.avgtempC;
      double maxWindKph = weatherData.forecast.forecastDay[i].day.maxwindKph;
      double avgHumidity = weatherData.forecast.forecastDay[i].day.avghumidity;
      int willItRain = weatherData.forecast.forecastDay[i].day.dailyWillItRain;
      int chanceOfRain = weatherData.forecast.forecastDay[i].day.dailyChanceOfRain;
      int willItSnow = weatherData.forecast.forecastDay[i].day.dailyWillItSnow;
      int chanceOfSnow = weatherData.forecast.forecastDay[i].day.dailyChanceOfSnow;
      /// Day => Condition
      String conditionText = weatherData.forecast.forecastDay[i].day.condition.text;
      String conditionIconURL = weatherData.forecast.forecastDay[i].day.condition.icon;

      /// Astro
      String sunRise = weatherData.forecast.forecastDay[1].astro.sunRise;
      String sunSet = weatherData.forecast.forecastDay[1].astro.sunSet;

      data.add([
        maxTempC, // 0
        minTempC, // 1
        avgTempC, // 2
        maxWindKph, // 3
        avgHumidity, // 4
        willItRain, // 5
        chanceOfRain, // 6
        willItSnow, // 7
        chanceOfSnow, // 8
        conditionText, // 9
        conditionIconURL, // 10
        sunRise, // 11
        sunSet // 12
      ]);
    }

    /// Store the data in local database
    HiveService.storeData(HiveService.key(StorageKeys.FUTURE_WEATHER), data);
  }
  /// Store hourly weather data in Local Database
  void _hourlyData(Weather weatherData) {
    List hourlyDataList = [];
    List hours = [];

    for(int i = 0; i < 3; i++){
      for(int j = 0; j < 24; j++){
        String time = weatherData.forecast.forecastDay[i].hour[j].time;
        double tempC = weatherData.forecast.forecastDay[i].hour[j].tempC;
        String conditionText = weatherData.forecast.forecastDay[i].hour[j].condition.text;
        String conditionIconURL = weatherData.forecast.forecastDay[i].hour[j].condition.icon;

        hours.add([
          time,
          conditionIconURL,
          conditionText,
          tempC,
        ]);
      }
      hourlyDataList.add(hours);
      hours = [];
    }

    /// Store the data in local database
    HiveService.storeData(HiveService.key(StorageKeys.HOUR), hourlyDataList);
  }

  void checkDatabase(){
    bool dates = HiveService.loadData(HiveService.key((StorageKeys.DATE))).isEmpty;
    bool location = HiveService.loadData(HiveService.key((StorageKeys.LOCATION))).isEmpty;
    bool currentData = HiveService.loadData(HiveService.key((StorageKeys.CURRENT_WEATHER))).isEmpty;
    bool upcomingData = HiveService.loadData(HiveService.key((StorageKeys.FUTURE_WEATHER))).isEmpty;
    bool hourlyData = HiveService.loadData(HiveService.key((StorageKeys.HOUR))).isEmpty;

    bool checkDates = dates ?  false : HiveService.loadData(HiveService.key((StorageKeys.DATE))).first.toString() == weatherData?.location.localtime.substring(0, 10).trim();
    bool checkLocation = location ?  false : HiveService.loadData(HiveService.key((StorageKeys.LOCATION))).first.toString() == weatherData?.location.region.toString();
    bool checkCurrentData = currentData ?  false : HiveService.loadData(HiveService.key((StorageKeys.CURRENT_WEATHER)))[2].toString() == weatherData?.current.tempC.toString();
    bool checkUpcomingData = upcomingData ?  false : HiveService.loadData(HiveService.key((StorageKeys.FUTURE_WEATHER)))[0][0].toString() == weatherData?.forecast.forecastDay[1].day.maxtempC.toString();
    bool checkHourlyData = hourlyData ?  false : HiveService.loadData(HiveService.key((StorageKeys.HOUR)))[0][0][0].toString() == weatherData?.forecast.forecastDay[0].hour[0].time.toString();

    debugPrint('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    debugPrint('Check Stored Data');
    debugPrint(dates ? '' :  '* \t Date: ${HiveService.loadData(HiveService.key((StorageKeys.DATE))).first} | Server: ${weatherData?.location.localtime.substring(0, 10).trim()}');
    debugPrint(location ? '' :  '* \t Location: ${HiveService.loadData(HiveService.key((StorageKeys.LOCATION))).first} | Server: ${weatherData?.location.region}');
    debugPrint(currentData ? '' :  '* \t Current Data: ${HiveService.loadData(HiveService.key((StorageKeys.CURRENT_WEATHER)))[2]} | Server: ${weatherData?.current.tempC}');
    debugPrint(upcomingData ? '' :  '* \t Upcoming Data: ${HiveService.loadData(HiveService.key((StorageKeys.FUTURE_WEATHER)))[0][0]} | Server: ${weatherData?.forecast.forecastDay[1].day.maxtempC}');
    debugPrint(hourlyData ? '' :  '* \t Hourly Data: ${HiveService.loadData(HiveService.key((StorageKeys.HOUR)))[0][0][0]} | Server: ${weatherData?.forecast.forecastDay[0].hour[0].time}');

    bool noStored = dates && location && currentData && upcomingData && hourlyData;
    bool allStored = checkDates && checkLocation && checkCurrentData && checkUpcomingData && checkHourlyData;
    debugPrint('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    debugPrint('* Is empty: $noStored');
    debugPrint('* Result: $allStored');
    HiveService.storeString(HiveService.key(StorageKeys.IS_EMPTY), noStored.toString());
    HiveService.storeString(HiveService.key(StorageKeys.ALL_DATA_ARE_STORED), allStored.toString());
  }


  /// Fetch data from Server
  Future<void> fetchData() async{
    debugPrint('~~~~~~~~~~ Operation Started ~~~~~~~~~~');
    position = await _getGeoLocationPosition();
    debugPrint('Location: $position');
    /// Fetch data
    await _weather('${position!.latitude},${position!.longitude}');
  }
}