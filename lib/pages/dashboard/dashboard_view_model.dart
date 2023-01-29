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

  const DashboardPageViewModel({
    required this.currentTempC,
    required this.currentTempF,
    required this.currentTempK,
    required this.name,
    required this.loadingState,
  });

  factory DashboardPageViewModel.create(final Store<AppState> store) {
    int getCurrentLocationIndex() {
      return store.state.currentLocationIndex;
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
    );
  }
}
