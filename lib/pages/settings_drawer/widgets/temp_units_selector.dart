import 'package:flutter/material.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class TempUnitsSelector extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;
  const TempUnitsSelector(this.viewModel, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    switch (viewModel.tempUnits) {
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
              style: TextStyle(color: viewModel.textColor),
            ),
          ),
          SettingsToggleSwitch(
            context: context,
            viewModel: viewModel,
            totalSwitches: 3,
            initialIndex: index,
            labels: const <String>['C', 'F', 'K'],
            onToggleFn: viewModel.updateTempUnits,
          )
        ],
      ),
    );
  }
}
