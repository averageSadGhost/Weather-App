import 'package:weather/model/weather/astro.dart';
import 'package:weather/model/weather/day.dart';

class WeatherDataDaily {
  List<Forecastday> forecastDay;
  WeatherDataDaily({required this.forecastDay});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(
        forecastDay: List<Forecastday>.from(
          json["forecast"]["forecastday"].map(
            (e) => Forecastday.fromJson(e),
          ),
        ),
      );
}

class Forecastday {
  String? date;
  int? dateEpoch;
  Day? day;
  Astro? astro;

  Forecastday({this.date, this.dateEpoch, this.day, this.astro});

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
        date: json['date'] as String?,
        dateEpoch: json['date_epoch'] as int?,
        day: json['day'] == null
            ? null
            : Day.fromJson(json['day'] as Map<String, dynamic>),
        astro: json['astro'] == null
            ? null
            : Astro.fromJson(json['astro'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'date_epoch': dateEpoch,
        'day': day?.toJson(),
        'astro': astro?.toJson(),
      };
}
