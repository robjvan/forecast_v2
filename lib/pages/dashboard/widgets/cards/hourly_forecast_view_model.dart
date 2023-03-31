import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class HourlyForecastViewModel {
  final Color cardColor;
  final Color textColor;

  /// Vars for hourly forecast chart
  final List<HourlyData> hourlyChartDataSeries;
  final List<int> hourlyChanceOfRainSeries;
  final List<String> hourlyConditionIcons;
  final double lowestTemp;
  final double highestTemp;
  final List<String> timeStrings;

  const HourlyForecastViewModel({
    required this.hourlyChartDataSeries,
    required this.hourlyConditionIcons,
    required this.hourlyChanceOfRainSeries,
    required this.highestTemp,
    required this.lowestTemp,
    required this.timeStrings,
    required this.cardColor,
    required this.textColor,
  });
  factory HourlyForecastViewModel.create(final Store<AppState> store) {
    /// Fetch list of weather data, hold it in [forecastDay] to make life easier
    final List<APIForecastDay> forecastDay = store.state.weatherData.isNotEmpty
        ? store.state.weatherData[store.state.currentLocationIndex].forecast
            .forecastday!
        : <APIForecastDay>[];

    /// Build a list of hour strings based starting with current hour
    List<String> buildTimeStrings() {
      String timeNow = '';
      String nowPlusThreeHours = '';
      String nowPlusSixHours = '';
      String nowPlusNineHours = '';
      String nowPlusTwelveHours = '';
      String nowPlusFifteenHours = '';

      /// Determine the string for current hour
      int temp = DateTime.now().hour;
      if (temp == 0) {
        timeNow = '12 AM';
      } else if (temp < 12) {
        timeNow = '$temp AM';
      } else if (temp == 12) {
        timeNow = '12 PM';
      } else if (temp > 12) {
        timeNow = '${temp - 12} PM';
      }

      /// Determine the string for three hours from now
      temp = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 10800000,
      ).hour;
      if (temp == 0) {
        nowPlusThreeHours = '12 AM';
      } else if (temp > 24) {
        nowPlusThreeHours = '${temp - 24} AM';
      } else if (temp < 12) {
        nowPlusThreeHours = '$temp AM';
      } else if (temp == 12) {
        nowPlusThreeHours = '12 PM';
      } else if (temp > 12) {
        nowPlusThreeHours = '${temp - 12} PM';
      }

      /// Determine the string for six hours from now
      temp = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 10800000 * 2,
      ).hour;
      if (temp == 0) {
        nowPlusSixHours = '12 AM';
      } else if (temp > 24) {
        nowPlusSixHours = '${temp - 24} AM';
      } else if (temp < 12) {
        nowPlusSixHours = '$temp AM';
      } else if (temp == 12) {
        nowPlusSixHours = '12 PM';
      } else if (temp > 12) {
        nowPlusSixHours = '${temp - 12} PM';
      }

      /// Determine the string for nine hours from now
      temp = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 10800000 * 3,
      ).hour;
      if (temp == 0) {
        nowPlusNineHours = '12 AM';
      } else if (temp > 24) {
        nowPlusNineHours = '${temp - 24} AM';
      } else if (temp < 12) {
        nowPlusNineHours = '$temp AM';
      } else if (temp == 12) {
        nowPlusNineHours = '12 PM';
      } else if (temp > 12) {
        nowPlusNineHours = '${temp - 12} PM';
      }

      /// Determine the string for twelve hours from now
      temp = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 10800000 * 4,
      ).hour;
      if (temp == 0) {
        nowPlusTwelveHours = '12 AM';
      } else if (temp > 24) {
        nowPlusTwelveHours = '${temp - 24} AM';
      } else if (temp < 12) {
        nowPlusTwelveHours = '$temp AM';
      } else if (temp == 12) {
        nowPlusTwelveHours = '12 PM';
      } else if (temp > 12) {
        nowPlusTwelveHours = '${temp - 12} PM';
      }

      /// Determine the string for fifteen hours from now
      temp = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch + 10800000 * 5,
      ).hour;
      if (temp == 0) {
        nowPlusFifteenHours = '12 AM';
      } else if (temp > 24) {
        nowPlusFifteenHours = '${temp - 24} AM';
      } else if (temp < 12) {
        nowPlusFifteenHours = '$temp AM';
      } else if (temp == 12) {
        nowPlusFifteenHours = '12 PM';
      } else if (temp > 12) {
        nowPlusFifteenHours = '${temp - 12} PM';
      }

      return <String>[
        timeNow,
        nowPlusThreeHours,
        nowPlusSixHours,
        nowPlusNineHours,
        nowPlusTwelveHours,
        nowPlusFifteenHours,
      ];
    }

    /// Build the forceast data series used in the hourly forecast card
    List<HourlyData> buildHourlyDataSeries() {
      List<HourlyData> results = <HourlyData>[];

      final int hourNow = DateTime.now().hour;
      final int nowPlusThreeHours = hourNow + 3;
      final int nowPlusSixHours = hourNow + 6;
      final int nowPlusNineHours = hourNow + 9;
      final int nowPlusTwelveHours = hourNow + 12;
      final int nowPlusFifteenHours = hourNow + 15;
      final List<int> forecastHours = <int>[
        hourNow,
        nowPlusThreeHours,
        nowPlusSixHours,
        nowPlusNineHours,
        nowPlusTwelveHours,
        nowPlusFifteenHours,
      ];

      final List<double> hourlyTempC = <double>[0, 0, 0, 0, 0, 0];
      final List<double> hourlyTempF = <double>[0, 0, 0, 0, 0, 0];
      final List<double> hourlyTempK = <double>[0, 0, 0, 0, 0, 0];

      hourlyTempC[0] = store.state.weatherData.isNotEmpty
          ? forecastDay[0].hour![hourNow].temp_c!
          : -99;
      hourlyTempC[1] = store.state.weatherData.isNotEmpty
          ? nowPlusThreeHours >= 24
              ? forecastDay[1].hour![nowPlusThreeHours - 24].temp_c!
              : forecastDay[0].hour![nowPlusThreeHours].temp_c!
          : -99;
      hourlyTempC[2] = store.state.weatherData.isNotEmpty
          ? nowPlusSixHours >= 24
              ? forecastDay[1].hour![nowPlusSixHours - 24].temp_c!
              : forecastDay[0].hour![nowPlusSixHours].temp_c!
          : -99;
      hourlyTempC[3] = store.state.weatherData.isNotEmpty
          ? nowPlusNineHours >= 24
              ? forecastDay[1].hour![nowPlusNineHours - 24].temp_c!
              : forecastDay[0].hour![nowPlusNineHours].temp_c!
          : -99;
      hourlyTempC[4] = store.state.weatherData.isNotEmpty
          ? nowPlusTwelveHours >= 24
              ? forecastDay[1].hour![nowPlusTwelveHours - 24].temp_c!
              : forecastDay[0].hour![nowPlusTwelveHours].temp_c!
          : -99;
      hourlyTempC[5] = store.state.weatherData.isNotEmpty
          ? nowPlusFifteenHours >= 24
              ? forecastDay[1].hour![nowPlusFifteenHours - 24].temp_c!
              : forecastDay[0].hour![nowPlusFifteenHours].temp_c!
          : -99;

      hourlyTempF[0] = store.state.weatherData.isNotEmpty
          ? forecastDay[0].hour![hourNow].temp_f ?? -99
          : -99;
      hourlyTempF[1] = store.state.weatherData.isNotEmpty
          ? nowPlusThreeHours >= 24
              ? forecastDay[1].hour![nowPlusThreeHours - 24].temp_f!
              : forecastDay[0].hour![nowPlusThreeHours].temp_f!
          : -99;
      hourlyTempF[2] = store.state.weatherData.isNotEmpty
          ? nowPlusSixHours >= 24
              ? forecastDay[1].hour![nowPlusSixHours - 24].temp_f!
              : forecastDay[0].hour![nowPlusSixHours].temp_f!
          : -99;
      hourlyTempF[3] = store.state.weatherData.isNotEmpty
          ? nowPlusNineHours >= 24
              ? forecastDay[1].hour![nowPlusNineHours - 24].temp_f!
              : forecastDay[0].hour![nowPlusNineHours].temp_f!
          : -99;
      hourlyTempF[4] = store.state.weatherData.isNotEmpty
          ? nowPlusTwelveHours >= 24
              ? forecastDay[1].hour![nowPlusTwelveHours - 24].temp_f!
              : forecastDay[0].hour![nowPlusTwelveHours].temp_f!
          : -99;
      hourlyTempF[5] = store.state.weatherData.isNotEmpty
          ? nowPlusFifteenHours >= 24
              ? forecastDay[1].hour![nowPlusFifteenHours - 24].temp_f!
              : forecastDay[0].hour![nowPlusFifteenHours].temp_f!
          : -99;

      hourlyTempK[0] = hourlyTempC[0].toKelvin();
      hourlyTempK[1] = hourlyTempC[1].toKelvin();
      hourlyTempK[2] = hourlyTempC[2].toKelvin();
      hourlyTempK[3] = hourlyTempC[3].toKelvin();
      hourlyTempK[4] = hourlyTempC[4].toKelvin();
      hourlyTempK[5] = hourlyTempC[5].toKelvin();

      switch (store.state.userSettings.tempUnits) {
        case TempUnits.c:
          results = <HourlyData>[
            HourlyData(
              hour: forecastHours[0],
              temp: hourlyTempC[0].toInt(),
            ),
            HourlyData(
              hour: forecastHours[1],
              temp: hourlyTempC[1].toInt(),
            ),
            HourlyData(
              hour: forecastHours[2],
              temp: hourlyTempC[2].toInt(),
            ),
            HourlyData(
              hour: forecastHours[3],
              temp: hourlyTempC[3].toInt(),
            ),
            HourlyData(
              hour: forecastHours[4],
              temp: hourlyTempC[4].toInt(),
            ),
            HourlyData(
              hour: forecastHours[5],
              temp: hourlyTempC[5].toInt(),
            ),
          ];
          break;
        case TempUnits.f:
          results = <HourlyData>[
            HourlyData(
              hour: forecastHours[0],
              temp: hourlyTempF[0].toInt(),
            ),
            HourlyData(
              hour: forecastHours[1],
              temp: hourlyTempF[1].toInt(),
            ),
            HourlyData(
              hour: forecastHours[2],
              temp: hourlyTempF[2].toInt(),
            ),
            HourlyData(
              hour: forecastHours[3],
              temp: hourlyTempF[3].toInt(),
            ),
            HourlyData(
              hour: forecastHours[4],
              temp: hourlyTempF[4].toInt(),
            ),
            HourlyData(
              hour: forecastHours[5],
              temp: hourlyTempF[5].toInt(),
            ),
          ];
          break;
        case TempUnits.k:
          results = <HourlyData>[
            HourlyData(
              hour: forecastHours[0],
              temp: hourlyTempK[0].toInt(),
            ),
            HourlyData(
              hour: forecastHours[1],
              temp: hourlyTempK[1].toInt(),
            ),
            HourlyData(
              hour: forecastHours[2],
              temp: hourlyTempK[2].toInt(),
            ),
            HourlyData(
              hour: forecastHours[3],
              temp: hourlyTempK[3].toInt(),
            ),
            HourlyData(
              hour: forecastHours[4],
              temp: hourlyTempK[4].toInt(),
            ),
            HourlyData(
              hour: forecastHours[5],
              temp: hourlyTempK[5].toInt(),
            ),
          ];
          break;
      }

      return results;
    }

    /// Build the icon data series used in the hourly forecast card
    List<String> buildHourlyConditionsIconsData() {
      final int hourNow = DateTime.now().hour;
      final int nowPlusThreeHours = hourNow + 3;
      final int nowPlusSixHours = hourNow + 6;
      final int nowPlusNineHours = hourNow + 9;
      final int nowPlusTwelveHours = hourNow + 12;
      final int nowPlusFifteenHours = hourNow + 15;

      final List<String> results = <String>['', '', '', '', '', ''];

      results[0] = store.state.weatherData.isNotEmpty
          ? 'http:${forecastDay[0].hour![hourNow].condition!.icon}'
          : '';
      results[1] = store.state.weatherData.isNotEmpty
          ? nowPlusThreeHours >= 24
              ? 'http:${forecastDay[1].hour![nowPlusThreeHours - 24].condition!.icon}'
              : 'http:${forecastDay[0].hour![nowPlusThreeHours].condition!.icon}'
          : '';
      results[2] = store.state.weatherData.isNotEmpty
          ? nowPlusSixHours >= 24
              ? 'http:${forecastDay[1].hour![nowPlusSixHours - 24].condition!.icon}'
              : 'http:${forecastDay[0].hour![nowPlusSixHours].condition!.icon}'
          : '';
      results[3] = store.state.weatherData.isNotEmpty
          ? nowPlusNineHours >= 24
              ? 'http:${forecastDay[1].hour![nowPlusNineHours - 24].condition!.icon}'
              : 'http:${forecastDay[0].hour![nowPlusNineHours].condition!.icon}'
          : '';
      results[4] = store.state.weatherData.isNotEmpty
          ? nowPlusTwelveHours >= 24
              ? 'http:${forecastDay[1].hour![nowPlusTwelveHours - 24].condition!.icon}'
              : 'http:${forecastDay[0].hour![nowPlusTwelveHours].condition!.icon}'
          : '';
      results[5] = store.state.weatherData.isNotEmpty
          ? nowPlusFifteenHours >= 24
              ? 'http:${forecastDay[1].hour![nowPlusFifteenHours - 24].condition!.icon}'
              : 'http:${forecastDay[0].hour![nowPlusFifteenHours].condition!.icon}'
          : '';

      return results;
    }

    /// Build the "chance of rain" data series used in the hourly forecast card
    List<int> buildHourlyChanceOfRainSeries() {
      final int hourNow = DateTime.now().hour;
      final int nowPlusThreeHours = hourNow + 3;
      final int nowPlusSixHours = hourNow + 6;
      final int nowPlusNineHours = hourNow + 9;
      final int nowPlusTwelveHours = hourNow + 12;
      final int nowPlusFifteenHours = hourNow + 15;

      final List<int> results = <int>[0, 0, 0, 0, 0, 0];

      results[0] = store.state.weatherData.isNotEmpty
          ? forecastDay[0].hour![hourNow].chance_of_rain!
          : -99;
      results[1] = store.state.weatherData.isNotEmpty
          ? nowPlusThreeHours >= 24
              ? forecastDay[1].hour![nowPlusThreeHours - 24].chance_of_rain!
              : forecastDay[0].hour![nowPlusThreeHours].chance_of_rain!
          : -99;
      results[2] = store.state.weatherData.isNotEmpty
          ? nowPlusSixHours >= 24
              ? forecastDay[1].hour![nowPlusSixHours - 24].chance_of_rain!
              : forecastDay[0].hour![nowPlusSixHours].chance_of_rain!
          : -99;
      results[3] = store.state.weatherData.isNotEmpty
          ? nowPlusNineHours >= 24
              ? forecastDay[1].hour![nowPlusNineHours - 24].chance_of_rain!
              : forecastDay[0].hour![nowPlusNineHours].chance_of_rain!
          : -99;
      results[4] = store.state.weatherData.isNotEmpty
          ? nowPlusTwelveHours >= 24
              ? forecastDay[1].hour![nowPlusTwelveHours - 24].chance_of_rain!
              : forecastDay[0].hour![nowPlusTwelveHours].chance_of_rain!
          : -99;
      results[5] = store.state.weatherData.isNotEmpty
          ? nowPlusFifteenHours >= 24
              ? forecastDay[1].hour![nowPlusFifteenHours - 24].chance_of_rain!
              : forecastDay[0].hour![nowPlusFifteenHours].chance_of_rain!
          : -99;

      return results;
    }

    /// Determine the lowest temp found in our hourly forecast data
    double getLowestHourlyTemp() {
      int lowestHourlyTemp = 400;

      buildHourlyDataSeries().forEach((final HourlyData element) {
        if (element.temp < lowestHourlyTemp) {
          lowestHourlyTemp = element.temp;
        }
      });
      return lowestHourlyTemp.toDouble();
    }

    /// Determine the highest temp found in our hourly forecast data
    double getHighestHourlyTemp() {
      int highestHourlyTemp = -400;

      buildHourlyDataSeries().forEach((final HourlyData element) {
        if (element.temp > highestHourlyTemp) {
          highestHourlyTemp = element.temp;
        }
      });
      return highestHourlyTemp.toDouble();
    }

    return HourlyForecastViewModel(
      timeStrings: buildTimeStrings(),
      hourlyChartDataSeries: buildHourlyDataSeries(),
      hourlyConditionIcons: buildHourlyConditionsIconsData(),
      hourlyChanceOfRainSeries: buildHourlyChanceOfRainSeries(),
      lowestTemp: getLowestHourlyTemp(),
      highestTemp: getHighestHourlyTemp(),
      cardColor: AppColors.getCardColor(store),
      textColor: AppColors.getTextColor(store),
    );
  }
}
