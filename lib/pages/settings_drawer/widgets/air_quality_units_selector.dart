import 'package:flutter/material.dart';
import 'package:forecast_v3/models/enums/aqi_unit_model.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class AirQualityUnitsSelector extends StatelessWidget {
  final SettingsDrawerViewModel vm;
  const AirQualityUnitsSelector(this.vm, {final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    switch (vm.aqiUnits) {
      case AQIUnits.us:
        index = 0;
        break;
      case AQIUnits.gb:
        index = 1;
        break;
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'aqi_units'.tr,
            style: TextStyle(color: vm.textColor),
          ),
        ),
        SettingsToggleSwitch(
          context: context,
          initialIndex: index,
          labels: <String>['us_aqi'.tr, 'gb_aqi'.tr],
          onToggleFn: (final dynamic index) =>
              <dynamic>{vm.updateAQIUnits(index)},
          totalSwitches: 2,
          vm: vm,
        ),
      ],
    );
  }
}
