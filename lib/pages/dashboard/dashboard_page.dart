import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/dashboard/dashboard_page_view_model.dart';
import 'package:forecast/pages/dashboard/widgets/widgets.dart';
import 'package:forecast/pages/settings_drawer/settings_drawer.dart';
import 'package:forecast/providers/local_storage_provider.dart';
import 'package:forecast/redux/actions.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

@immutable
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
  static const String routeName = '/dashboard';
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// This will fire when the page is initially built (app launch)
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
          CurrentConditionsCard(),
          SizedBox(height: 8),
          EnvironmentalConditionsCard(),
          SizedBox(height: 8),
          HourlyForecastCard(),
          SizedBox(height: 8),
          DailyForecastCard(),
          SizedBox(height: 8),
          AstroDataCard(),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Build the settings, location, and alert buttons
  Widget buildSettingsButton(final DashboardPageViewModel vm) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, Get.height * 0.035, 8.0, 0),
      child: SettingsButton(scaffoldKey),
    );
  }

  Future<void> onRefresh(final DashboardPageViewModel vm) async {
    await vm.refreshWeatherFunction();
    refreshController.refreshCompleted();
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
                  vm.useDynamicBackgrounds
                      ? buildBackground(vm)
                      : Container(color: vm.bgColor),
                  Scaffold(
                    key: scaffoldKey,
                    backgroundColor: Colors.transparent,
                    drawer: const SettingsDrawer(),
                    body: SmartRefresher(
                      header: MaterialClassicHeader(
                        backgroundColor: vm.cardColor.withOpacity(0.5),
                      ),
                      onRefresh: () => onRefresh(vm),
                      enablePullDown: true,
                      controller: refreshController,
                      child: Stack(
                        children: <Widget>[
                          buildBodyContent(vm),
                          buildSettingsButton(vm),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
