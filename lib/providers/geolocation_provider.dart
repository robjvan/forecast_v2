import 'dart:developer';

import 'package:forecast/models/data_models/location_model.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class GeolocationProvider {
  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      log('Location services are disabled.');
      return Future<Position>.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        log('Location permissions are denied');
        return Future<Position>.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      log('Location permissions are permanently denied, we cannot request permissions.');
      return Future<Position>.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition();
  }

  static Future<Location> getLocationData(final Position position) async {
    final GoogleGeocodingApi api = GoogleGeocodingApi(AppKeys.googleApiKey);
    final String coordinates = '${position.latitude},${position.longitude}';
    final GoogleGeocodingResponse reversedSearchResults =
        await api.reverse(coordinates);
    final Location userLocation = Location.initial();

    userLocation.latitude = position.latitude;
    userLocation.longitude = position.longitude;

    if (reversedSearchResults.status == 'OK') {
      try {

      userLocation.name = reversedSearchResults.results.first.addressComponents
          .toList()[2]
          .longName;
      userLocation.region = reversedSearchResults
          .results.first.addressComponents
          .toList()[3]
          .shortName;
      } on Exception catch (_) {
        userLocation.name = reversedSearchResults
            .results.first.addressComponents
            .toList()[2]
            .longName;
      } 
    }
    return userLocation;
  }
}
