// These actions are used to interact with Location state

import 'dart:developer';

import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/providers/geolocation_provider.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class UpdateLocationListAction {
  final List<Location> newLocationList;
  const UpdateLocationListAction(this.newLocationList);
}

class UpdateCurrentLocationIndexAction {
  final int newLocationIndex;
  const UpdateCurrentLocationIndexAction(this.newLocationIndex);
}

/// Grab the current user location and add (or replace) it to `AppState.locations`
ThunkAction<AppState> grabUserLocationAction =
    (final Store<AppState> store) async {
  log('[location_actions.dart] grabUserLocationAction() fired!');
  Location userLocation = Location.initial();

  /// 1. Fetch original locations list
  final List<Location> locationList =
      List<Location>.from(store.state.locations);

  /// 2. Get Position from geolocator provider
  final Position userPosition = await GeolocationProvider.determinePosition();
  userLocation = await GeolocationProvider.getLocationData(userPosition);

  /// 3. If currentLocation already exists, replace with new user location data
  if (locationList.isNotEmpty) {
    locationList.replaceRange(0, 1, <Location>[userLocation]);
  } else {
    locationList.add(userLocation);
  }

  /// 4. Send updated location list to reducer
  store.dispatch(UpdateLocationListAction(locationList));
};

ThunkAction<AppState> addLocationToListAction(final Location newLocation) =>
    (final Store<AppState> store) async {
      final List<Location> newLocationsList = store.state.locations;

      /// Check if location is already in the list
      final bool locationAlreadyInList = newLocationsList.indexWhere(
            (final Location element) =>
                element.name == newLocation.name &&
                element.region == newLocation.region,
          ) !=
          -1;

      if (locationAlreadyInList) {
        /// location already in the list, show a snackbar and do nothing else
        Get.snackbar('error'.tr, 'settings.location-already-exists'.tr);
      } else {
        /// location is NOT in the list
        newLocationsList.add(newLocation);
        final int locationIndex = newLocationsList.indexOf(newLocation);


        /// Fetch weather data for the new location
        await store.dispatch(fetchWeatherDataAction(locationIndex, true));

        /// Add new location to AppState.locationsList
        await store.dispatch(UpdateLocationListAction(newLocationsList));

        /// Update active index to newly added location
        store.dispatch(UpdateCurrentLocationIndexAction(locationIndex));
      }
    };

ThunkAction<AppState> removeLocationFromListAction(final int index) =>
    (final Store<AppState> store) async {
      // use index to remove the location from both locationList and weatherDataList
      final List<Location> newLocationsList = store.state.locations;
      newLocationsList.removeAt(index);
      final List<WeatherData> newWeatherDataList = store.state.weatherData;
      newWeatherDataList.removeAt(index);

      // Dispatch action to update locationList
      store.dispatch(UpdateLocationListAction(newLocationsList));

      // Dispatch action to update weatherDataList
      store.dispatch(UpdateWeatherDataListAction(newWeatherDataList));
    };
