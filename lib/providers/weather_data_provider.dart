import 'dart:convert';

import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/providers/api/weather_api_provider.dart';
import 'package:http/http.dart';

class WeatherDataProvider {
  /// Grab weather data from the API
  static Future<APIResponse<dynamic>> fetchWeatherData(
      // final String locationString,
      {
    required final String lat,
    required final String long,
  }) async {
    final Response response =
        await WeatherAPIProvider().getWeatherDataFromApi(lat, long);
    // await WeatherAPIProvider().getWeatherDataFromApi(locationString);
    // Return error code is status is not 200 or 201
    if (response.statusCode != 200) {
      return APIResponse<dynamic>(
        isOk: false,
        result: null,
        status: response.statusCode,
        message: response.body,
      );
    }

    WeatherData? parsedData;

    try {
      parsedData = WeatherData.fromJson(jsonDecode(response.body));
    } on Exception catch (exception) {
      return APIResponse<dynamic>(
        isOk: false,
        status: response.statusCode,
        result: null,
        message: exception.toString(),
      );
    }

    return APIResponse<WeatherData>(
      isOk: true,
      message: 'OK',
      status: response.statusCode,
      result: parsedData,
    );
  }
}
