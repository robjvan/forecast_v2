import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/dashboard_view_model.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:redux/redux.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
  static const String routeName = '/dashboard';
}

class _DashboardPageState extends State<DashboardPage> {
  Future<String> checkForLocalData() async {
    bool foundLocalData = false;

    // Check for local data stored using Getx
    // foundLocalData = await stuff();

    if (foundLocalData) {
      // if local data found, simply return OK
      return 'ok';
    }

    // if no local data found, return error
    return 'error';
  }

  Future<void> onInit(final Store<AppState> store) async {
    if (store.state.loadingState != LoadingState.loading) {
      store.dispatch(const SetLoadingStateAction(LoadingState.loading));
    }

    // TODO: Check Get.storage for saved location list
    final String dataCheckStatus = await checkForLocalData();
    if (dataCheckStatus == 'ok') {
      // If there IS a list, fire actions to:
      // load userSettings and apply
      // load loation list and fetch the weather for each one
    } else {
      // If there IS NOT a list, grab user location and weather data
      await store.dispatch(grabUserLocationAction);
      await store.dispatch(fetchWeatherDataAction(0));
      store.dispatch(const SetLoadingStateAction(LoadingState.done));
    }
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardPageViewModel>(
      distinct: true,
      onInit: onInit,
      converter: DashboardPageViewModel.create,
      builder: (final BuildContext context, final DashboardPageViewModel vm) {
        return Scaffold(
          body: Center(
            child: vm.loadingState == LoadingState.loading
                ? const CircularProgressIndicator()
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(vm.name),
                      Text(vm.currentTempC.toString())
                    ],
                  )),
          ),
        );
      },
    );
  }
}
