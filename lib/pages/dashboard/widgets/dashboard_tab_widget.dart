import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/dashboard_view_model.dart';

class DashboardTabWidget extends StatelessWidget {
  final WeatherData weatherData;
  const DashboardTabWidget({
    required this.weatherData,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardPageViewModel>(
        converter: DashboardPageViewModel.create,
        builder: (final _, final DashboardPageViewModel vm) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(weatherData.location.name.toString()),
                Text(weatherData.currentConditions.temp_c.toString()),
              ],
            ),
          );
        });
  }
}

// TODO(Rob): Add data and widgets to build weather info page 
