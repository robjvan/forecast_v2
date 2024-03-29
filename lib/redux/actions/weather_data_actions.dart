// These actions are used to interact with WeatherData state

import 'dart:developer';

import 'package:forecast/models/models.dart';
import 'package:forecast/providers/weather_data_provider.dart';
import 'package:forecast/redux/actions.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> fetchWeatherDataAction(
  final int locationListIndex,
  final bool setLoadingState,
) =>
    (final Store<AppState> store) async {
      final List<WeatherData> weatherDataList = store.state.weatherData;
      String? lang;

      /// Set the app state as loading
      if (setLoadingState) {
        if (store.state.loadingState != LoadingState.loading) {
          store.dispatch(const SetLoadingStateAction(LoadingState.loading));
        }
      }

      /// Pull location coords from passed data
      final Map<String, double> coords = <String, double>{
        'lat': store.state.locations[locationListIndex].latitude!,
        'long': store.state.locations[locationListIndex].longitude!
      };

      // Fetch weather data from API
      switch (Get.locale!.languageCode) {
        case 'fr':
          lang = 'fr';
          break;
        case 'es':
          lang = 'es';
          break;
        default:
          break;
      }

      final APIResponse<dynamic> apiResponse =
          await WeatherDataProvider.fetchWeatherData(
        lang,
        lat: coords['lat'].toString(),
        long: coords['long'].toString(),
      );

      if (apiResponse.isOk) {
        // If API does not return an error, parse the response
        final WeatherData apiResult = apiResponse.result;

        final WeatherData weatherData = WeatherData(
          location: APILocation.createEmpty().copyWith(
            name: apiResult.location.name,
            country: apiResult.location.country,
            lat: apiResult.location.lat,
            long: apiResult.location.long,
            localtime: apiResult.location.localtime,
            localtime_epoch: apiResult.location.localtime_epoch,
            region: apiResult.location.region,
            tz_id: apiResult.location.tz_id,
          ),
          currentConditions: APICurrentConditions.createEmpty().copyWith(
            condition: APICondition.createEmpty().copyWith(
              code: apiResult.currentConditions.condition!.code,
              icon: apiResult.currentConditions.condition!.icon,
              text: apiResult.currentConditions.condition!.text,
            ),
            temp_c: apiResult.currentConditions.temp_c,
            temp_f: apiResult.currentConditions.temp_f,
            temp_k: apiResult.currentConditions.temp_c! + 273.15,
            feelslike_c: apiResult.currentConditions.feelslike_c,
            feelslike_f: apiResult.currentConditions.feelslike_f,
            feelslike_k: apiResult.currentConditions.feelslike_c! + 273.15,
            air_quality: APIAQI.createEmpty().copyWith(
                  co: apiResult.currentConditions.air_quality!.co,
                  no2: apiResult.currentConditions.air_quality!.no2,
                  so2: apiResult.currentConditions.air_quality!.so2,
                  o3: apiResult.currentConditions.air_quality!.o3,
                  pm2_5: apiResult.currentConditions.air_quality!.pm2_5,
                  pm10: apiResult.currentConditions.air_quality!.pm10,
                  us_epa_index:
                      apiResult.currentConditions.air_quality!.us_epa_index,
                  gb_defra_index:
                      apiResult.currentConditions.air_quality!.gb_defra_index,
                ),
            humidity: apiResult.currentConditions.humidity,
            is_day: apiResult.currentConditions.is_day,
            last_updated: apiResult.currentConditions.last_updated,
            last_updated_epoch: apiResult.currentConditions.last_updated_epoch,
            pressure_in: apiResult.currentConditions.pressure_in,
            pressure_mb: apiResult.currentConditions.pressure_mb,
            pressure_kpa: apiResult.currentConditions.pressure_mb! / 10,
            pressure_atm: apiResult.currentConditions.pressure_mb! * 0.000987,
            uv: apiResult.currentConditions.uv,
            wind_degree: apiResult.currentConditions.wind_degree,
            wind_dir: apiResult.currentConditions.wind_dir,
            wind_kph: apiResult.currentConditions.wind_kph,
            wind_mph: apiResult.currentConditions.wind_mph,
            wind_knots: apiResult.currentConditions.wind_kph! / 1.852,
            wind_ms: apiResult.currentConditions.wind_kph! / 3.6,
          ),
          forecast: apiResult.forecast,
          weatherAlerts: <APIAlert>[...apiResult.weatherAlerts],
        );

        // Update weather data in weather data list for given index
        if (weatherDataList.length > locationListIndex) {
          weatherDataList.removeAt(locationListIndex);
          weatherDataList.insert(locationListIndex, weatherData);
        } else {
          weatherDataList.add(weatherData);
        }

        // Send new weatherData list to reducer
        await store.dispatch(
          UpdateWeatherDataListAction(weatherDataList),
        );
      } else {
        log(
          'There was a problem fetching weather data ${apiResponse.message}',
        );
      }
      // store.dispatch(const SetLoadingStateAction(LoadingState.done));
    };

class UpdateWeatherDataListAction {
  final List<WeatherData> weatherDataList;
  const UpdateWeatherDataListAction(this.weatherDataList);
}
