import 'package:flutter/material.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class TempUnitsSelector extends StatelessWidget {
  final SettingsDrawerViewModel vm;
  const TempUnitsSelector(this.vm, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    switch (vm.tempUnits) {
      case 'c':
        index = 0;
        break;
      case 'F':
        index = 1;
        break;
      case 'K':
        index = 2;
        break;
    }
    return ListTile(
      title: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'temp_units'.tr,
              style: TextStyle(color: vm.textColor),
            ),
          ),
          SettingsToggleSwitch(
            context: context,
            vm: vm,
            totalSwitches: 3,
            initialIndex: index,
            labels: const <String>['C', 'F', 'K'],
            onToggleFn: vm.updateTempUnits,
          )
        ],
      ),
    );
  }
}
