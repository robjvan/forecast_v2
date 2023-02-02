import 'package:forecast_v3/models/models.dart';

class UserSettings {
  bool useDarkMode;
  bool useDynamicBackgrounds;
  AQIUnits aqiUnits;
  WindSpeedUnits windSpeedUnits;
  AirPressureUnits airPressureUnits;
  TempUnits tempUnits;

  UserSettings({
    required this.useDarkMode,
    required this.useDynamicBackgrounds,
    required this.aqiUnits,
    required this.windSpeedUnits,
    required this.airPressureUnits,
    required this.tempUnits,
  });

  factory UserSettings.initial() {
    return UserSettings(
      useDarkMode: false,
      useDynamicBackgrounds: true,
      aqiUnits: AQIUnits.us,
      airPressureUnits: AirPressureUnits.kpa,
      windSpeedUnits: WindSpeedUnits.kph,
      tempUnits: TempUnits.c,
    );
  }

  @override
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
