import 'package:flutter/material.dart';
import 'package:forecast/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class AnimatedBgToggle extends StatelessWidget {
  final SettingsDrawerViewModel vm;

  const AnimatedBgToggle(this.vm, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    if (vm.useAnimatedBackgrounds) {
      index = 1;
    } else {
      index = 0;
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'enable_backgrounds'.tr,
            style: TextStyle(color: vm.textColor),
          ),
        ),
        SettingsToggleSwitch(
          context: context,
          initialIndex: index,
          labels: <String>['off'.tr, 'on'.tr],
          onToggleFn: (final _) =>
              <dynamic>{vm.toggleAnimatedBackgrounds()},
          totalSwitches: 2,
          vm: vm,
        ),
      ],
    );
  }
}
