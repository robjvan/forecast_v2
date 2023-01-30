import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:redux/redux.dart';

@immutable
class DashboardPageViewModel {
  final double currentTempC;
  final double currentTempF;
  final double currentTempK;
  final LoadingState loadingState;
  final String name;
  final List<WeatherData> weatherDataList;
  final List<Location> locationList;
  final int activeLocationIndex;
  final Function(dynamic) dispatch;

  const DashboardPageViewModel({
    required this.currentTempC,
    required this.currentTempF,
    required this.currentTempK,
    required this.name,
    required this.loadingState,
    required this.weatherDataList,
    required this.locationList,
    required this.activeLocationIndex,
    required this.dispatch,
  });

  factory DashboardPageViewModel.create(final Store<AppState> store) {
    int getCurrentLocationIndex() {
      return store.state.currentLocationIndex;
    }

    populateWeatherData() {
      final List<WeatherData> weatherDataList = [];
      for (var element in store.state.weatherData) {
        weatherDataList.add(element);
      }
      return weatherDataList;
    }

    populateLocationsList() {
      final List<Location> locationsList = [];
      for (var element in store.state.locations) {
        locationsList.add(element);
      }
      return locationsList;
    }

    return DashboardPageViewModel(
      currentTempC: store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .temp_c!
          : -999,
      currentTempF: store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].currentConditions
              .temp_f!
          : -999,
      currentTempK: -999,
      name: store.state.locations.isNotEmpty
          ? store.state.locations[getCurrentLocationIndex()].name!
          : '',
      loadingState: store.state.loadingState,
      // weatherDataList: store.state.weatherData,
      // locationList: store.state.locations,
      weatherDataList: populateWeatherData(),
      locationList: populateLocationsList(),
      activeLocationIndex: store.state.currentLocationIndex,
      dispatch: store.dispatch,
    );
  }
}
