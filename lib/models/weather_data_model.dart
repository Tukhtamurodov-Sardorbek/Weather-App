// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Location location;
  Current current;
  Forecast forecast;

  Weather({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    location: Location.fromJson(json["location"]),
    current: Current.fromJson(json["current"]),
    forecast: Forecast.fromJson(json["forecast"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current": current.toJson(),
    "forecast": forecast.toJson(),
  };
}

/// Location
class Location {
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  int localtimeEpoch;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });


  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"],
    localtime: json["localtime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime_epoch": localtimeEpoch,
    "localtime": localtime,
  };
}

/// Current
class Current {
  int lastUpdatedEpoch;
  String lastUpdated;
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windMph;
  double windKph;
  double windDegree;
  String windDir;
  double pressureMb;
  double pressureIn;
  double precipMm;
  double precipIn;
  int humidity;
  int cloud;
  double feelslikeC;
  double feelslikeF;
  double visKm;
  double visMiles;
  double uv;
  double gustMph;
  double gustKph;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"],
    tempF: json["temp_f"],
    isDay: json["is_day"],
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"],
    windKph: json["wind_kph"],
    windDegree: json["wind_degree"].toDouble(),
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"],
    precipMm: json["precip_mm"],
    precipIn: json["precip_in"],
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"],
    feelslikeF: json["feelslike_f"],
    visKm: json["vis_km"],
    visMiles: json["vis_miles"],
    uv: json["uv"],
    gustMph: json["gust_mph"],
    gustKph: json["gust_kph"],
  );

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
  };
}
// #Current => Condition
class Condition {
  String text;
  String icon;
  int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
    "code": code,
  };
}

/// Forecast
class Forecast {
  List<ForecastDay> forecastDay;

