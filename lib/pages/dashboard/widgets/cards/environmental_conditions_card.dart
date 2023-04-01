import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/pages/dashboard/widgets/cards/environmental_conditions_view_model.dart';
import 'package:forecast/redux/app_state.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

@immutable
class EnvironmentalConditionsCard extends StatelessWidget {
  const EnvironmentalConditionsCard({super.key});

  /// Container for sections to ensure proper sizing
  Widget buildSection(final Widget child) {
    return SizedBox(
      width: (Get.width / 2) - 16,
      height: 72,
      child: child,
    );
  }
  

  /// Section for Humidity and UV data
  Widget buildHumidityUVSection(final EnvironmentalConditionsViewModel vm) {
    return buildSection(
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'humidity'.tr,
                style:
                    AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${vm.humidity}',
                style: AppStyles.dataCardDataStyle.copyWith(
                  color: vm.textColor,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'uvindex'.tr,
                style:
                    AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${vm.uvIndex}',
                style:
                    AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section for Air Quality data
  Widget buildAirQualitySection(final EnvironmentalConditionsViewModel vm) {
    return buildSection(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'airquality'.tr,
            style: AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${vm.aqi}',
            style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '(${vm.airQualityString})',
            style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
          ),
        ],
      ),
    );
  }

  /// Section for Wind data
  Widget buildWindSection(final EnvironmentalConditionsViewModel vm) {
    Widget buildWindCompass() {
      return SizedBox(
        width: 60,
        height: 44,
        child: Stack(
          children: <Widget>[
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  axisLineStyle: AxisLineStyle(
                    thickness: 3,
                    color: vm.cardColor.withOpacity(0.3),
                  ),
                  minimum: 0,
                  maximum: 360,
                  pointers: <MarkerPointer>[
                    MarkerPointer(
                      color: Colors.blue,
                      elevation: 4,
                      markerType: MarkerType.triangle,
                      value: vm.windDegrees.toDouble(),
                    ),
                  ],
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  showLabels: false,
                ),
              ],
            ),
            Center(
              child: Text(
                vm.windDirection,
                style: AppStyles.dataCardDataStyle.copyWith(
                  color: vm.textColor,
                  // fontSize: 12,
                ),
              ),
            )
          ],
        ),
      );
    }

    return buildSection(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'wind'.tr,
            style: AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${vm.windSpeed}',
                    style: AppStyles.dataCardDataStyle
                        .copyWith(color: vm.textColor),
                  ),
                  Text(
                    vm.windSpeedUnitsString,
                    style: AppStyles.dataCardDataStyle
                        .copyWith(color: vm.textColor),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              buildWindCompass(),
            ],
          ),
        ],
      ),
    );
  }

  /// Section for Air Pressure data
  Widget buildAirPressureSection(final EnvironmentalConditionsViewModel vm) {
    return buildSection(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'airpressure'.tr,
            style: AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${vm.airPressure} ${vm.pressureUnitsString}',
            style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
          ),
        ],
      ),
    );
  }

  /// Build our widget content
  Widget buildContent(final EnvironmentalConditionsViewModel vm) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              buildHumidityUVSection(vm),
              buildAirQualitySection(vm),
            ],
          ),
          Column(
            children: <Widget>[
              buildAirPressureSection(vm),
              buildWindSection(vm),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, EnvironmentalConditionsViewModel>(
      distinct: true,
      converter: EnvironmentalConditionsViewModel.create,
      builder: (final _, final EnvironmentalConditionsViewModel vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
