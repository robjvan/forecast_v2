import 'package:flutter/material.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class AnimatedBgToggle extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;

  const AnimatedBgToggle(this.viewModel, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    if (viewModel.useAnimatedBackgrounds) {
      index = 1;
    } else {
      index = 0;
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'settings.enable_backgrounds'.tr,
            style: TextStyle(color: viewModel.textColor),
          ),
        ),
        SettingsToggleSwitch(
          context: context,
          initialIndex: index,
          labels: <String>['settings.off'.tr, 'settings.on'.tr],
          onToggleFn: (final _) =>
              <dynamic>{viewModel.toggleAnimatedBackgrounds()},
          totalSwitches: 2,
          viewModel: viewModel,
        ),
      ],
    );
  }
}
