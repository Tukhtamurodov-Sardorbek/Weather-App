import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather/models/weather_data_model.dart';

class WeatherService {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "api.weatherapi.com";
  static String SERVER_PRODUCTION = "api.weatherapi.com";

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Headers */
  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'key':'3dd28d7360344ed7885101956222003'
    };
    return headers;
  }

  /* Http Apis */
  static String CURRENT_WEATHER_API = "/v1/current.json";
  static String FORECAST_WEATHER_API = "/v1/forecast.json"; // {days (1-10)}
  static String HISTORY_WEATHER_API = "/v1/history.json"; // {dt (dt=2010-01-01)}
  static String FUTURE_WEATHER_API = "/v1/future.json"; // {dt (between 14 days and 300 days from today)}


  /* Http Requests */
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api, params); // http or https
    Response response = await get(uri, headers: getHeaders());
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }


  /* Http Params */
  static Map<String, dynamic> paramGet(String latLong) {
    Map<String, dynamic> params = {
      'q' : latLong,
      'days' : '3'
    };
    return params;
  }

  /* Http parsing */

  static parseResponse(String response) {
    Weather? weather = Weather.fromJson(jsonDecode(response));
    return weather;
  }
}