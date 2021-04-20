import 'package:flutter/material.dart';
import 'package:weather_app_flutter/screens/city_screen.dart';
import 'package:weather_app_flutter/services/weather.dart';
import 'package:weather_app_flutter/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.weatherData});
  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String weatherIcon;
  String cityName;
  WeatherModel weatherModel = WeatherModel();
  String message;

  @override
  void initState() {
    // TODO: implement initState
    updateUI(widget.weatherData);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = "Error";
        message = "Unable to get weather data";
        cityName = '';
        return;
      } else {
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        int condition = weatherData['weather'][0]['id'];
        cityName = weatherData['name'];

        weatherIcon = weatherModel.getWeatherIcon(condition);
        message = weatherModel.getMessage(temperature);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          var weatherData =
                              await WeatherModel().getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var typeName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CityScreen()));
                          print(typeName);
                          if (typeName != null) {
                            var weatherData =
                             await   weatherModel.getCityWeather(typeName);

                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "$temperature°",
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      '$message in $cityName',
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
