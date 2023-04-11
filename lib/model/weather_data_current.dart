import 'package:weather/model/weather/condition.dart';

class WeatherDataCurrent {
  final Current current;
  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json["current"]));
}

class Current {
  double? tempC;
  Condition? condition;
  double? windKph;
  double? feelslikeC;
  double? uv;
  int? humidity;
  int? cloud;

  Current({
    this.tempC,
    this.condition,
    this.windKph,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.uv,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json['temp_c'] as double?,
        condition: json['condition'] == null
            ? null
            : Condition.fromJson(json['condition'] as Map<String, dynamic>),
        windKph: (json['wind_kph'] as num?)?.toDouble(),
        feelslikeC: (json['feelslike_c'] as num?)?.toDouble(),
        uv: json['uv'] as double?,
        humidity: json['humidity'] as int?,
        cloud: json['cloud'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'temp_c': tempC,
        'condition': condition?.toJson(),
        'feelslike_c': feelslikeC,
        'uv': uv,
        'wind_mph': windKph,
        'humidity': humidity,
        'cloud': cloud,
      };
}
