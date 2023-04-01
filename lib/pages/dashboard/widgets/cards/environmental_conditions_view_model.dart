import 'package:flutter/material.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';

@immutable
class EnvironmentalConditionsViewModel {
  /// Common props
  final Color cardColor;
  final Color textColor;

  /// Vars for environmental data card
  final int humidity;
  final int uvIndex;
  final double windSpeed;
  final String windDirection;
  final int windDegrees;
  final double airPressure;
  final int aqi;
  final String airQualityString;
  final String pressureUnitsString;
  final String windSpeedUnitsString;

  const EnvironmentalConditionsViewModel({
    required this.humidity,
    required this.uvIndex,
    required this.windSpeed,
    required this.windDegrees,
    required this.windDirection,
    required this.airPressure,
    required this.aqi,
    required this.cardColor,
    required this.textColor,
    required this.airQualityString,
    required this.pressureUnitsString,
    required this.windSpeedUnitsString,
  });

  factory EnvironmentalConditionsViewModel.create(final Store<AppState> store) {
    /// Fetch our current location index so we grab the right weather data
    int getCurrentLocationIndex() {
      return store.state.currentLocationIndex;
    }

    /// Fetch current humidity value
    int getHumidity() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .humidity!
          : 0;
    }

    /// Fetch current UV index
    int getUvIndex() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .uv!
          : 99;
    }

    /// Build our wind direction string
    String getWindDirection() {
      String result = '';
      if (store.state.weatherData.isNotEmpty) {
        switch (store.state.weatherData[getCurrentLocationIndex()]
            .currentConditions.wind_dir!) {
          case 'NNE':
          case 'ENE':
            result = 'NE';
            break;
          case 'NNW':
          case 'WNW':
            result = 'NW';
            break;
          case 'SSW':
          case 'WSW':
            result = 'SW';
            break;
          case 'SSE':
          case 'ESE':
            result = 'SE';
            break;
          default:
            result = store.state.weatherData[getCurrentLocationIndex()]
                .currentConditions.wind_dir!;
        }
      }
      return result;
    }

    /// Detemine our wind angle value
    int getWindDegrees() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .wind_degree!
          : 0;
    }

    /// Detemine our air pressure value based on the user's units
    double getAirPressure() {
      switch (store.state.userSettings.airPressureUnits) {
        case AirPressureUnits.mbar:
          return store.state.weatherData.isNotEmpty
              ? store.state.weatherData[getCurrentLocationIndex()]
                  .currentConditions.pressure_mb!
                  .toDouble()
              : 0;
        case AirPressureUnits.kpa:
          return store.state.weatherData.isNotEmpty
              ? store.state.weatherData[getCurrentLocationIndex()]
                  .currentConditions.pressure_kpa!
              : 0;
        case AirPressureUnits.inch:
          return store.state.weatherData.isNotEmpty
              ? store.state.weatherData[getCurrentLocationIndex()]
                  .currentConditions.pressure_in!
              : 0;
        case AirPressureUnits.atm:
          return store.state.weatherData.isNotEmpty
              ? double.parse(
                  store.state.weatherData[getCurrentLocationIndex()]
                      .currentConditions.pressure_atm!
                      .toStringAsFixed(3),
                )
              : 0;
        default:
          return 0;
      }
    }

    /// Detemine our air quality index based on the user's units
    int getAqi() {
      switch (store.state.userSettings.aqiUnits) {
        case AQIUnits.us:
          return store.state.weatherData.isNotEmpty
              ? store.state.weatherData[getCurrentLocationIndex()]
                  .currentConditions.air_quality!.us_epa_index!
              : 0;
        case AQIUnits.gb:
          return store.state.weatherData.isNotEmpty
              ? store.state.weatherData[getCurrentLocationIndex()]
                  .currentConditions.air_quality!.gb_defra_index!
              : 0;
        default:
          return 0;
      }
    }

    /// Detemine our wind speed based on the user's units
    double getWindSpeed() {
      switch (store.state.userSettings.windSpeedUnits) {
        case WindSpeedUnits.kph:
          return store.state.weatherData.isNotEmpty
              ? double.parse(
                  store.state.weatherData[getCurrentLocationIndex()]
                      .currentConditions.wind_kph!
                      .toStringAsFixed(1),
                )
              : 0;
        case WindSpeedUnits.mph:
          return store.state.weatherData.isNotEmpty
              ? double.parse(
                  store.state.weatherData[getCurrentLocationIndex()]
                      .currentConditions.wind_mph!
                      .toStringAsFixed(1),
                )
              : 0;
        case WindSpeedUnits.knots:
          return store.state.weatherData.isNotEmpty
              ? double.parse(
                  store.state.weatherData[getCurrentLocationIndex()]
                      .currentConditions.wind_knots!
                      .toStringAsFixed(1),
                )
              : 0;
        case WindSpeedUnits.ms:
          return store.state.weatherData.isNotEmpty
              ? double.parse(
                  store.state.weatherData[getCurrentLocationIndex()]
                      .currentConditions.wind_ms!
                      .toStringAsFixed(2),
                )
              : 0;
        default:
          return 0;
      }
    }

    /// Build our air quality string
    String getAirQualityString() {
      switch (store.state.userSettings.aqiUnits) {
        case AQIUnits.us:
          switch (store.state.weatherData[getCurrentLocationIndex()]
              .currentConditions.air_quality!.us_epa_index) {
            case 1:
              return 'aqi-good'.tr;
            case 2:
              return 'aqi-moderate'.tr;
            case 3:
              return 'aqi-unhealthylite'.tr;
            case 4:
              return 'aqi-unhealthy'.tr;
            case 5:
              return 'aqi-veryunhealthy'.tr;
            case 6:
              return 'aqi-hazardous'.tr;
            default:
              return 'aqi-good'.tr;
          }
        case AQIUnits.gb:
          switch (store.state.weatherData[getCurrentLocationIndex()]
              .currentConditions.air_quality!.gb_defra_index) {
            case 1:
            case 2:
            case 3:
              return 'aqi-low'.tr;
            case 4:
            case 5:
            case 6:
              return 'aqi-moderate'.tr;
            case 7:
            case 8:
            case 9:
              return 'aqi-high'.tr;
            case 10:
              return 'aqi-veryhigh'.tr;
          }
      }
      return '';
    }

    /// Build our air pressure units string
    String getPressureUnitsString() {
      switch (store.state.userSettings.airPressureUnits) {
        case AirPressureUnits.mbar:
          return 'mbar';
        case AirPressureUnits.kpa:
          return 'kPa';
        case AirPressureUnits.inch:
          return 'in';
        case AirPressureUnits.atm:
          return 'atm';
        default:
          return '';
      }
    }

    /// Build our wind speed units string
    String getWindSpeedUnitsString() {
      switch (store.state.userSettings.windSpeedUnits) {
        case WindSpeedUnits.kph:
          return 'km/h';
        case WindSpeedUnits.mph:
          return 'mph';
        case WindSpeedUnits.knots:
          return 'kn';
        case WindSpeedUnits.ms:
          return 'm/s';
        default:
          return '';
      }
    }

    return EnvironmentalConditionsViewModel(
      cardColor: AppColors.getCardColor(store),
      textColor: AppColors.getTextColor(store),
      uvIndex: getUvIndex(),
      humidity: getHumidity(),
      airPressure: getAirPressure(),
      aqi: getAqi(),
      windDirection: getWindDirection(),
      windSpeed: getWindSpeed(),
      windDegrees: getWindDegrees(),
      airQualityString: getAirQualityString(),
      pressureUnitsString: getPressureUnitsString(),
      windSpeedUnitsString: getWindSpeedUnitsString(),
    );
  }
}
