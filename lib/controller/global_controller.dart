import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/api/fetch_weather.dart';
import 'package:weather/model/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool _isloading = true.obs;
  final RxDouble _lattiude = 0.0.obs;
  final RxDouble _longtiude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isloading;
  RxDouble getLattitude() => _lattiude;
  RxDouble getLongtitude() => _longtiude;

  final weatherData = WeatherData().obs;
  WeatherData getData() => weatherData.value;

  @override
  void onInit() {
    if (_isloading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission denied forever!");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _lattiude.value = value.latitude;
      _longtiude.value = value.longitude;

      return FetchWeatherApi()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isloading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
