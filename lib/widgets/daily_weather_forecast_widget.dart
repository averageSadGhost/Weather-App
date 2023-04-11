import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_data_daily.dart';
import 'package:weather/utils/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily dailyData;

  const DailyDataForecast({super.key, required this.dailyData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Next Days",
              style: TextStyle(
                color: CustomColors.textColorBlack,
                fontSize: 17,
              ),
            ),
          ),
          dailyList()
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: dailyData.forecastDay.length,
        itemBuilder: (context, index) {
          var data = dailyData.forecastDay[index];

          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        DateFormat("EEE").format(DateTime.parse(data.date!)),
                        style: const TextStyle(
                            fontSize: 13, color: CustomColors.textColorBlack),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image(
                        image:
                            NetworkImage("https:${data.day!.condition!.icon!}"),
                      ),
                    ),
                    Text(data.day!.avgtempC!.round().toString())
                  ],
                ),
              ),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              )
            ],
          );
        },
      ),
    );
  }
}
