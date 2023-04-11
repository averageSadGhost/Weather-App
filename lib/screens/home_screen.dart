import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:weather/assets_manger.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/utils/custom_colors.dart';
import 'package:weather/widgets/comfort_level.dart';
import 'package:weather/widgets/current_weather_widget.dart';
import 'package:weather/widgets/daily_weather_forecast_widget.dart';
import 'package:weather/widgets/header_widget.dart';
import 'package:weather/widgets/hourly_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.put(
    GlobalController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? const Center(
                  child: Image(image: AssetImage(AssetsManger.cloudsIcon)),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(height: 20),
                    const HeaderWidget(),
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),
                    ),
                    const SizedBox(height: 20),
                    HourlyDataWidget(
                      weatherDataHourly:
                          globalController.getData().getHourlyWeather(),
                    ),
                    DailyDataForecast(
                      dailyData: globalController.getData().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    ComfortLevel(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
