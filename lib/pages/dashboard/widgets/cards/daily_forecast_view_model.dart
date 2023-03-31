import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class DailyForecastViewModel {
  final Color cardColor;
  final Color textColor;

  /// Vars for daily forecast chart
  final List<DailyTemp> dailyHighDataSeries;
  final List<DailyTemp> dailyLowDataSeries;
  final List<String> dailyConditionIcons;
  final List<int> dailyChanceOfRainSeries;
  final List<String> dayStrings;

  final double lowestTemp;
  final double highestTemp;

  const DailyForecastViewModel({
    required this.cardColor,
    required this.textColor,
    required this.dailyChanceOfRainSeries,
    required this.dailyConditionIcons,
    required this.dailyHighDataSeries,
    required this.dailyLowDataSeries,
    required this.highestTemp,
    required this.lowestTemp,
    required this.dayStrings,
  });

  factory DailyForecastViewModel.create(final Store<AppState> store) {
    /// Fetch list of weather data, hold it in [forecastDay] to make life easier
    final List<APIForecastDay> forecastDay = store.state.weatherData.isNotEmpty
        ? store.state.weatherData[store.state.currentLocationIndex].forecast
            .forecastday!
        : <APIForecastDay>[];

    /// Build a list of day names based starting with today
    List<String> buildDayStrings() {
      switch (DateTime.now().weekday) {
        case 1:
          return <String>['Today', 'Tue', 'Wed', 'Thu', 'Fri'];
        case 2:
          return <String>['Today', 'Wed', 'Thu', 'Fri', 'Sat'];
        case 3:
          return <String>['Today', 'Thu', 'Fri', 'Sat', 'Sun'];
        case 4:
          return <String>['Today', 'Fri', 'Sat', 'Sun', 'Mon'];
        case 5:
          return <String>['Today', 'Sat', 'Sun', 'Mon', 'Tue'];
        case 6:
          return <String>['Today', 'Sun', 'Mon', 'Tue', 'Wed'];
        case 7:
          return <String>['Today', 'Mon', 'Tue', 'Wed', 'Thu'];
        default:
          return <String>[];
      }
    }

    /// Build a list of daily high temps for the daily forecast card
    List<DailyTemp> buildDailyHighSeries() {
      List<DailyTemp> results = <DailyTemp>[];
      final List<double> dailyHighC = <double>[0, 0, 0, 0, 0, 0];
      final List<double> dailyHighF = <double>[0, 0, 0, 0, 0, 0];
      final List<double> dailyHighK = <double>[0, 0, 0, 0, 0, 0];
      final List<String> dayStrings = buildDayStrings();

      dailyHighC[0] = store.state.weatherData.isNotEmpty
          ? forecastDay[0].day!.maxtemp_c!
          : -999;
      dailyHighF[0] = store.state.weatherData.isNotEmpty
          ? forecastDay[0].day!.maxtemp_f!
          : -999;
      dailyHighK[0] =
          store.state.weatherData.isNotEmpty ? dailyHighC[0].toKelvin() : -999;

      dailyHighC[1] = store.state.weatherData.isNotEmpty
          ? forecastDay[1].day!.maxtemp_c!
          : -999;
      dailyHighF[1] = store.state.weatherData.isNotEmpty
          ? forecastDay[1].day!.maxtemp_f!
          : -999;
      dailyHighK[1] =
          store.state.weatherData.isNotEmpty ? dailyHighC[1].toKelvin() : -999;

      dailyHighC[2] = store.state.weatherData.isNotEmpty
          ? forecastDay[2].day!.maxtemp_c!
          : -999;
      dailyHighF[2] = store.state.weatherData.isNotEmpty
          ? forecastDay[2].day!.maxtemp_f!
          : -999;
      dailyHighK[2] =
          store.state.weatherData.isNotEmpty ? dailyHighC[2].toKelvin() : -999;

      dailyHighC[3] = store.state.weatherData.isNotEmpty
          ? forecastDay[3].day!.maxtemp_c!
          : -999;
      dailyHighF[3] = store.state.weatherData.isNotEmpty
          ? forecastDay[3].day!.maxtemp_f!
          : -999;
      dailyHighK[3] =
          store.state.weatherData.isNotEmpty ? dailyHighC[3].toKelvin() : -999;

      dailyHighC[4] = store.state.weatherData.isNotEmpty
          ? forecastDay[4].day!.maxtemp_c!
          : -999;
      dailyHighF[4] = store.state.weatherData.isNotEmpty
          ? forecastDay[4].day!.maxtemp_f!
          : -999;
      dailyHighK[4] =
          store.state.weatherData.isNotEmpty ? dailyHighC[4].toKelvin() : -999;

      switch (store.state.userSettings.tempUnits) {
        case TempUnits.c:
          results = <DailyTemp>[
            DailyTemp(day: dayStrings[0], temp: dailyHighC[0].round()),
            DailyTemp(day: dayStrings[1], temp: dailyHighC[1].round()),
            DailyTemp(day: dayStrings[2], temp: dailyHighC[2].round()),
            DailyTemp(day: dayStrings[3], temp: dailyHighC[3].round()),
            DailyTemp(day: dayStrings[4], temp: dailyHighC[4].round()),
          ];
          break;
        case TempUnits.f:
          results = <DailyTemp>[
            DailyTemp(day: dayStrings[0], temp: dailyHighF[0].round()),
            DailyTemp(day: dayStrings[1], temp: dailyHighF[1].round()),
            DailyTemp(day: dayStrings[2], temp: dailyHighF[2].round()),
            DailyTemp(day: dayStrings[3], temp: dailyHighF[3].round()),
            DailyTemp(day: dayStrings[4], temp: dailyHighF[4].round()),
          ];
          break;
        case TempUnits.k:
          results = <DailyTemp>[
            DailyTemp(day: dayStrings[0], temp: dailyHighK[0].round()),
            DailyTemp(day: dayStrings[1], temp: dailyHighK[1].round()),
            DailyTemp(day: dayStrings[2], temp: dailyHighK[2].round()),
            DailyTemp(day: dayStrings[3], temp: dailyHighK[3].round()),
            DailyTemp(day: dayStrings[4], temp: dailyHighK[4].round()),
          ];
          break;
        default:
          break;
      }

      return results;
    }

    /// Build a list of daily low temps for the daily forecast card
    List<DailyTemp> buildDailyLowSeries() {
      final List<String> dayStrings = buildDayStrings();
      List<DailyTemp> results = <DailyTemp>[];

      final List<double> dailyLowC = <double>[0, 0, 0, 0, 0, 0];
      final List<double> dailyLowF = <double>[0, 0, 0, 0, 0, 0];
      final List<double> dailyLowK = <double>[0, 0, 0, 0, 0, 0];

      dailyLowC[0] = store.state.weatherData.isNotEmpty
          ? forecastDay[0].day!.mintemp_c!
          : -999;
      dailyLowF[0] = store.state.weatherData.isNotEmpty
          ? forecastDay[0].day!.mintemp_f!
          : -999;
      dailyLowK[0] =
          store.state.weatherData.isNotEmpty ? dailyLowK[0].toKelvin() : -999;

      dailyLowC[1] = store.state.weatherData.isNotEmpty
          ? forecastDay[1].day!.mintemp_c!
          : -999;
      dailyLowF[1] = store.state.weatherData.isNotEmpty
          ? forecastDay[1].day!.mintemp_f!
          : -999;
      dailyLowK[1] =
          store.state.weatherData.isNotEmpty ? dailyLowC[1].toKelvin() : -999;

      dailyLowC[2] = store.state.weatherData.isNotEmpty
          ? forecastDay[2].day!.mintemp_c!
          : -999;
      dailyLowF[2] = store.state.weatherData.isNotEmpty
          ? forecastDay[2].day!.mintemp_f!
          : -999;
      dailyLowK[2] =
          store.state.weatherData.isNotEmpty ? dailyLowC[2].toKelvin() : -999;

      dailyLowC[3] = store.state.weatherData.isNotEmpty
          ? forecastDay[3].day!.mintemp_c!
          : -999;
      dailyLowF[3] = store.state.weatherData.isNotEmpty
          ? forecastDay[3].day!.mintemp_f!
          : -999;
      dailyLowK[3] =
          store.state.weatherData.isNotEmpty ? dailyLowC[3].toKelvin() : -999;

      dailyLowC[4] = store.state.weatherData.isNotEmpty
          ? forecastDay[4].day!.mintemp_c!
          : -999;
      dailyLowF[4] = store.state.weatherData.isNotEmpty
          ? forecastDay[4].day!.mintemp_f!
          : -999;
      dailyLowK[4] =
          store.state.weatherData.isNotEmpty ? dailyLowC[4].toKelvin() : -999;

      switch (store.state.userSettings.tempUnits) {
        case TempUnits.c:
          results = <DailyTemp>[
            DailyTemp(day: dayStrings[0], temp: dailyLowC[0].round()),
            DailyTemp(day: dayStrings[1], temp: dailyLowC[1].round()),
            DailyTemp(day: dayStrings[2], temp: dailyLowC[2].round()),
            DailyTemp(day: dayStrings[3], temp: dailyLowC[3].round()),
            DailyTemp(day: dayStrings[4], temp: dailyLowC[4].round()),
          ];
          break;
        case TempUnits.f:
          results = <DailyTemp>[
            DailyTemp(day: dayStrings[0], temp: dailyLowF[0].round()),
            DailyTemp(day: dayStrings[1], temp: dailyLowF[1].round()),
            DailyTemp(day: dayStrings[2], temp: dailyLowF[2].round()),
            DailyTemp(day: dayStrings[3], temp: dailyLowF[3].round()),
            DailyTemp(day: dayStrings[4], temp: dailyLowF[4].round()),
          ];
          break;
        case TempUnits.k:
          results = <DailyTemp>[
            DailyTemp(day: dayStrings[0], temp: dailyLowK[0].round()),
            DailyTemp(day: dayStrings[1], temp: dailyLowK[1].round()),
            DailyTemp(day: dayStrings[2], temp: dailyLowK[2].round()),
            DailyTemp(day: dayStrings[3], temp: dailyLowK[3].round()),
            DailyTemp(day: dayStrings[4], temp: dailyLowK[4].round()),
          ];
          break;
        default:
          break;
      }

      return results;
    }

    /// Build the icon data series used in the daily forecast card
    List<String> buildDailyConditionsIconsData() =>
        store.state.weatherData.isNotEmpty
            ? <String>[
                'http:${forecastDay[0].day!.condition!.icon}',
                'http:${forecastDay[1].day!.condition!.icon}',
                'http:${forecastDay[2].day!.condition!.icon}',
                'http:${forecastDay[3].day!.condition!.icon}',
                'http:${forecastDay[4].day!.condition!.icon}',
              ]
            : <String>[];

    /// Build the "chance of rain" data series used in the daily forecast card
    List<int> buildDailyChanceOfRainSeries() =>
        store.state.weatherData.isNotEmpty
            ? <int>[
                forecastDay[0].day!.daily_chance_of_rain!,
                forecastDay[1].day!.daily_chance_of_rain!,
                forecastDay[2].day!.daily_chance_of_rain!,
                forecastDay[3].day!.daily_chance_of_rain!,
                forecastDay[4].day!.daily_chance_of_rain!,
              ]
            : <int>[-999, -999, -999, -999, -999];

    /// Determine the lowest temp found in our hourly forecast data
    double getLowestHourlyTemp() {
      int lowestTempResult = 400;

      buildDailyLowSeries().forEach((final DailyTemp element) {
        if (element.temp < lowestTempResult) {
          lowestTempResult = element.temp;
        }
      });
      return lowestTempResult.toDouble();
    }

    /// Determine the highest temp found in our hourly forecast data
    double getHighestHourlyTemp() {
      int highestTempResult = -400;

      buildDailyHighSeries().forEach((final DailyTemp element) {
        if (element.temp > highestTempResult) {
          highestTempResult = element.temp;
        }
      });
      return highestTempResult.toDouble();
    }

    return DailyForecastViewModel(
      dailyConditionIcons: buildDailyConditionsIconsData(),
      dailyHighDataSeries: buildDailyHighSeries(),
      dailyLowDataSeries: buildDailyLowSeries(),
      dailyChanceOfRainSeries: buildDailyChanceOfRainSeries(),
      cardColor: AppColors.getCardColor(store),
      textColor: AppColors.getTextColor(store),
      lowestTemp: getLowestHourlyTemp(),
      highestTemp: getHighestHourlyTemp(),
      dayStrings: buildDayStrings(),
    );
  }
}
