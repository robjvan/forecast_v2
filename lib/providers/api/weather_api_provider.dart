import 'package:flutter/material.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:http/http.dart' as http;

@immutable
class WeatherAPIProvider {
  final String _apiUrl = 'v1/forecast.json?key=${AppKeys.weatherApiKey}&q=';
  final Uri _weatherApi = Uri.parse('http://api.weatherapi.com');
  WeatherAPIProvider();

  Future<http.Response> getWeatherDataFromApi(
    // final String locationString,
    final String lat,
    final String long,
    final String? lang,
  ) {
    /// Build our base request url
    String requestUrl = '$_apiUrl$lat,$long&days=5&aqi=yes&alerts=yes';

    /// If a language string has been passed in, add it to the request url
    if (lang != null) {
      requestUrl += '&lang=$lang';
    }

    /// Return the response
    return http.get(_weatherApi.resolve(requestUrl));
  }
}
