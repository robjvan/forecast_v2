import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class DashboardWidgetsViewModel {
  final Color cardColor;
  final Color textColor;

  const DashboardWidgetsViewModel({
    required this.cardColor,
    required this.textColor,
  });

  factory DashboardWidgetsViewModel.create(final Store<AppState> store) {
    return DashboardWidgetsViewModel(
      cardColor: store.state.userSettings.useDarkMode
          ? AppColors.bgColorDarkMode
          : AppColors.bgColorLightMode,
      textColor: store.state.userSettings.useDarkMode
          ? AppColors.textColorDarkMode
          : AppColors.textColorLightMode,
    );
  }
}
