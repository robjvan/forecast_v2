import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/dashboard_view_model.dart';
import 'package:forecast_v3/pages/dashboard/widgets/dashboard_tab_widget.dart';
import 'package:forecast_v3/providers/local_storage_provider.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:forecast_v3/widgets/widgets.dart';
import 'package:redux/redux.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
  static const String routeName = '/dashboard';
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
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
    }

    /// Grab user's current location again in case the saved location is no longer accurate
    await store.dispatch(grabUserLocationAction);
    await store.dispatch(fetchWeatherDataAction(0, true));
    store.dispatch(const SetLoadingStateAction(LoadingState.done));
  }

  @override 
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardPageViewModel>(
      distinct: true,
      onInit: onInit,
      converter: DashboardPageViewModel.create,
      builder: (final BuildContext context, final DashboardPageViewModel vm) {
        /**
         * Create a tab controller with dynamic length based on the number of 
         * locations in our list
         */
        final TabController tabController = TabController(
          length: vm.locationList.length,
          initialIndex: vm.activeLocationIndex,
          vsync: this,
        );

        /**
         * Add a listener so we can reassign the "active location index" when 
         * we swipe to change pages
         */
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            vm.dispatch(UpdateCurrentLocationIndexAction(tabController.index));
          }
        });

        /// Build out the tabs (pages) using a template widget and passed data
        List<Widget> buildDashboardTabs({
          required final List<WeatherData> weatherDataList,
        }) {
          final List<Widget> dashboardTabs = <Widget>[];
          for (final WeatherData weatherData in weatherDataList) {
            dashboardTabs.add(DashboardTabWidget(weatherData: weatherData));
          }

          return dashboardTabs;
        }

        return Scaffold(
          appBar: AppBar(),
          drawer: const SettingsDrawer(),
          body: Center(
            child: vm.loadingState == LoadingState.loading
                ? const CircularProgressIndicator()
                : TabBarView(
                    controller: tabController,
                    children: buildDashboardTabs(
                      weatherDataList: vm.weatherDataList,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
