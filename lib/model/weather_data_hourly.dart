import 'package:weather/model/weather/condition.dart';

class WeatherDataHourly {
  List<Hour> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
        hourly: List<Hour>.from(
          json["forecast"]["forecastday"][0]["hour"].map(
            (e) => Hour.fromJson(e),
          ),
        ),
      );
}

class Hour {
  int? timeEpoch;
  String? time;
  double? tempC;
  Condition? condition;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.condition,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        timeEpoch: json['time_epoch'] as int?,
        time: json['time'] as String?,
        tempC: (json['temp_c'] as num?)?.toDouble(),
        condition: json['condition'] == null
            ? null
            : Condition.fromJson(json['condition'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'time_epoch': timeEpoch,
        'time': time,
        'temp_c': tempC,
        'condition': condition?.toJson(),
      };
}
