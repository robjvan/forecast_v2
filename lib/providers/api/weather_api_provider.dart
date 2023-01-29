import 'package:flutter/material.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:http/http.dart' as http;

@immutable
class WeatherAPIProvider {
  final String _apiUrl = 'v1/forecast.json?key=${AppKeys.weatherApiKey}&q=';
  final Uri _weatherApi = Uri.parse('http://api.weatherapi.com');
  WeatherAPIProvider();

  Future<http.Response> getWeatherDataFromApi(
    final String? lat,
    final String? long,
  ) =>
      http.get(
        _weatherApi.resolve('$_apiUrl$lat,$long&days=5&aqi=yes&alerts=yes'),
      );
}
