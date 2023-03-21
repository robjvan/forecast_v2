import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/redux/app_state.dart';
import 'package:forecast_v3/pages/dashboard/widgets/dashboard_widgets_view_model.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:weather_icons/weather_icons.dart';

class CurrentConditionsBox extends StatelessWidget {
  const CurrentConditionsBox({super.key});
  Widget buildAlertButton() {
    return Positioned(
      right: 8,
      top: 4,
      child: IconButton(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
          size: 40.0,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget buildCityName(final DashboardWidgetsViewModel vm) {
    return Text(
      vm.weatherDataList[vm.activeLocationIndex].location.name.toString(),
      style: AppStyles.locationNameTextStyle.copyWith(
        color: vm.textColor,
      ),
    );
  }

  Widget buildCurrentTemp(final DashboardWidgetsViewModel vm) {
    return Text(
      vm.currentTemp,
      style: AppStyles.currentTempTextStyle.copyWith(
        color: vm.textColor,
      ),
    );
  }

  Widget buildWeatherIcon(final DashboardWidgetsViewModel vm) {
    return BoxedIcon(
      vm.weatherIcon(
        vm.weatherDataList[vm.activeLocationIndex].currentConditions.condition!
            .code!,
      ),
      size: 100,
      color: vm.textColor,
    );
  }

  Widget buildConditionsString(final DashboardWidgetsViewModel vm) {
    return Text(
      vm.currentConditions,
      style: AppStyles.currentConditionsStyle.copyWith(
        color: vm.textColor,
      ),
    );
  }

  Widget buildFeelsLikeString(final DashboardWidgetsViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'Feels like ${vm.feelsLikeTemp}', // TODO(Rob): Add i18n strings
        style: AppStyles.currentFeelsLikeTextStyle.copyWith(
          color: vm.textColor,
        ),
      ),
    );
  }

  Widget buildContent(final DashboardWidgetsViewModel vm) {
    return Stack(
      children: <Widget>[
        buildAlertButton(),
        Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: <Widget>[
              buildCityName(vm),
              buildCurrentTemp(vm),
              buildWeatherIcon(vm),
              buildConditionsString(vm),
              buildFeelsLikeString(vm),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardWidgetsViewModel>(
      distinct: true,
      converter: DashboardWidgetsViewModel.create,
      builder: (final _, final DashboardWidgetsViewModel vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: vm.cardColor.withOpacity(0.5),
            ),
            child: buildContent(vm),
          ),
        );
      },
    );
  }
}
