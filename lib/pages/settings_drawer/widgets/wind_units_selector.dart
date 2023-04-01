import 'package:flutter/material.dart';
import 'package:forecast_v3/models/enums/wind_speed_unit_model.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class WindUnitsSelector extends StatelessWidget {
  final SettingsDrawerViewModel vm;

  const WindUnitsSelector(this.vm, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    switch (vm.windSpeedUnits) {
      case WindSpeedUnits.kph:
        index = 0;
        break;
      case WindSpeedUnits.mph:
        index = 1;
        break;
      case WindSpeedUnits.knots:
        index = 2;
        break;
      case WindSpeedUnits.ms:
        index = 3;
        break;
    }
    return ListTile(
      title: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'wind_speed_units'.tr,
              style: TextStyle(color: vm.textColor),
            ),
          ),
          SettingsToggleSwitch(
            context: context,
            initialIndex: index,
            labels: const <String>['km/h', 'mph', 'knots', 'm/s'],
            onToggleFn: vm.updateWindSpeedUnits,
            totalSwitches: 4,
            vm: vm,
          ),
        ],
      ),
    );
  }
}
