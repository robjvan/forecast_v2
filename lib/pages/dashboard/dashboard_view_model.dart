import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class DashboardPageViewModel {
  final String currentTemp;
  final LoadingState loadingState;
  final String name;
  final List<WeatherData> weatherDataList;
  final List<Location> locationList;
  final int activeLocationIndex;
  final Function(dynamic) dispatch;
  final Function(int) weatherType;
  final List<APIAlert> activeAlerts;
  final bool useDynamicBackgrounds;
  final Color cardColor;
  final Color textColor;
  final String currentConditions;

  const DashboardPageViewModel({
    required this.currentTemp,
    required this.name,
    required this.loadingState,
    required this.weatherDataList,
    required this.locationList,
    required this.activeLocationIndex,
    required this.dispatch,
    required this.weatherType,
    required this.activeAlerts,
    required this.useDynamicBackgrounds,
    required this.cardColor,
    required this.textColor,
    required this.currentConditions,
  });

  factory DashboardPageViewModel.create(final Store<AppState> store) {
    int getCurrentLocationIndex() {
      return store.state.currentLocationIndex;
    }

    List<WeatherData> populateWeatherData() {
      // final List<WeatherData> weatherDataList = <WeatherData>[];
      // for (final WeatherData wd in store.state.weatherData) {
      //   weatherDataList.add(wd);
      // }
      // return weatherDataList;

      return store.state.weatherData.map((final WeatherData wd) => wd).toList();
    }

    List<Location> populateLocationsList() {
      // final List<Location> locationsList = <Location>[];
      // for (final Location loc in store.state.locations) {
      //   locationsList.add(loc);
      // }
      // return locationsList;

      return store.state.locations.map((final Location loc) => loc).toList();
    }

    WeatherType? weatherType(final int code) {
      bool isDay = false;
      if (store.state.weatherData.isNotEmpty) {
        isDay = store.state.weatherData[getCurrentLocationIndex()]
                .currentConditions.is_day ??
            false;
      }
      return WeatherIconParser.weatherType(code, isDay);
    }

    List<APIAlert> getActiveAlerts() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts
          : <APIAlert>[];
    }

    String getCurrentTemp() {
      switch (store.state.userSettings.tempUnits) {
        case TempUnits.c:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c!.round()}c'
              : '-999';
        case TempUnits.f:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_f!.round()}f'
              : '-999';
        case TempUnits.k:
          return store.state.weatherData.isNotEmpty
              ? '${(store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c! + 273.15).round()}k'
              : '-999';
      }
    }

    return DashboardPageViewModel(
      currentTemp: getCurrentTemp(),
      name: store.state.locations.isNotEmpty
          ? store.state.locations[getCurrentLocationIndex()].name != null
              ? store.state.locations[getCurrentLocationIndex()].name!
              : ''
          : '',
      loadingState: store.state.loadingState,
      weatherDataList: populateWeatherData(),
      locationList: populateLocationsList(),
      activeLocationIndex: store.state.currentLocationIndex,
      dispatch: store.dispatch,
      weatherType: weatherType,
      activeAlerts: getActiveAlerts(),
      useDynamicBackgrounds: store.state.userSettings.useDynamicBackgrounds,
      cardColor: store.state.userSettings.useDarkMode
          ? AppColors.bgColorDarkMode.withOpacity(0.6)
          : AppColors.bgColorLightMode.withOpacity(0.6),
      textColor: store.state.userSettings.useDarkMode
          ? AppColors.textColorDarkMode
          : AppColors.textColorLightMode,
      currentConditions: store.state.weatherData[getCurrentLocationIndex()]
          .currentConditions.condition!.text!,
    );
  }
}
