import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({@required this.url});

  final String url;

  Future getWeather() async {
    // const units = "metric";
    // const apiKey = "fa14bcab0d873910e99647623b8101d7";
    // //const query = "london";
    // var url = "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude"
    //     "&units=" +
    //     units +
    //     "&appid=" +
    //     apiKey;
    // print(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
      // print(data);
      // print(data);
      // var temperature = data['main']['temp'];
      // //   print(temperature);
      //
      // var weatherId = data['weather'][0]["id"];
      //
    //  var cityName = data['name'];
      //print(cityName);
    } else {
      //   print(response.body);
      print(response.statusCode);
    }
  }
}
