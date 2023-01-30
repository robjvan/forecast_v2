import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast_v3/widgets/settings_drawer/widgets/location_list_tile.dart';
import 'package:flutter/material.dart';

class LocationListWidget extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;
  const LocationListWidget(this.viewModel, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: viewModel.weatherDataList.length,
      itemBuilder: (final BuildContext ctx, final int i) =>
          LocationListTile(viewModel, i),
    );
  }
}
