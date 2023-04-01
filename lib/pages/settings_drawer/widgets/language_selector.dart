import 'package:flutter/material.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

class LanguageSelector extends StatelessWidget {
  final SettingsDrawerViewModel vm;

  const LanguageSelector(this.vm, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    int index = 0;
    if (Get.locale == const Locale('en')) {
      index = 0;
    } else if (Get.locale == const Locale('fr')) {
      index = 1;
    } else if (Get.locale == const Locale('es')) {
      index = 2;
    }

    return ListTile(
      title: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'select_language'.tr,
              style: TextStyle(color: vm.textColor),
            ),
          ),
          SettingsToggleSwitch(
            context: context,
            vm: vm,
            totalSwitches: 3,
            initialIndex: index,
            labels: <String>[
              'en'.tr,
              'fr'.tr,
              'es'.tr,
            ],
            onToggleFn: (final int? index) {
              // vm.refreshScreen(context);
              switch (index) {
                case 0:
                  Get.updateLocale(const Locale('en'));
                  break;
                case 1:
                  Get.updateLocale(const Locale('fr'));
                  break;
                case 2:
                  Get.updateLocale(const Locale('es'));
                  break;
              }
              vm.updateWeatherData();
            },
          )
        ],
      ),
    );
  }
}
