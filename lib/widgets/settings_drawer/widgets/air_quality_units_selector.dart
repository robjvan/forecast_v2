import 'package:forecast_v3/models/enums/aqi_unit_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/widgets/settings_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirQualityUnitsSelector extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;
  const AirQualityUnitsSelector(this.viewModel, {final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    switch (viewModel.aqiUnits) {
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
            'settings.aqi-units'.tr,
            style: TextStyle(color: viewModel.textColor),
          ),
        ),
        SettingsToggleSwitch(
          context: context,
          initialIndex: index,
          labels: const <String>['US EPA Index', 'GB Defra Index'],
          onToggleFn: (final dynamic index) =>
              <dynamic>{viewModel.updateAQIUnits(index)},
          totalSwitches: 2,
          viewModel: viewModel,
        ),
      ],
    );
  }
}