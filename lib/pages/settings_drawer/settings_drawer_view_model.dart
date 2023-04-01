import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class SettingsDrawerViewModel {
  final Color cardColor;
  final Color textColor;
  final Color drawerColor;
  final bool useDarkMode;
  final bool useAnimatedBackgrounds;
  final Function toggleAnimatedBackgrounds;
  final Function toggleDarkMode;
  final Function(int) updateTempUnits;
  final Function(int) updateWindSpeedUnits;
  final Function(int) updateAirPressureUnits;
  final Function(int) updateAQIUnits;
  final List<WeatherData?> weatherDataList;
  final String tempUnits;
  final AirPressureUnits airPressureUnits;
  final WindSpeedUnits windSpeedUnits;
  final AQIUnits aqiUnits;
  final Function(int, int) weatherType;
  final int activeIndex;
  final Function(dynamic) dispatch;
  final Function updateCurrentIndex;
  final Function() saveUserSettings;
  final Function updateWeatherData;

  const SettingsDrawerViewModel({
    required this.cardColor,
    required this.weatherType,
    required this.textColor,
    required this.drawerColor,
    required this.useDarkMode,
    required this.useAnimatedBackgrounds,
    required this.toggleAnimatedBackgrounds,
    required this.toggleDarkMode,
    required this.updateTempUnits,
    required this.updateWindSpeedUnits,
    required this.updateAirPressureUnits,
    required this.updateAQIUnits,
    required this.weatherDataList,
    required this.tempUnits,
    required this.airPressureUnits,
    required this.windSpeedUnits,
    required this.aqiUnits,
    required this.activeIndex,
    required this.dispatch,
    required this.updateCurrentIndex,
    required this.saveUserSettings,
    required this.updateWeatherData,
  });

  factory SettingsDrawerViewModel.create(final Store<AppState> store) {
    int getActiveLocationIndex() => store.state.currentLocationIndex;

    void toggleDarkMode() {
      store.dispatch(toggleDarkModeAction);
    }

    void toggleAnimatedBackgrounds() {
      store.dispatch(toggleAnimatedBackgroundsAction);
    }

    void updateTempUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(changeTempUnitsAction(TempUnits.c));
          break;
        case 1:
          store.dispatch(changeTempUnitsAction(TempUnits.f));
          break;
        case 2:
          store.dispatch(changeTempUnitsAction(TempUnits.k));
          break;
      }
    }

    void updateWindSpeedUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(changeWindSpeedUnitsAction(WindSpeedUnits.kph));
          break;
        case 1:
          store.dispatch(changeWindSpeedUnitsAction(WindSpeedUnits.mph));
          break;
        case 2:
          store.dispatch(changeWindSpeedUnitsAction(WindSpeedUnits.knots));
          break;
        case 3:
          store.dispatch(changeWindSpeedUnitsAction(WindSpeedUnits.ms));
          break;
      }
    }

    void updateAirPressureUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(
            changeAirPressureUnitsAction(AirPressureUnits.kpa),
          );
          break;
        case 1:
          store.dispatch(
            changeAirPressureUnitsAction(AirPressureUnits.inch),
          );
          break;
        case 2:
          store.dispatch(
            changeAirPressureUnitsAction(AirPressureUnits.mbar),
          );
          break;
        case 3:
          store.dispatch(
            changeAirPressureUnitsAction(AirPressureUnits.atm),
          );
          break;
      }
    }

    void updateAQIUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(changeAQIUnitsAction(AQIUnits.us));
          break;
        case 1:
          store.dispatch(changeAQIUnitsAction(AQIUnits.gb));
          break;
      }
    }

    String getTempUnitsString() {
      switch (store.state.userSettings.tempUnits) {
        case TempUnits.c:
          return 'c';
        case TempUnits.f:
          return 'F';
        case TempUnits.k:
          return 'K';
      }
    }

    WeatherType weatherType(final int code, final int index) {
      bool isDay = false;
      if (store.state.weatherData.isNotEmpty) {
        isDay = store.state.weatherData[getActiveLocationIndex()]
                .currentConditions.is_day ??
            false;
      }
      final WeatherType wt = WeatherIconParser.weatherType(code, isDay)!;
      return wt;
    }

    void updateCurrentIndex(final Location location) {
      final int locationIndex = store.state.locations.indexOf(location);

      /// Update active index to newly added location
      store.dispatch(
        UpdateCurrentLocationIndexAction(locationIndex),
      );

      store.dispatch(saveLocationIndexAction);
    }

    void saveUserSettings() {
      store.dispatch(
        saveUserSettingsAction(store.state.userSettings),
      );
      store.dispatch(
        saveLocationIndexAction,
      );
    }

    Future<void> updateWeatherData() async {
      for (int i = 0; i < store.state.weatherData.length; i++) {
        await store.dispatch(fetchWeatherDataAction(i, false));
      }
      store.dispatch(const SetLoadingStateAction(LoadingState.done));
    }

    return SettingsDrawerViewModel(
      activeIndex: store.state.currentLocationIndex,
      aqiUnits: store.state.userSettings.aqiUnits,
      windSpeedUnits: store.state.userSettings.windSpeedUnits,
      updateTempUnits: updateTempUnits,
      updateWindSpeedUnits: updateWindSpeedUnits,
      updateAirPressureUnits: updateAirPressureUnits,
      updateAQIUnits: updateAQIUnits,
      cardColor: AppColors.getCardColor(store),
      drawerColor: AppColors.getCardColor(store).withOpacity(0.85),
      textColor: AppColors.getTextColor(store),
      useAnimatedBackgrounds: store.state.userSettings.useDynamicBackgrounds,
      useDarkMode: store.state.userSettings.useDarkMode,
      toggleAnimatedBackgrounds: toggleAnimatedBackgrounds,
      toggleDarkMode: toggleDarkMode,
      weatherDataList: store.state.weatherData,
      airPressureUnits: store.state.userSettings.airPressureUnits,
      tempUnits: getTempUnitsString(),
      weatherType: weatherType,
      dispatch: store.dispatch,
      updateCurrentIndex: updateCurrentIndex,
      saveUserSettings: saveUserSettings,
      updateWeatherData: updateWeatherData,
    );
  }
}
