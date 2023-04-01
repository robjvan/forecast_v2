import 'package:flutter/material.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class CurrentConditionsViewModel {
  final List<WeatherData> weatherDataList;
  final int activeLocationIndex;
  final Color cardColor;
  final Color textColor;

  final String currentConditions;
  final String currentTemp;
  final String feelsLikeTemp;

  final String conditionsIconUrl;
  final bool activeWeatherAlert;

  const CurrentConditionsViewModel({
    required this.weatherDataList,
    required this.activeLocationIndex,
    required this.cardColor,
    required this.textColor,
    required this.currentConditions,
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.conditionsIconUrl,
    required this.activeWeatherAlert,
  });

  factory CurrentConditionsViewModel.create(final Store<AppState> store) {
    /// Fetch our current location index so we grab the right weather data
    int getCurrentLocationIndex() {
      return store.state.currentLocationIndex;
    }

    /// Fetch the current conditions string based on location index
    String getCurrentConditionsString() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .condition!.text!
          : '';
    }

    /// Fetch current temp value based on user's temp units and location index
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
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_k!.round()} K'
              : '-999';
        default:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c!.round()}°C'
              : '-999';
      }
    }

    /// Fetch current humidity value based on user's temp units and location index
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
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_k!.round()} K'
              : '-999';
        default:
          return store.state.weatherData.isNotEmpty
              ? '${store.state.weatherData[getCurrentLocationIndex()].currentConditions.temp_c!.round()}°C'
              : '-999';
      }
    }

    String getConditionsIconUrl() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .condition!.icon!
          : '';
    }

    bool checkAlertStatus() {
      bool result = false;

      if (store.state.weatherData.isNotEmpty) {
        result = store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty;
      }
      return result;
    }

    return CurrentConditionsViewModel(
      feelsLikeTemp: getFeelsLikeTemp(),
      currentTemp: getCurrentTemp(),
      currentConditions: getCurrentConditionsString(),
      cardColor: AppColors.getCardColor(store),
      textColor: AppColors.getTextColor(store),
      weatherDataList: store.state.weatherData,
      activeLocationIndex: getCurrentLocationIndex(),
      conditionsIconUrl: getConditionsIconUrl(),
      activeWeatherAlert: checkAlertStatus(),
    );
  }
}
