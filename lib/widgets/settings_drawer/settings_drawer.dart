import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/widgets/widgets.dart';
import 'package:get/get.dart';

@immutable
class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({final Key? key}) : super(key: key);

  Widget _buildSettingsSection(final SettingsDrawerViewModel viewModel) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: viewModel.panelColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          title: Text(
            'settings.settings_header'.tr,
            style: AppStyles.drawerHeaderTextStyle
                .copyWith(color: viewModel.textColor),
          ),
          iconColor: AppColors.grey,
          collapsedIconColor: AppColors.grey,
          children: <Widget>[
            LanguageSelector(viewModel),
            const SizedBox(height: 16),
            AnimatedBgToggle(viewModel),
            const SizedBox(height: 16),
            DarkModeToggle(viewModel),
            const SizedBox(height: 16),
            TempUnitsSelector(viewModel),
            const SizedBox(height: 16),
            WindUnitsSelector(viewModel),
            const SizedBox(height: 16),
            AirPressureUnitsSelector(viewModel),
            const SizedBox(height: 16),
            AirQualityUnitsSelector(viewModel),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget _buildLocationSection(
    final SettingsDrawerViewModel viewModel,
    final double sw,
  ) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: viewModel.panelColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          // title: _buildLocationsHeader(viewModel),
          title: Text(
            'settings.locations_header'.tr,
            style: AppStyles.drawerHeaderTextStyle
                .copyWith(color: viewModel.textColor),
          ),
          iconColor: AppColors.grey,
          collapsedIconColor: AppColors.grey,
          children: <Widget>[
            LocationSelector(viewModel),
            // _buildLocationSelector(viewModel),
            LocationListWidget(viewModel),
            // _buildLocationsList(viewModel, sw),
          ],
        ),
      );

  Widget _buildAboutAppSection(final SettingsDrawerViewModel viewModel) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: viewModel.panelColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          title: Text(
            'settings.about_app'.tr,
            style: AppStyles.drawerHeaderTextStyle
                .copyWith(color: viewModel.textColor),
          ),
          iconColor: AppColors.grey,
          collapsedIconColor: AppColors.grey,
          children: const <Widget>[],
        ),
      );

  Widget _buildCloseSettingsBtn(
    final SettingsDrawerViewModel viewModel,
    final BuildContext context,
  ) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: viewModel.panelColor,
          // primary: viewModel.panelColor,
          foregroundColor: viewModel.textColor,
          // onPrimary: viewModel.textColor,
        ),
        child: Text('close'.tr, style: AppStyles.settingsButtonStyle),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

  @override
  Widget build(final BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return StoreConnector<AppState, SettingsDrawerViewModel>(
      distinct: true,
      converter: SettingsDrawerViewModel.create,
      builder: (
        final BuildContext context,
        final SettingsDrawerViewModel viewModel,
      ) {
        return Container(
          color: viewModel.drawerColor,
          height: sh,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: <Widget>[
                      _buildSettingsSection(viewModel),
                      const SizedBox(height: 16),
                      _buildLocationSection(viewModel, sw),
                      const SizedBox(height: 16),
                      _buildAboutAppSection(viewModel),
                      const SizedBox(height: 32),
                      _buildCloseSettingsBtn(viewModel, context),
                    ],
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