  Forecast({
    required this.forecastDay,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecastDay: List<ForecastDay>.from(json["forecastday"].map((x) => ForecastDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "forecastday": List<dynamic>.from(forecastDay.map((x) => x.toJson())),
  };
}
// #Forecast => ForecastDay
class ForecastDay {
  String date;
  int dateEpoch;
  Day day;
  Astro astro;
  List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => ForecastDay(
    date: json["date"],
    dateEpoch: json["date_epoch"],
    day: Day.fromJson(json["day"]),
    astro: Astro.fromJson(json["astro"]),
    hour: List<Hour>.from(json["hour"].map((x) => Hour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date, // "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}"
    "date_epoch": dateEpoch,
    "day": day.toJson(),
    "astro": astro.toJson(),
    "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
  };
}
// #Forecast => ForecastDay => Day
class Day {
  double maxtempC;
  double maxtempF;
  double mintempC;
  double mintempF;
  double avgtempC;
  double avgtempF;
  double maxwindMph;
  double maxwindKph;
  double totalprecipMm;
  double totalprecipIn;
  double avgvisKm;
  double avgvisMiles;
  double avghumidity;
  int dailyWillItRain;
  int dailyChanceOfRain;
  int dailyWillItSnow;
  int dailyChanceOfSnow;
  Condition condition;
  double uv;

  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"].toDouble(),
    maxtempF: json["maxtemp_f"].toDouble(),
    mintempC: json["mintemp_c"].toDouble(),
    mintempF: json["mintemp_f"].toDouble(),
    avgtempC: json["avgtemp_c"].toDouble(),
    avgtempF: json["avgtemp_f"].toDouble(),
    maxwindMph: json["maxwind_mph"].toDouble(),
    maxwindKph: json["maxwind_kph"].toDouble(),
    totalprecipMm: json["totalprecip_mm"].toDouble(),
    totalprecipIn: json["totalprecip_in"].toDouble(),
    avgvisKm: json["avgvis_km"].toDouble(),
    avgvisMiles: json["avgvis_miles"].toDouble(),
    avghumidity: json["avghumidity"].toDouble(),
    dailyWillItRain: json["daily_will_it_rain"],
    dailyChanceOfRain: json["daily_chance_of_rain"],
    dailyWillItSnow: json["daily_will_it_snow"],
    dailyChanceOfSnow: json["daily_chance_of_snow"],
    condition: Condition.fromJson(json["condition"]),
    uv: json["uv"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxtempC,
    "maxtemp_f": maxtempF,
    "mintemp_c": mintempC,
    "mintemp_f": mintempF,
    "avgtemp_c": avgtempC,
    "avgtemp_f": avgtempF,
    "maxwind_mph": maxwindMph,
    "maxwind_kph": maxwindKph,
    "totalprecip_mm": totalprecipMm,
    "totalprecip_in": totalprecipIn,
    "avgvis_km": avgvisKm,
    "avgvis_miles": avgvisMiles,
    "avghumidity": avghumidity,
    "daily_will_it_rain": dailyWillItRain,
    "daily_chance_of_rain": dailyChanceOfRain,
    "daily_will_it_snow": dailyWillItSnow,
    "daily_chance_of_snow": dailyChanceOfSnow,
    "condition": condition.toJson(),
    "uv": uv,
  };
}
// #Forecast => ForecastDay => Astro
class Astro {
  String sunRise;
  String sunSet;
  String moonRise;
  String moonSet;
  String moonPhase;
  String moonIllumination;

  Astro({
    required this.sunRise,
    required this.sunSet,
    required this.moonRise,
    required this.moonSet,
    required this.moonPhase,
    required this.moonIllumination,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
    sunRise: json["sunrise"],
    sunSet: json["sunset"],
    moonRise: json["moonrise"],
    moonSet: json["moonset"],
    moonPhase: json["moon_phase"],
    moonIllumination: json["moon_illumination"],
  );

  Map<String, dynamic> toJson() => {
    "sunrise": sunRise,
    "sunset": sunSet,
    "moonrise": moonRise,
    "moonset": moonSet,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
  };
}
// #Forecast => ForecastDay => Hour
class Hour {
  int timeEpoch;
  String time;
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windMph;
  double windKph;
  double windDegree;
  String windDir;
  double pressureMb;
  double pressureIn;
  double precipMm;
  double precipIn;
  int humidity;
  int cloud;
  double feelsLikeC;
  double feelsLikeF;
  double windchillC;
  double windchillF;
  double heatIndexC;
  double heatIndexF;
  double dewPointC;
  double dewPointF;
  int willItRain;
  int chanceOfRain;
  int willItSnow;
  int chanceOfSnow;
  double visKm;
  double visMiles;
  double gustMph;
  double gustKph;
  double uv;

  Hour({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatIndexC,
    required this.heatIndexF,
    required this.dewPointC,
    required this.dewPointF,
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
    required this.visMiles,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    timeEpoch: json["time_epoch"],
    time: json["time"],
    tempC: json["temp_c"].toDouble(),
    tempF: json["temp_f"].toDouble(),
    isDay: json["is_day"],
    condition: Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"].toDouble(),
    windKph: json["wind_kph"].toDouble(),
    windDegree: json["wind_degree"].toDouble(),
    windDir: json["wind_dir"],
    pressureMb: json["pressure_mb"].toDouble(),
    pressureIn: json["pressure_in"].toDouble(),
    precipMm: json["precip_mm"].toDouble(),
    precipIn: json["precip_in"].toDouble(),
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelsLikeC: json["feelslike_c"].toDouble(),
    feelsLikeF: json["feelslike_f"].toDouble(),
    windchillC: json["windchill_c"].toDouble(),
    windchillF: json["windchill_f"].toDouble(),
    heatIndexC: json["heatindex_c"].toDouble(),
    heatIndexF: json["heatindex_f"].toDouble(),
    dewPointC: json["dewpoint_c"].toDouble(),
    dewPointF: json["dewpoint_f"].toDouble(),
    willItRain: json["will_it_rain"],
    chanceOfRain: json["chance_of_rain"],
    willItSnow: json["will_it_snow"],
    chanceOfSnow: json["chance_of_snow"],
    visKm: json["vis_km"].toDouble(),
    visMiles: json["vis_miles"].toDouble(),
    gustMph: json["gust_mph"].toDouble(),
    gustKph: json["gust_kph"].toDouble(),
    uv: json["uv"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time_epoch": timeEpoch,
    "time": time,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelsLikeC,
    "feelslike_f": feelsLikeF,
    "windchill_c": windchillC,
    "windchill_f": windchillF,
    "heatindex_c": heatIndexC,
    "heatindex_f": heatIndexF,
    "dewpoint_c": dewPointC,
    "dewpoint_f": dewPointF,
    "will_it_rain": willItRain,
    "chance_of_rain": chanceOfRain,
    "will_it_snow": willItSnow,
    "chance_of_snow": chanceOfSnow,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
    "uv": uv,
  };
}