import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:redux/redux.dart';

@immutable
class SettingsPageViewModel {
  final bool useDarkMode;

  const SettingsPageViewModel({
    required this.useDarkMode,
  });

  factory SettingsPageViewModel.create(final Store<AppState> store) {
    return SettingsPageViewModel(
      useDarkMode: store.state.userSettings.useDarkMode,
    );
  }
}
