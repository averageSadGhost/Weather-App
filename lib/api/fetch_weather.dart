import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/api/api_key.dart';

import 'package:weather/model/weather_data.dart';
import 'package:weather/model/weather_data_current.dart';
import 'package:weather/model/weather_data_daily.dart';
import 'package:weather/model/weather_data_hourly.dart';

class FetchWeatherApi {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = await jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );

    return weatherData!;
  }
}

String apiUrl(lat, lon) {
  String url;

  url =
      "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$lat, $lon&days=3&aqi=no&alerts=no";
  return url;
}

//http://api.weatherapi.com/v1/forecast.json?key=a7964b315ccd49c8a9430912231104&q=31.197729, 29.892540&days=3&aqi=no&alerts=no
