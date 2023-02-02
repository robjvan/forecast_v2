// These actions are used to interact with User state

import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/providers/local_storage_provider.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class UpdateUserSettingsAction {
  final UserSettings userSettings;
  const UpdateUserSettingsAction(this.userSettings);
}

ThunkAction<AppState> toggleDarkModeAction =
    (final Store<AppState> store) async {
  await store.dispatch(
    UpdateUserSettingsAction(
      store.state.userSettings.copyWith(
        useDarkMode: !store.state.userSettings.useDarkMode,
      ),
    ),
  );
  store.dispatch(saveUserSettingsAction(store.state.userSettings));
};

ThunkAction<AppState> toggleAnimatedBackgroundsAction =
    (final Store<AppState> store) async {
  await store.dispatch(
    UpdateUserSettingsAction(
      store.state.userSettings.copyWith(
        useDynamicBackgrounds: !store.state.userSettings.useDynamicBackgrounds,
      ),
    ),
  );
  store.dispatch(saveUserSettingsAction(store.state.userSettings));
};

ThunkAction<AppState> changeTempUnitsAction(final TempUnits tempUnits) =>
    (final Store<AppState> store) async {
      await store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            tempUnits: tempUnits,
          ),
        ),
      );
      store.dispatch(saveUserSettingsAction(store.state.userSettings));
    };

ThunkAction<AppState> changeWindSpeedUnitsAction(
  final WindSpeedUnits windSpeedUnits,
) =>
    (final Store<AppState> store) async {
      await store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            windSpeedUnits: windSpeedUnits,
          ),
        ),
      );
      store.dispatch(saveUserSettingsAction(store.state.userSettings));
    };

ThunkAction<AppState> changeAirPressureUnitsAction(
  final AirPressureUnits airPressureUnits,
) =>
    (final Store<AppState> store) async {
      await store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            airPressureUnits: airPressureUnits,
          ),
        ),
      );
      store.dispatch(saveUserSettingsAction(store.state.userSettings));
    };

ThunkAction<AppState> changeAQIUnitsAction(final AQIUnits aqiUnits) =>
    (final Store<AppState> store) async {
      await store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            aqiUnits: aqiUnits,
          ),
        ),
      );
      store.dispatch(saveUserSettingsAction(store.state.userSettings));
    };

/// Save user settings to local storage
ThunkAction<AppState> saveUserSettingsAction(final UserSettings userSettings) =>
    (final Store<AppState> store) async {
      final bool saveSuccessful =
          await LocalStorageProvider.writeSettingsData(userSettings);
      if (!saveSuccessful) {
        Get.snackbar(
          'Error',
          'There was an error saving settings, please try again later', // TODO(Rob): Add translation strings
        );
      }
    };
