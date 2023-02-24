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

  Widget _buildSettingsSection(final SettingsDrawerViewModel viewModel) {
    Widget _buildDivider() => const Divider(endIndent: 16.0, indent: 16.0);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: viewModel.panelColor,
          borderRadius: BorderRadius.circular(8.0),
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
            TempUnitsSelector(viewModel),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: WindUnitsSelector(viewModel),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AirPressureUnitsSelector(viewModel),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: AirQualityUnitsSelector(viewModel),
            ),
            _buildDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AnimatedBgToggle(viewModel),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: DarkModeToggle(viewModel),
            ),
            _buildDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: LanguageSelector(viewModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection(final SettingsDrawerViewModel viewModel) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: viewModel.panelColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(bottom: 8.0),
        title: Text(
          'settings.locations_header'.tr,
          style: AppStyles.drawerHeaderTextStyle
              .copyWith(color: viewModel.textColor),
        ),
        iconColor: AppColors.grey,
        collapsedIconColor: AppColors.grey,
        children: <Widget>[
          LocationSelector(viewModel),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Divider(indent: 16.0, endIndent: 16.0),
          ),
          LocationListWidget(viewModel),
        ],
      ),
    );
  }

  Widget _buildAboutAppSection(final SettingsDrawerViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: DecoratedBox(
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
      ),
    );
  }

  Widget _buildCloseSettingsBtn(final SettingsDrawerViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: viewModel.panelColor,
          // primary: viewModel.panelColor,
          foregroundColor: viewModel.textColor,
          // onPrimary: viewModel.textColor,
        ),
        onPressed: Get.back,
        child: Text('close'.tr, style: AppStyles.settingsButtonStyle),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    // final double sw = MediaQuery.of(context).size.width;
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
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: Column(
                      children: <Widget>[
                        _buildLocationSection(viewModel),
                        _buildSettingsSection(viewModel),
                        _buildAboutAppSection(viewModel),
                        _buildCloseSettingsBtn(viewModel),
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
