import 'package:flutter/material.dart';
import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/widgets/settings_toggle_switch.dart';
import 'package:get/get.dart';

class LanguageSelector extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;

  const LanguageSelector(this.viewModel, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    final Locale defaultLocale = Get.deviceLocale!;
    if (defaultLocale == const Locale('en')) {
      index = 0;
    } else if (defaultLocale == const Locale('fr')) {
      index = 1;
    } else if (defaultLocale == const Locale('es')) {
      index = 2;
    }

    return ListTile(
      title: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'settings.select_language'.tr,
              style: TextStyle(color: viewModel.textColor),
            ),
          ),
          SettingsToggleSwitch(
            context: context,
            viewModel: viewModel,
            totalSwitches: 3,
            initialIndex: index,
            labels: <String>[
              'settings.en'.tr,
              'settings.fr'.tr,
              'settings.es'.tr,
            ],
            onToggleFn: (final int? index) {
              viewModel.refreshScreen(context);
              switch (index) {
                case 0:
                  Get.updateLocale(const Locale('en'));
                  // context.setLocale(const Locale('en'));
                  break;
                case 1:
                  Get.updateLocale(const Locale('fr'));
                  // context.setLocale(const Locale('fr'));
                  break;
                case 2:
                  Get.updateLocale(const Locale('es'));
                  // context.setLocale(const Locale('es'));
                  break;
              }
            },
          )
        ],
      ),
    );
  }
}
