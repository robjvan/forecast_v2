import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/dashboard_view_model.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:redux/redux.dart';

class DashboardPage extends StatefulWidget {
  // final Function onInit;
  // const DashboardPage({required this.onInit, super.key});
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
  static const String routeName = '/dashboard';
}

class _DashboardPageState extends State<DashboardPage> {
  void onInit(final Store<AppState> store) {
    store.dispatch(grabUserLocationAction);
  }

  @override
  void initState() {
    super.initState();
    // widget.onInit();
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardPageViewModel>(
      onInit: onInit,
      converter: DashboardPageViewModel.create,
      builder: (final BuildContext context, final DashboardPageViewModel vm) {
        return Container();
      },
    );
  }
}
