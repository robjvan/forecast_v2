// These actions are used to interact with Location state

import 'dart:developer';

import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/providers/geolocation_provider.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class UpdateLocationListAction {
  final List<Location> locations;
  const UpdateLocationListAction(this.locations);
}

ThunkAction<AppState> grabUserLocationAction =
    (final Store<AppState> store) async {
  log('[location_actions.dart] grabUserLocationAction() fired!');
  Location userLocation = Location.initial();

  // 1. Fetch original locations list
  final List<Location> locationList =
      List<Location>.from(store.state.locations);

  // 2. Grab the user's coords
  // Get Position from geolocator provider
  final Position userPosition = await GeolocationProvider.determinePosition();
  userLocation = await GeolocationProvider.getLocationData(userPosition);

  // 3. Replace index 0 in location list with new user location data
  if (locationList.isNotEmpty) {
    locationList.replaceRange(0, 1, <Location>[userLocation]);
  } else {
    locationList.add(userLocation);
  }

  // 4. Send updated location list to reducer
  store.dispatch(UpdateLocationListAction(locationList));
};
