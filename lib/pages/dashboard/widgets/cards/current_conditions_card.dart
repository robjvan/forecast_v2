import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/pages/dashboard/widgets/cards/current_conditions_view_model.dart';
import 'package:forecast/pages/dashboard/widgets/dialogs/weather_alert_dialog.dart';
import 'package:forecast/redux/app_state.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:get/get.dart';

@immutable
class CurrentConditionsCard extends StatelessWidget {
  const CurrentConditionsCard({super.key});

  /// Build alert button if there are active weather alerts
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
        onPressed: () => Get.dialog(const WeatherAlertDialog()),
      ),
    );
  }

  /// Build city name widget
  Widget buildCityName(final CurrentConditionsViewModel vm) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: vm.activeWeatherAlert
              ? (Get.width - 128) * 0.75
              : (Get.width - 128),
          child: Text(
            vm.weatherDataList[vm.activeLocationIndex].location.name.toString(),
            style: AppStyles.locationNameTextStyle.copyWith(
              color: vm.textColor,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // vm.activeWeatherAlert ? buildAlertButton() : Container(),
      ],
    );
  }

  /// Build current temp widget
  Widget buildCurrentTemp(final CurrentConditionsViewModel vm) {
    return Text(
      vm.currentTemp,
      style: AppStyles.currentTempTextStyle.copyWith(
        color: vm.textColor,
      ),
    );
  }

  /// Build current weather icon widget
  Widget buildWeatherIcon(final CurrentConditionsViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      // padding: const EdgeInsets.only(bottom: 0.0),
      child: Transform.scale(
        scale: 1.25,
        child: CachedNetworkImage(imageUrl: 'http:${vm.conditionsIconUrl}'),
      ),
    );
  }

  /// Build current weather conditions widget
  Widget buildConditionsString(final CurrentConditionsViewModel vm) {
    return Text(
      vm.currentConditions,
      style: AppStyles.currentConditionsStyle.copyWith(
        color: vm.textColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Build current "feels like" widget
  Widget buildFeelsLikeString(final CurrentConditionsViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'feelslike'.trParams(<String, String>{'temp': vm.feelsLikeTemp}),
        style: AppStyles.currentFeelsLikeTextStyle.copyWith(
          color: vm.textColor,
        ),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, CurrentConditionsViewModel>(
      distinct: true,
      converter: CurrentConditionsViewModel.create,
      builder: (final _, final CurrentConditionsViewModel vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: vm.cardColor.withOpacity(0.5),
            ),
            child: Stack(
              children: <Widget>[
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
            ),
          ),
        );
      },
    );
  }
}
