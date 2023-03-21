import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class DashboardWidgetsViewModel {
  final List<WeatherData> weatherDataList;
  final int activeLocationIndex;
  final Color cardColor;
  final Color textColor;
  final String currentConditions;
  final String currentTemp;
  final String feelsLikeTemp;
  final Function(int) weatherIcon;

  const DashboardWidgetsViewModel({
    required this.activeLocationIndex,
    required this.cardColor,
    required this.textColor,
    required this.currentConditions,
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.weatherDataList,
    required this.weatherIcon,
  });

  factory DashboardWidgetsViewModel.create(final Store<AppState> store) {
    int getCurrentLocationIndex() {
      return store.state.currentLocationIndex;
    }

    IconData? getWeatherIcon(final int code) {
      bool isDay = false;
      if (store.state.weatherData.isNotEmpty) {
        isDay = store.state.weatherData[getCurrentLocationIndex()]
                .currentConditions.is_day ??
            false;
      }
      return WeatherIconParser.weatherIcon(code, isDay);
    }

    String getCurrentTemp() {
      switch (store.state.userSettings.tempUnits) {
        case TempUnits.c:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c!.round()}°C'
              : '-999';
        case TempUnits.f:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_f!.round()}°F'
              : '-999';
        case TempUnits.k:
          return store.state.weatherData.isNotEmpty
              ? '${(store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c! + 273.15).round()} K'
              : '-999';
        default:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c!.round()}°C'
              : '-999';
      }
    }

    String getFeelsLikeTemp() {
      switch (store.state.userSettings.tempUnits) {
        case TempUnits.c:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c!.round()}°C'
              : '-999';
        case TempUnits.f:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_f!.round()}°F'
              : '-999';
        case TempUnits.k:
          return store.state.weatherData.isNotEmpty
              ? '${(store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c! + 273.15).round()} K'
              : '-999';
        default:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c!.round()}°C'
              : '-999';
      }
    }

    return DashboardWidgetsViewModel(
      weatherDataList: store.state.weatherData,
      activeLocationIndex: getCurrentLocationIndex(),
      feelsLikeTemp: getFeelsLikeTemp(),
      currentTemp: getCurrentTemp(),
      currentConditions: store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .condition!.text!
          : '',
      weatherIcon: getWeatherIcon,
      cardColor: store.state.userSettings.useDarkMode
          ? AppColors.bgColorDarkMode
          : AppColors.bgColorLightMode,
      textColor: store.state.userSettings.useDarkMode
          ? AppColors.textColorDarkMode
          : AppColors.textColorLightMode,
    );
  }
}
