import 'package:forecast_v3/actions/actions.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/state.dart';
import 'package:forecast_v3/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
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
  final Function(int?) weatherType;
  final int activeIndex;

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
  });

  factory SettingsDrawerViewModel.create(final Store<GlobalAppState> store) {
    int getActiveLocationIndex() => store.state.activeLocationIndex;

    void toggleDarkMode() {
      store.dispatch(ToggleDarkModeAction());
    }

    void toggleAnimatedBackgrounds() {
      store.dispatch(ToggleAnimatedBackgroundsAction());
    }

    void updateTempUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(const ChangeTempUnitsAction(TempUnits.c));
          break;
        case 1:
          store.dispatch(const ChangeTempUnitsAction(TempUnits.f));
          break;
        case 2:
          store.dispatch(const ChangeTempUnitsAction(TempUnits.k));
          break;
      }
    }

    void updateWindSpeedUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(const ChangeWindSpeedUnitsAction(WindSpeedUnits.kph));
          break;
        case 1:
          store.dispatch(const ChangeWindSpeedUnitsAction(WindSpeedUnits.mph));
          break;
        case 2:
          store
              .dispatch(const ChangeWindSpeedUnitsAction(WindSpeedUnits.knots));
          break;
        case 3:
          store.dispatch(const ChangeWindSpeedUnitsAction(WindSpeedUnits.ms));
          break;
      }
    }

    void updateAirPressureUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(
            const ChangeAirPressureUnitsAction(AirPressureUnits.kpa),
          );
          break;
        case 1:
          store.dispatch(
            const ChangeAirPressureUnitsAction(AirPressureUnits.inch),
          );
          break;
        case 2:
          store.dispatch(
            const ChangeAirPressureUnitsAction(AirPressureUnits.mbar),
          );
          break;
        case 3:
          store.dispatch(
            const ChangeAirPressureUnitsAction(AirPressureUnits.atm),
          );
          break;
      }
    }

    void updateAQIUnits(final int index) {
      switch (index) {
        case 0:
          store.dispatch(const ChangeAQIUnitsAction(AQIUnits.us));
          break;
        case 1:
          store.dispatch(const ChangeAQIUnitsAction(AQIUnits.gb));
          break;
      }
    }

    // ignore: missing_return
    Color getPointerColor() {
      final bool useBG = store.state.userSettings.useAnimatedBackgrounds;
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
        FetchWeatherDataAction(
          index: getActiveLocationIndex(),
          latitude: store.state.weatherDataList.isNotEmpty
              ? store
                  .state.weatherDataList[getActiveLocationIndex()]!.location.lat
              : store.state.weatherDataList.first!.location.lat,
          longitude: store.state.weatherDataList.isNotEmpty
              ? store.state.weatherDataList[getActiveLocationIndex()]!.location
                  .long
              : store.state.weatherDataList.first!.location.long,
        ),
      );
    }

    WeatherType? weatherType(final int? code) {
      final bool? isDay = store.state.weatherDataList[getActiveLocationIndex()]!
          .currentConditions.is_day;
      switch (code) {
        case 1000:
        case 1003:
          return isDay! ? WeatherType.sunny : WeatherType.sunnyNight;
        // break;
        case 1006:
          return isDay! ? WeatherType.cloudy : WeatherType.cloudyNight;
        // break;
        case 1009:
          return WeatherType.overcast;
        // break;
        case 1030:
        case 1063:
        case 1150:
        case 1153:
        case 1180:
        case 1198:
        case 1240:
        case 1249:
          return WeatherType.lightRainy;
        // break;
        case 1168:
        case 1186:
        case 1189:
        case 1243:
        case 1252:
          return WeatherType.middleRainy;
        // break;
        case 1171:
        case 1192:
        case 1195:
        case 1201:
        case 1246:
          return WeatherType.heavyRainy;
        // break;
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
        // break;
        case 1114:
        case 1207:
        case 1216:
        case 1219:
        case 1258:
        case 1264:
          return WeatherType.middleSnow;
        // break;
        case 1117:
        case 1222:
        case 1225:
          return WeatherType.heavySnow;
        // break;
        case 1135:
        case 1147:
          return WeatherType.foggy;
        // break;
        case 1087:
        case 1276:
        case 1279:
        case 1282:
          return WeatherType.thunder;
        // break;
      }
      return null;
    }

    return SettingsDrawerViewModel(
      activeIndex: store.state.activeLocationIndex,
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
      textColor: store.state.userSettings.useDarkMode ? white : black,
      toggleDarkModeIcon: store.state.userSettings.useDarkMode
          ? Icons.toggle_on_outlined
          : Icons.toggle_off_outlined,
      toggleAnimBgIcon: store.state.userSettings.useAnimatedBackgrounds
          ? Icons.toggle_on_outlined
          : Icons.toggle_off_outlined,
      useAnimatedBackgrounds: store.state.userSettings.useAnimatedBackgrounds,
      useDarkMode: store.state.userSettings.useDarkMode,
      toggleAnimatedBackgrounds: toggleAnimatedBackgrounds,
      toggleDarkMode: toggleDarkMode,
      // locationList: store.state.locationList,
      weatherDataList: store.state.weatherDataList,
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
    );
  }
}
