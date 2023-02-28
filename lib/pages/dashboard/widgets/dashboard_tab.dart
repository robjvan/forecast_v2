import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/dashboard_view_model.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:forecast_v3/widgets/widgets.dart';
import 'package:get/get.dart';

class DashboardTab extends StatelessWidget {
  final WeatherData weatherData;
  DashboardTab({
    required this.weatherData,
    super.key,
  });

  Widget buildWeatherIcon(final DashboardPageViewModel vm) {
    //
    return Container();
  }

  Widget buildCurrentConditionsBox(final DashboardPageViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: vm.cardColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      width: Get.width,
      child: Column(
        children: <Widget>[
          Text(
            weatherData.location.name.toString(),
            style: AppStyles.locationNameTextStyle.copyWith(
              color: vm.textColor,
            ),
          ),
          Text(
            vm.currentTemp,
            style: AppStyles.currentTempTextStyle.copyWith(
              color: vm.textColor,
            ),
          ),
          Text(
            vm.currentConditions,
            style: AppStyles.currentConditionsStyle.copyWith(
              color: vm.textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardPageViewModel>(
      converter: DashboardPageViewModel.create,
      builder: (final _, final DashboardPageViewModel vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              buildWeatherIcon(vm),
              buildCurrentConditionsBox(vm),
            ],
          ),
        );
      },
    );
  }
}

// TODO(Rob): Add data and widgets to build weather info page 
