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
            LocationListWidget(viewModel),
            const SizedBox(height: 8),
          ],
        ),
      );

  Widget _buildAboutAppSection(final SettingsDrawerViewModel viewModel) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: viewModel.panelColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ExpansionTile(
          title: Text(
            'settings.about_app'.tr,
            style: AppStyles.drawerHeaderTextStyle
                .copyWith(color: viewModel.textColor),
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
                        'Forecast',
                        style: TextStyle(
                          color: viewModel.textColor,
                          fontSize: 32.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // TODO(Rob): Replace text in blurb
                  Text(
                    'Ut voluptates laudantium dolorem. Est repudiandae itaque pariatur quaerat reprehenderit consequatur earum ut atque. Amet consequatur nulla. Earum accusantium asperiores similique.',
                    style: TextStyle(color: viewModel.textColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '2023 Rob Vandelinder',
                    style: TextStyle(color: viewModel.textColor),
                  ),
                ],
              ),
            ),
          ],
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
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: Column(
                      children: <Widget>[
                        _buildSettingsSection(viewModel),
                        const SizedBox(height: 16.0),
                        _buildLocationSection(viewModel, sw),
                        const SizedBox(height: 16.0),
                        _buildAboutAppSection(viewModel),
                        const SizedBox(height: 32.0),
                        _buildCloseSettingsBtn(viewModel, context),
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
