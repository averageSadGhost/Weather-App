import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/utils/custom_colors.dart';
import '../model/weather_data_hourly.dart';

// ignore: must_be_immutable
class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});

  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherDataHourly.hourly.length,
          itemBuilder: (context, index) {
            return Obx(
              (() => GestureDetector(
                    onTap: () => cardIndex.value = index,
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(left: 20, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0.5, 0),
                              blurRadius: 30,
                              spreadRadius: 1,
                              color: CustomColors.dividerLine.withAlpha(150)),
                        ],
                        gradient: cardIndex.value == index
                            ? const LinearGradient(
                                colors: [
                                  CustomColors.firstGradientColor,
                                  CustomColors.secondGradientColor
                                ],
                              )
                            : null,
                      ),
                      child: HourDetails(
                        index: index,
                        cardIndex: cardIndex.value,
                        temp: weatherDataHourly.hourly[index].tempC!,
                        date: weatherDataHourly.hourly[index].time!,
                        weatherIcon:
                            weatherDataHourly.hourly[index].condition!.icon!,
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}

// ignore: must_be_immutable
class HourDetails extends StatelessWidget {
  double temp;
  String date;
  int index;
  int cardIndex;
  String weatherIcon;

  HourDetails(
      {super.key,
      required this.cardIndex,
      required this.index,
      required this.date,
      required this.temp,
      required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    final String time = DateFormat("jm").format(DateTime.parse(date));
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            time,
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image(
            image: NetworkImage("https:$weatherIcon"),
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "${temp.round().toString()}°",
            style: TextStyle(
              color: cardIndex == index
                  ? Colors.white
                  : CustomColors.textColorBlack,
            ),
          ),
        )
      ],
    );
  }
}
