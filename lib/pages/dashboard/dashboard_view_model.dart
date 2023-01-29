import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:redux/redux.dart';

@immutable
class DashboardPageViewModel {
  final double currentTempC;
  final double currentTempF;
  final double currentTempK;

  const DashboardPageViewModel({
    required this.currentTempC,
    required this.currentTempF,
    required this.currentTempK,
  });

  factory DashboardPageViewModel.create(final Store<AppState> store) {
    return const DashboardPageViewModel(
      currentTempC: -999,
      currentTempF: -999,
      currentTempK: -999,
    );
  }
}
