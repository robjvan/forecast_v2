import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/redux/actions.dart';

AppState appReducer(final AppState state, final dynamic action) {
  return AppState(
    weatherData: weatherDataListReducer(state.weatherData, action),
    locations: locationsListReducer(state.locations, action),
    currentLocationIndex:
        currentLocationIndexReducer(state.currentLocationIndex, action),
    userSettings: userSettingsReducer(state.userSettings, action),
    loadingState: loadingStateReducer(state.loadingState, action),
  );
}

LoadingState loadingStateReducer(
  final LoadingState loadingState,
  final dynamic action,
) {
  // log('[reducers.dart] loadingStateReducer fired! loadingState = $loadingState, action = ${action.runtimeType}');
  if (action is SetLoadingStateAction) {
    return action.loadingState;
  }
  return loadingState;
}

List<WeatherData> weatherDataListReducer(
  final List<WeatherData> weatherDataList,
  final dynamic action,
) {
  // log('[reducers.dart] weatherDataListReducer fired, action = ${action.runtimeType}');
  if (action is UpdateWeatherDataListAction) {
    return action.weatherDataList;
  }
  return weatherDataList;
}

List<Location> locationsListReducer(
  final List<Location> locations,
  final dynamic action,
) {
  // log('[reducers.dart] locationsListReducer fired, action = ${action.runtimeType}');
  if (action is UpdateLocationListAction) {
    return action.locations;
  }
  return locations;
}

int currentLocationIndexReducer(
  final int currentLocationIndex,
  final dynamic action,
) {
  // log('[reducers.dart] currentLocationIndexReducer fired, action = ${action.runtimeType}');
  // if (action is UpdateCurrentLocationIndexAction) {
  //   return action.currentLocationIndex;
  // }
  return currentLocationIndex;
}

UserSettings userSettingsReducer(
  final UserSettings userSettings,
  final dynamic action,
) {
  // log('[reducers.dart] userSettingsReducer fired, action = ${action.runtimeType}');
  // if (action is UpdateUserSettingsAction) {
  //   return action.userSettings;
  // }
  return userSettings;
}
