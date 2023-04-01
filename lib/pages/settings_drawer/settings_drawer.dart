import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/pages/settings_drawer/widgets/widgets.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:get/get.dart';

@immutable
class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({final Key? key}) : super(key: key);

  /// Build the settings section
  Widget _buildSettingsSection(final SettingsDrawerViewModel vm) {
    Widget _buildDivider() => const Divider(endIndent: 16.0, indent: 16.0);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: vm.cardColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ExpansionTile(
          title: Text(
            'settings_header'.tr,
            style:
                AppStyles.drawerHeaderTextStyle.copyWith(color: vm.textColor),
          ),
          iconColor: AppColors.grey,
          collapsedIconColor: AppColors.grey,
          children: <Widget>[
            TempUnitsSelector(vm),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: WindUnitsSelector(vm),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AirPressureUnitsSelector(vm),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: AirQualityUnitsSelector(vm),
            ),
            _buildDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AnimatedBgToggle(vm),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: DarkModeToggle(vm),
            ),
            _buildDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: LanguageSelector(vm),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the location selector section
  Widget _buildLocationSection(final SettingsDrawerViewModel vm) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: vm.cardColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(bottom: 8.0),
        title: Text(
          'locations_header'.tr,
          style: AppStyles.drawerHeaderTextStyle.copyWith(color: vm.textColor),
        ),
        iconColor: AppColors.grey,
        collapsedIconColor: AppColors.grey,
        children: <Widget>[
          LocationSelector(vm),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(indent: 16.0, endIndent: 16.0),
          ),
          LocationListWidget(vm),
        ],
      ),
    );
  }

  /// Build the about app section
  Widget _buildAboutAppSection(final SettingsDrawerViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: vm.cardColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ExpansionTile(
          title: Text(
            'about_app'.tr,
            style:
                AppStyles.drawerHeaderTextStyle.copyWith(color: vm.textColor),
          ),
          iconColor: AppColors.grey,
          collapsedIconColor: AppColors.grey,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo/app_icon.png',
                        fit: BoxFit.cover,
                        height: 64.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'app_title'.tr,
                        style: TextStyle(
                          color: vm.textColor,
                          fontSize: 32.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'about-blurb'.tr,
                    style: TextStyle(color: vm.textColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'location-data-blurb'.tr,
                    style: TextStyle(
                      color: vm.textColor,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '2023 Rob Vandelinder',
                    style: TextStyle(color: vm.textColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build a close button
  Widget _buildCloseSettingsBtn(final SettingsDrawerViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: vm.cardColor,
          foregroundColor: vm.textColor,
          // foregroundColor: vm.useDarkMode
          //     ? const Color(0xDDD0BCFF)
          //     : const Color(0xFFD0BCFF),
        ),
        onPressed: Get.back,
        child: Text('close'.tr, style: AppStyles.settingsButtonStyle),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final double sh = MediaQuery.of(context).size.height;

    return StoreConnector<AppState, SettingsDrawerViewModel>(
      distinct: true,
      converter: SettingsDrawerViewModel.create,
      builder: (
        final BuildContext context,
        final SettingsDrawerViewModel vm,
      ) {
        return Container(
          color: vm.drawerColor,
          height: sh,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: Column(
                      children: <Widget>[
                        _buildLocationSection(vm),
                        _buildSettingsSection(vm),
                        _buildAboutAppSection(vm),
                        _buildCloseSettingsBtn(vm),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
