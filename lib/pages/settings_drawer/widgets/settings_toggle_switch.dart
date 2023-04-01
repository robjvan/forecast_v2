import 'package:flutter/material.dart';
import 'package:forecast/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsToggleSwitch extends StatelessWidget {
  final BuildContext context;
  final SettingsDrawerViewModel vm;
  final int totalSwitches;
  final int initialIndex;
  final List<String> labels;
  final Function(int) onToggleFn;

  const SettingsToggleSwitch({
    required this.context,
    required this.vm,
    required this.totalSwitches,
    required this.initialIndex,
    required this.labels,
    required this.onToggleFn,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    List<double> widths = <double>[];
    final double sw = MediaQuery.of(context).size.width - 72;
    final double halfSw = sw / 2;
    final double thirdSw = sw / 3;
    final double quarterSw = sw / 4;

    switch (totalSwitches) {
      case 2:
        widths = <double>[halfSw, halfSw];
        break;
      case 3:
        widths = <double>[thirdSw, thirdSw, thirdSw];
        break;
      case 4:
        widths = <double>[quarterSw, quarterSw, quarterSw, quarterSw];
        break;
    }
    return ToggleSwitch(
      customWidths: widths,
      initialLabelIndex: initialIndex,
      totalSwitches: totalSwitches,
      labels: labels,
      onToggle: (final int? i) => onToggleFn(i!),
      animate: true,
      curve: Curves.easeInOut,
      animationDuration: 250,
      inactiveFgColor: vm.textColor,
      activeFgColor: vm.textColor,
      activeBgColor: <Color>[
        vm.useDarkMode
            ? const Color(0x88D0BCFF)
            : const Color.fromARGB(135, 188, 189, 255)
      ],
      inactiveBgColor:
          vm.useDarkMode ? const Color(0xFF303030) : AppColors.lightGrey,
    );
  }
}
