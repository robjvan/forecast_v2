import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/pages/dashboard/widgets/dashboard_widgets_view_model.dart';
import 'package:forecast_v3/redux/app_state.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:get/get.dart';

class EnvironmentalConditionsBox extends StatelessWidget {
  const EnvironmentalConditionsBox({super.key});

  /// Container for sections to ensure proper sizing
  Widget buildSection(final Widget child) {
    return SizedBox(width: (Get.width / 2) - 32, height: 80, child: child);
  }

  /// Section for Humidity and UV data
  Widget buildHumidityUVSection(final DashboardWidgetsViewModel vm) {
    return buildSection(
      Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Humidity', // Todo(Rob): Add i18n strings
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '66%', // Todo(Rob): Add dynamic values
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
                  'UV Index', // Todo(Rob): Add i18n strings
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '1', // Todo(Rob): Add dynamic values
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Section for Air Quality data
  Widget buildAirQualitySection(final DashboardWidgetsViewModel vm) {
    return buildSection(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Air Quality', // Todo(Rob): Add i18n strings
            style: AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '1', // Todo(Rob): Add dynamic values
            style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
          ),
          Text(
            '(Good)', // Todo(Rob): Add dynamic values
            style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
          ),
        ],
      ),
    );
  }

  /// Section for Wind data
  Widget buildWindSection(final DashboardWidgetsViewModel vm) {
    Widget buildWindCompass() {
      return Container(
        height: 40,
        width: 60,
        child: Center(
          child: Text(
            'WSW', // Todo(Rob): Add dynamic values
            style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
          ),
        ),
      );
    }

    return buildSection(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Wind', // Todo(Rob): Add i18n strings
            style: AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '42.1', // Todo(Rob): Add dynamic values
                    style: AppStyles.dataCardDataStyle
                        .copyWith(color: vm.textColor),
                  ),
                  Text(
                    'km/h', // Todo(Rob): Add dynamic values
                    style: AppStyles.dataCardDataStyle
                        .copyWith(color: vm.textColor),
                  ),
                ],
              ),
              buildWindCompass(),
            ],
          ),
        ],
      ),
    );
  }

  /// Section for Air Pressure data
  Widget buildAirPressureSection(final DashboardWidgetsViewModel vm) {
    return buildSection(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Air Pressure', // Todo(Rob): Add i18n strings
            style: AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '99.0 kPa', // Todo(Rob): Add dynamic values
            style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
          ),
        ],
      ),
    );
  }

  /// Build our widget content
  Widget buildContent(final DashboardWidgetsViewModel vm) {
    return SizedBox(
      width: Get.width,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildHumidityUVSection(vm),
              buildAirQualitySection(vm),
            ],
          ),
          Column(
            children: <Widget>[
              buildWindSection(vm),
              buildAirPressureSection(vm),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardWidgetsViewModel>(
      distinct: true,
      converter: DashboardWidgetsViewModel.create,
      builder: (final _, final DashboardWidgetsViewModel vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
