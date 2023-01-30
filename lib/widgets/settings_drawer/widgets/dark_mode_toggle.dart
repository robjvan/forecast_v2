import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/widgets/settings_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeToggle extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;
  const DarkModeToggle(this.viewModel, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    if (viewModel.useDarkMode) {
      index = 1;
    } else {
      index = 0;
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'settings.enable_dark_mode'.tr,
            style: TextStyle(color: viewModel.textColor),
          ),
        ),
        SettingsToggleSwitch(
          context: context,
          initialIndex: index,
          labels: <String>['settings.off'.tr, 'settings.on'.tr],
          onToggleFn: (final _) => <dynamic>{viewModel.toggleDarkMode()},
          totalSwitches: 2,
          viewModel: viewModel,
        ),
      ],
    );
  }
}
