import 'package:forecast_v3/models/enums/wind_speed_unit_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/widgets/settings_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WindUnitsSelector extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;

  const WindUnitsSelector(this.viewModel, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    switch (viewModel.windSpeedUnits) {
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
              'settings.wind_speed_units'.tr,
              style: TextStyle(color: viewModel.textColor),
            ),
          ),
          SettingsToggleSwitch(
            context: context,
            initialIndex: index,
            labels: const <String>['km/h', 'mph', 'knots', 'm/s'],
            onToggleFn: viewModel.updateWindSpeedUnits,
            totalSwitches: 4,
            viewModel: viewModel,
          ),
        ],
      ),
    );
  }
}
