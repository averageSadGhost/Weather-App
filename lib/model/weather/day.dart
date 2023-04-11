import 'condition.dart';

class Day {
  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  double? maxwindKph;

  Condition? condition;
  Day({
    this.maxtempC,
    this.mintempC,
    this.avgtempC,
    this.maxwindKph,
    this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        maxtempC: (json['maxtemp_c'] as num?)?.toDouble(),
        mintempC: (json['mintemp_c'] as num?)?.toDouble(),
        avgtempC: (json['avgtemp_c'] as num?)?.toDouble(),
        maxwindKph: (json['maxwind_kph'] as num?)?.toDouble(),
        condition: json['condition'] == null
            ? null
            : Condition.fromJson(json['condition'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'maxtemp_c': maxtempC,
        'mintemp_c': mintempC,
        'avgtemp_c': avgtempC,
        'maxwind_kph': maxwindKph,
        'condition': condition?.toJson(),
      };
}
