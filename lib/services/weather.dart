import 'package:weather_app_flutter/services/location.dart';
import 'package:weather_app_flutter/services/networking.dart';

class WeatherModel {
  var units = "metric";
  var apiKey = "fa14bcab0d873910e99647623b8101d7";
  var openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            "$openWeatherMapUrl?q=$cityName&units=metric" + "&appid=" + apiKey);

    var weatherData = await networkHelper.getWeather();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            "$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}"
                    "&units=metric" +
                "&appid=" +
                apiKey);

    var weatherData = await networkHelper.getWeather();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
