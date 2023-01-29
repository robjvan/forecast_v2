import 'package:forecast_v3/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class APIForecast extends Entity<APIForecast> {
  final List<APIForecastDay>? forecastday;

  const APIForecast({this.forecastday});

  @override
  factory APIForecast.createEmpty() =>
      const APIForecast(forecastday: <APIForecastDay>[]);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APIForecast && other.forecastday == forecastday;

  @override
  int get hashCode => forecastday.hashCode;

  @override
  APIForecast copyWith({final List<APIForecastDay>? forecastday}) =>
      APIForecast(forecastday: forecastday ?? this.forecastday);

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'forecastday': forecastday};

  @override
  APIForecast.fromJson(final dynamic json)
      : forecastday = (json['forecastday'] as List<dynamic>)
            .map((final dynamic i) => APIForecastDay.fromJson(i))
            .toList();

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid => forecastday != null;
}
