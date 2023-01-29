import 'package:forecast_v3/models/models.dart';

AppState appReducer(final AppState state, final dynamic action) {
  return AppState(
    weatherData: weatherDataListReducer(state.weatherData, action),
    locations: locationsListReducer(state.locations, action),
    currentLocationIndex:
        currentLocationIndexReducer(state.currentLocationIndex, action),
    userSettings: userSettingsReducer(state.userSettings, action),
  );
}

weatherDataListReducer(
  final List<WeatherData> weatherData,
  final dynamic action,
) {
  // if (action is something) {
  //   return do stuff;
  // }
  return weatherData;
}

locationsListReducer(
  final List<Location> locations,
  final dynamic action,
) {
  // if (action is something) {
  //   return action.locations;
  // }
  return locations;
}

currentLocationIndexReducer(
  final int currentLocationIndex,
  final dynamic action,
) {
  // if (action is something) {
  //   return action.currentLocationIndex;
  // }
  return currentLocationIndex;
}

userSettingsReducer(
  final UserSettings userSettings,
  final dynamic action,
) {
  // if (action is something) {
  //   return action.userSettings;
  // }
  return userSettings;
}
