import 'package:forecast_v3/models/models.dart';

class AppState {
  final List<Location> locations;
  final List<WeatherData> weatherData;
  final UserSettings userSettings;
  final int currentLocationIndex;

  AppState({
    required this.locations,
    required this.weatherData,
    required this.userSettings,
    required this.currentLocationIndex,
  });

  factory AppState.initial() {
    return AppState(
      locations: <Location>[],
      weatherData: <WeatherData>[],
      userSettings: UserSettings.initial(),
      currentLocationIndex: 0,
    );
  }
}
