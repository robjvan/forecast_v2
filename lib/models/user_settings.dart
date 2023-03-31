import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';

@immutable
class UserSettings {
  final bool useDarkMode;
  final bool useDynamicBackgrounds;
  final AQIUnits aqiUnits;
  final WindSpeedUnits windSpeedUnits;
  final AirPressureUnits airPressureUnits;
  final TempUnits tempUnits;

  const UserSettings({
    required this.useDarkMode,
    required this.useDynamicBackgrounds,
    required this.aqiUnits,
    required this.windSpeedUnits,
    required this.airPressureUnits,
    required this.tempUnits,
  });

  factory UserSettings.initial() {
    return const UserSettings(
      useDarkMode: false,
      useDynamicBackgrounds: true,
      aqiUnits: AQIUnits.us,
      airPressureUnits: AirPressureUnits.kpa,
      windSpeedUnits: WindSpeedUnits.kph,
      tempUnits: TempUnits.c,
    );
  }

  UserSettings copyWith({
    final bool? useDarkMode,
    final bool? useDynamicBackgrounds,
    final AQIUnits? aqiUnits,
    final WindSpeedUnits? windSpeedUnits,
    final AirPressureUnits? airPressureUnits,
    final TempUnits? tempUnits,
  }) =>
      UserSettings(
        useDarkMode: useDarkMode ?? this.useDarkMode,
        useDynamicBackgrounds:
            useDynamicBackgrounds ?? this.useDynamicBackgrounds,
        tempUnits: tempUnits ?? this.tempUnits,
        aqiUnits: aqiUnits ?? this.aqiUnits,
        windSpeedUnits: windSpeedUnits ?? this.windSpeedUnits,
        airPressureUnits: airPressureUnits ?? this.airPressureUnits,
      );

  factory UserSettings.fromJson(final Map<String, dynamic> json) {
    return UserSettings(
      airPressureUnits:
          AirPressureUnits.values.elementAt(json['airPressureUnits']),
      aqiUnits: AQIUnits.values.elementAt(json['aqiUnits']),
      useDarkMode: json['useDarkMode'],
      useDynamicBackgrounds: json['useDynamicBackgrounds'],
      windSpeedUnits: WindSpeedUnits.values.elementAt(json['windSpeedUnits']),
      tempUnits: TempUnits.values.elementAt(json['tempUnits']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'useDarkMode': useDarkMode,
        'useDynamicBackgrounds': useDynamicBackgrounds,
        'aqiUnits': aqiUnits.index,
        'airPressureUnits': airPressureUnits.index,
        'windSpeedUnits': windSpeedUnits.index,
        'tempUnits': tempUnits.index,
      };
}
