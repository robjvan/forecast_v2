import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/dashboard_page_view_model.dart';
import 'package:forecast_v3/pages/dashboard/widgets/widgets.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer.dart';
import 'package:forecast_v3/providers/local_storage_provider.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
  static const String routeName = '/dashboard';
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  Future<void> onInit(final Store<AppState> store) async {
    /// Set app loading state to loading
    if (store.state.loadingState != LoadingState.loading) {
      store.dispatch(const SetLoadingStateAction(LoadingState.loading));
    }

    /// Check for saved user settings
    final Map<String, dynamic> localData =
        await LocalStorageProvider.readSettingsData();

    if (localData.isNotEmpty) {
      /// Also load user's saved locations
      await store.dispatch(loadUserLocationsAction);
      final UserSettings userSettings = UserSettings.fromJson(localData);
      store.dispatch(UpdateUserSettingsAction(userSettings));

      /// Grab user location index from Get Storage
      await store.dispatch(loadLocationIndexAction);
    }

    /// Grab user's current location again in case the saved location is no longer accurate
    await store.dispatch(grabUserLocationAction);
    await store.dispatch(fetchWeatherDataAction(0, true));
    store.dispatch(const SetLoadingStateAction(LoadingState.done));
  }

  /// Build the animated background
  Widget buildBackground(final DashboardPageViewModel vm) {
    return WeatherBg(
      weatherType: vm.weatherType(
        vm.weatherDataList[vm.activeLocationIndex].currentConditions.condition!
            .code!,
      ),
      width: Get.width,
      height: Get.height,
    );
  }

  /// Build the weather data widgets
  Widget buildBodyContent(final DashboardPageViewModel vm) {
    return SingleChildScrollView(
      child: Column(
        children: const <Widget>[
          SizedBox(height: 72),
          CurrentConditionsBox(),
          SizedBox(height: 8),
          EnvironmentalConditionsBox(),
          SizedBox(height: 8),
          // TODO(Rob): Add more data widgets
          HourlyForecast()
        ],
      ),
    );
  }

  /// Build the settings, location, and alert buttons
  Widget buildButtonRow(final DashboardPageViewModel vm) {
    // /// Build button to open settings drawer
    // Widget buildSettingsButton() {
    //   return IconButton(
    //     style: IconButton.styleFrom(
    //       backgroundColor: vm.cardColor.withOpacity(0.5),
    //     ),
    //     icon: Icon(Icons.settings, color: vm.textColor),
    //     onPressed: () => scaffoldKey.currentState!.openDrawer(),
    //   );
    // }

    /// Build button to show available locations
    Widget buildLocationsButton() {
      return IconButton(
        style: IconButton.styleFrom(
          backgroundColor: vm.cardColor.withOpacity(0.5),
        ),
        icon: Icon(Icons.location_city, color: vm.textColor),
        onPressed: () {
          // TODO(Rob): Add dialog to change current location
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SettingsButton(scaffoldKey),
          const LocationsButton(),
        ],
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardPageViewModel>(
      distinct: true,
      onInit: onInit,
      converter: DashboardPageViewModel.create,
      builder: (final BuildContext context, final DashboardPageViewModel vm) {
        return vm.loadingState == LoadingState.loading
            ? const LoadingWidget()
            : Stack(
                children: <Widget>[
                  vm.useDynamicBackgrounds ? buildBackground(vm) : Container(),
                  Scaffold(
                    key: scaffoldKey,
                    backgroundColor: Colors.transparent,
                    drawer: const SettingsDrawer(),
                    body: Stack(
                      children: <Widget>[
                        buildBodyContent(vm),
                        buildButtonRow(vm),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
