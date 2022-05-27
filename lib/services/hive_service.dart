import 'dart:convert';

import 'package:hive/hive.dart';

enum StorageKeys {
  DATE,
  LOCATION,
  HOUR,
  CURRENT_WEATHER,
  FUTURE_WEATHER,
}

class HiveService {
  static String DB_NAME = 'database';
  static Box box = Hive.box(DB_NAME);

  static String key(StorageKeys key) {
    switch(key) {
      case StorageKeys.DATE: return 'date';
      case StorageKeys.LOCATION: return 'location';
      case StorageKeys.HOUR: return 'hourly_weather';
      case StorageKeys.CURRENT_WEATHER: return 'current_weather';
      case StorageKeys.FUTURE_WEATHER: return 'future_weather';
    }
  }

  /// FOR A STRING
  // static Future<void> storeString (String key, String data) async {
  //   box.put(key, data);
  // }
  //
  // static String loadString(String key){
  //   if(box.containsKey(key)){
  //     String data = box.get(key);
  //     return data;
  //   }
  //   return 'No data';
  // }
  //
  // static Future<void> removeString(String key) async {
  //   box.delete(key);
  // }

  /// FOR A LIST
  static Future<void> storeData (String key, List data) async {
    await box.put(key, data);
  }

  static List loadData(String key){
    if(box.containsKey(key)){
      List data = box.get(key);
      return data;
    }
    return [];
  }

  static Future<void> removeUsers(String key) async {
    await box.delete(key);
  }
}