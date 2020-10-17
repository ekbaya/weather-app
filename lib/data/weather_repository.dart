import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/Weather.dart';

class WeatherRepository{
  Future<Weather> seachWeather(String city) async{
    final result = await http.Client().get("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=30126aa594bdd780bc66322d3e35e9d9");
    
    if(result.statusCode != 200)
      NetworkError();
    
    return parsedJson(result.body);
  }
  
  Weather parsedJson(final response){
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return Weather.fromJson(jsonWeather);
  }
}

class NetworkError extends Error {}