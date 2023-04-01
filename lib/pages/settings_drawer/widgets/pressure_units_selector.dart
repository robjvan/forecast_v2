import 'package:flutter/material.dart';
import 'package:forecast_v3/models/enums/air_pressure_unit_model.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class AirPressureUnitsSelector extends StatelessWidget {
  final SettingsDrawerViewModel vm;
  const AirPressureUnitsSelector(this.vm, {final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    switch (vm.airPressureUnits) {
      case AirPressureUnits.kpa:
        index = 0;
        break;
      case AirPressureUnits.inch:
        index = 1;
        break;
      case AirPressureUnits.mbar:
        index = 2;
        break;
      case AirPressureUnits.atm:
        index = 3;
        break;
    }
    return ListTile(
      title: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'air_pressure_units'.tr,
              style: TextStyle(color: vm.textColor),
            ),
          ),
          SettingsToggleSwitch(
            context: context,
            initialIndex: index,
            labels: const <String>['Kpa', 'inch', 'Mbar', 'ATM'],
            onToggleFn: vm.updateAirPressureUnits,
            totalSwitches: 4,
            vm: vm,
          ),
        ],
      ),
    );
  }
}
