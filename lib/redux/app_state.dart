// ignore_for_file: unnecessary_lambdas

import 'package:forecast/models/models.dart';

class AppState {
  final List<Location> locations;
  final List<WeatherData> weatherData;
  final UserSettings userSettings;
  final int currentLocationIndex;
  final LoadingState loadingState;

  AppState({
    required this.locations,
    required this.weatherData,
    required this.userSettings,
    required this.currentLocationIndex,
    required this.loadingState,
  });

  factory AppState.initial() => AppState(
        locations: <Location>[],
        weatherData: <WeatherData>[],
        userSettings: UserSettings.initial(),
        currentLocationIndex: 0,
        loadingState: LoadingState.done,
      );

  AppState.fromJson(final Map<String, dynamic> json)
      : currentLocationIndex = json['currentLocationIndex'],
        loadingState = LoadingState.done,
        locations = (json['locations'] as List<Location>)
            .map((final dynamic i) => Location.fromJson(i))
            .toList(),
        userSettings = UserSettings.fromJson(json),
        weatherData = <WeatherData>[];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'locations': locations,
        'userSettings': userSettings,
        'currentLocationIndex': currentLocationIndex,
      };
}
