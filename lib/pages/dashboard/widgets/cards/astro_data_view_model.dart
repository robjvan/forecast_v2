import 'package:flutter/material.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/utilities/moon_phase_icons.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class AstroDataViewModel {
  /// Common props
  final Color cardColor;
  final Color textColor;

  /// Vars for astro data card
  final String sunriseString;
  final String sunsetString;
  // final int sunriseEpochTime;
  // final int sunsetEpochTime;

  final String moonPhaseString;
  final Widget moonPhaseIcon;

  const AstroDataViewModel({
    required this.cardColor,
    required this.textColor,
    required this.sunriseString,
    required this.sunsetString,
    // required this.sunriseEpochTime,
    // required this.sunsetEpochTime,
    required this.moonPhaseString,
    required this.moonPhaseIcon,
  });

  factory AstroDataViewModel.create(final Store<AppState> store) {
    /// Get our sunrise time string
    String getSunriseString() {
      String result = '';

      if (store.state.weatherData.isNotEmpty) {
        result = store.state.weatherData[store.state.currentLocationIndex]
            .forecast.forecastday![0].astro!.sunrise!;

        if (result.startsWith('0')) {
          result = result.substring(1);
        }
      }

      return result;
    }

    /// Get our sunset time string
    String getSunsetString() {
      String result = '';

      if (store.state.weatherData.isNotEmpty) {
        result = store.state.weatherData[store.state.currentLocationIndex]
            .forecast.forecastday![0].astro!.sunset!;

        if (result.startsWith('0')) {
          result = result.substring(1);
        }
      }

      return result;
    }

    // /// Get our sunrise epoch time
    // int getSunriseEpochTime() {
    //   /// Create DateTime object from sunrise string
    //   final DateTime sunriseTimeString =
    //       DateFormat.jm().parse(getSunriseString());

    //   /// Convert sunrise time to 24-hour string to aid parsing
    //   final String formattedSunriseTime =
    //       DateFormat('HH:mm').format(sunriseTimeString);

    //   /// Extract only the date string from today's DateTime object
    //   final String today = DateTime.now().toString().substring(0, 10);

    //   /// Build new DateTime object using today's date and formatted sunrise string
    //   final int parsedDate =
    //       DateTime.parse('$today $formattedSunriseTime').millisecondsSinceEpoch;

    //   return parsedDate;
    // }

    // /// Get our sunset epoch time
    // int getSunsetEpochTime() {
    //   /// Create DateTime object from sunset string
    //   final DateTime sunsetTimeString =
    //       DateFormat.jm().parse(getSunsetString());

    //   /// Convert sunrise time to 24-hour string to aid parsing
    //   final String formattedSunsetTime =
    //       DateFormat('HH:mm').format(sunsetTimeString);

    //   /// Extract only the date string from today's DateTime object
    //   final String today = DateTime.now().toString().substring(0, 10);

    //   /// Build new DateTime object using today's date and formatted sunrise string
    //   final int parsedDate =
    //       DateTime.parse('$today $formattedSunsetTime').millisecondsSinceEpoch;

    //   return parsedDate;
    // }

    /// Get our moon phase string
    String getMoonPhaseString() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[store.state.currentLocationIndex].forecast
              .forecastday![0].astro!.moon_phase!
          : '';
    }

    /// Build our moon phase icon
    Widget getMoonPhaseIcon() {
      if (store.state.weatherData.isNotEmpty) {
        return MoonParser.getIcon(
          store.state.weatherData[store.state.currentLocationIndex].forecast
              .forecastday![0].astro!.moon_phase!,
        );
      } else {
        return Container();
      }
    }

    return AstroDataViewModel(
      cardColor: AppColors.getCardColor(store),
      textColor: AppColors.getTextColor(store),
      sunriseString: getSunriseString(),
      sunsetString: getSunsetString(),
      // sunriseEpochTime: getSunriseEpochTime(),
      // sunsetEpochTime: getSunsetEpochTime(),
      moonPhaseString: getMoonPhaseString(),
      moonPhaseIcon: getMoonPhaseIcon(),
    );
  }
}
