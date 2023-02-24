import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class SettingsDrawerViewModel {
  final Color panelColor;
  final Color textColor;
  final Color drawerColor;
  final Color pointerColor;
  final TextStyle cardHeaderTextStyle;
  final TextStyle cardbodyTextStyle;
  final bool useDarkMode;
  final bool useAnimatedBackgrounds;
  final Function toggleAnimatedBackgrounds;
  final Function toggleDarkMode;
  final IconData toggleDarkModeIcon;
  final IconData toggleAnimBgIcon;
  final Function(int) updateTempUnits;
  final Function(int) updateWindSpeedUnits;
  final Function(int) updateAirPressureUnits;
  final Function(int) updateAQIUnits;
  // final List<SimpleLocation> locationList;
  final List<WeatherData?> weatherDataList;
  final String tempUnits;
  final AirPressureUnits airPressureUnits;
  final WindSpeedUnits windSpeedUnits;
  final AQIUnits aqiUnits;
  final Function refreshScreen;
  final Function(int, int) weatherType;
  final int activeIndex;
  final Function(dynamic) dispatch;
  final Function updateCurrentIndex;
  final Function() saveUserSettings;

  const SettingsDrawerViewModel({
    required this.panelColor,
    required this.weatherType,
    required this.textColor,
    required this.drawerColor,
    required this.pointerColor,
    required this.cardHeaderTextStyle,
    required this.cardbodyTextStyle,
    required this.useDarkMode,
    required this.useAnimatedBackgrounds,
    required this.toggleAnimatedBackgrounds,
    required this.toggleDarkMode,
    required this.toggleDarkModeIcon,
    required this.toggleAnimBgIcon,
    required this.updateTempUnits,
    required this.updateWindSpeedUnits,
    required this.updateAirPressureUnits,
    required this.updateAQIUnits,
    // required this.locationList,
    required this.weatherDataList,
    required this.tempUnits,
    required this.airPressureUnits,
    required this.windSpeedUnits,
    required this.aqiUnits,
    required this.refreshScreen,
    required this.activeIndex,
    required this.dispatch,
    required this.updateCurrentIndex,
    required this.saveUserSettings,
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

    // ignore: missing_return
    Color getPointerColor() {
      final bool useBG = store.state.userSettings.useDynamicBackgrounds;
      final bool useDM = store.state.userSettings.useDarkMode;

      if (useDM && useBG) {
        return Colors.white;
      } else if (useDM && !useBG) {
        return Colors.white;
      } else if (!useDM && useBG) {
        return Colors.white;
      } else if (!useDM && !useBG) {
        return Colors.black;
      }
      return Colors.black;
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
      return 'c';
    }

    void refreshScreen(final BuildContext context) {
      Navigator.of(context).pop();
      store.dispatch(
        fetchWeatherDataAction(
          getActiveLocationIndex(), true,
          // latitude: store.state.weatherData.isNotEmpty
          //     ? store
          //         .state.weatherData[getActiveLocationIndex()].location.lat
          //     : store.state.weatherData.first.location.lat,
          // longitude: store.state.weatherData.isNotEmpty
          //     ? store.state.weatherData[getActiveLocationIndex()].location
          //         .long
          //     : store.state.weatherData.first.location.long,
        ),
      );
    }

    WeatherType? weatherType(final int code, final int index) {
      final bool? isDay =
          store.state.weatherData[index].currentConditions.is_day;
      switch (code) {
        case 1000:
        case 1003:
          return isDay! ? WeatherType.sunny : WeatherType.sunnyNight;
        case 1006:
          return isDay! ? WeatherType.cloudy : WeatherType.cloudyNight;
        case 1009:
          return WeatherType.overcast;
        case 1030:
        case 1063:
        case 1150:
        case 1153:
        case 1180:
        case 1183:
        case 1198:
        case 1240:
        case 1249:
        case 1273:
          return WeatherType.lightRainy;
        case 1168:
        case 1186:
        case 1189:
        case 1243:
        case 1252:
          return WeatherType.middleRainy;
        case 1171:
        case 1192:
        case 1195:
        case 1201:
        case 1246:
          return WeatherType.heavyRainy;
        case 1066:
        case 1069:
        case 1072:
        case 1204:
        case 1210:
        case 1213:
        case 1237:
        case 1255:
        case 1261:
          return WeatherType.lightSnow;
        case 1114:
        case 1207:
        case 1216:
        case 1219:
        case 1258:
        case 1264:
          return WeatherType.middleSnow;
        case 1117:
        case 1222:
        case 1225:
          return WeatherType.heavySnow;
        case 1135:
        case 1147:
          return WeatherType.foggy;
        case 1087:
        case 1276:
        case 1279:
        case 1282:
          return WeatherType.thunder;
      }
      return null;
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
    }

    return SettingsDrawerViewModel(
      activeIndex: store.state.currentLocationIndex,
      aqiUnits: store.state.userSettings.aqiUnits,
      windSpeedUnits: store.state.userSettings.windSpeedUnits,
      updateTempUnits: updateTempUnits,
      updateWindSpeedUnits: updateWindSpeedUnits,
      updateAirPressureUnits: updateAirPressureUnits,
      updateAQIUnits: updateAQIUnits,
      panelColor: store.state.userSettings.useDarkMode
          ? AppColors.darkGrey
          : AppColors.bgColorLightMode,
      drawerColor: store.state.userSettings.useDarkMode
          ? AppColors.black.withOpacity(0.85)
          : AppColors.bgColorLightMode.withOpacity(0.85),
      textColor: store.state.userSettings.useDarkMode
          ? AppColors.white
          : AppColors.black,
      toggleDarkModeIcon: store.state.userSettings.useDarkMode
          ? Icons.toggle_on_outlined
          : Icons.toggle_off_outlined,
      toggleAnimBgIcon: store.state.userSettings.useDynamicBackgrounds
          ? Icons.toggle_on_outlined
          : Icons.toggle_off_outlined,
      useAnimatedBackgrounds: store.state.userSettings.useDynamicBackgrounds,
      useDarkMode: store.state.userSettings.useDarkMode,
      toggleAnimatedBackgrounds: toggleAnimatedBackgrounds,
      toggleDarkMode: toggleDarkMode,
      // locationList: store.state.locationList,
      weatherDataList: store.state.weatherData,
      airPressureUnits: store.state.userSettings.airPressureUnits,
      tempUnits: getTempUnitsString(),
      pointerColor: getPointerColor(),
      cardHeaderTextStyle: AppStyles.cardHeaderStyle.copyWith(
        color: store.state.userSettings.useDarkMode
            ? AppColors.textColorDarkMode
            : AppColors.textColorLightMode,
      ),
      cardbodyTextStyle: AppStyles.cardBodyStyle.copyWith(
        color: store.state.userSettings.useDarkMode
            ? AppColors.textColorDarkMode
            : AppColors.textColorLightMode,
      ),
      refreshScreen: refreshScreen,
      weatherType: weatherType,
      dispatch: store.dispatch,
      updateCurrentIndex: updateCurrentIndex,
      saveUserSettings: saveUserSettings,
    );
  }
}
