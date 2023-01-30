// These actions are used to interact with User state
import 'package:forecast_v3/models/models.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> toggleDarkModeAction =
    (final Store<AppState> store) async {
  store.dispatch(
    UpdateUserSettingsAction(
      store.state.userSettings.copyWith(
        useDarkMode: !store.state.userSettings.useDarkMode,
      ),
    ),
  );
};

ThunkAction<AppState> toggleAnimatedBackgroundsAction =
    (final Store<AppState> store) async {
  store.dispatch(
    UpdateUserSettingsAction(
      store.state.userSettings.copyWith(
        useDynamicBackgrounds: !store.state.userSettings.useDynamicBackgrounds,
      ),
    ),
  );
};

ThunkAction<AppState> changeTempUnitsAction(final TempUnits tempUnits) =>
    (final Store<AppState> store) async {
      store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            tempUnits: tempUnits,
          ),
        ),
      );
    };

ThunkAction<AppState> changeWindSpeedUnitsAction(
        final WindSpeedUnits windSpeedUnits) =>
    (final Store<AppState> store) async {
      store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            windSpeedUnits: windSpeedUnits,
          ),
        ),
      );
    };

ThunkAction<AppState> changeAirPressureUnitsAction(
        final AirPressureUnits airPressureUnits) =>
    (final Store<AppState> store) async {
      store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            airPressureUnits: airPressureUnits,
          ),
        ),
      );
    };

ThunkAction<AppState> changeAQIUnitsAction(final AQIUnits aqiUnits) =>
    (final Store<AppState> store) async {
      store.dispatch(
        UpdateUserSettingsAction(
          store.state.userSettings.copyWith(
            aqiUnits: aqiUnits,
          ),
        ),
      );
    };

class UpdateUserSettingsAction {
  final UserSettings userSettings;
  const UpdateUserSettingsAction(this.userSettings);
}
