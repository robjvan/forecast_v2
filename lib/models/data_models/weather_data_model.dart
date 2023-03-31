// ignore_for_file: unnecessary_lambdas

import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';

@immutable
class WeatherData {
  
  final APILocation location;
  final APICurrentConditions currentConditions;
  final APIForecast forecast;
  final List<APIAlert> weatherAlerts;

  const WeatherData({
    required this.location,
    required this.currentConditions,
    required this.forecast,
    required this.weatherAlerts,
  });

  @override
  factory WeatherData.initial() => WeatherData(
        location: APILocation.createEmpty(),
        currentConditions: APICurrentConditions.createEmpty(),
        forecast: APIForecast.createEmpty(),
        weatherAlerts: const <APIAlert>[],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'location': location,
        'currentConditions': currentConditions,
        'forecast': forecast,
        'weatherAlerts': weatherAlerts
      };

  @override
  WeatherData.fromJson(final Map<String, dynamic> json)
      : location = APILocation.fromJson(json['location']),
        currentConditions = APICurrentConditions.fromJson(json['current']),
        forecast = APIForecast.fromJson(json['forecast']),
        weatherAlerts = (json['alerts']['alert'] as List<dynamic>)
            .map((final dynamic i) => APIAlert.fromJson(i))
            .toList();
}
