import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';

class LocationSelector extends StatefulWidget {
  final SettingsDrawerViewModel viewModel;
  const LocationSelector(this.viewModel, {final Key? key}) : super(key: key);

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: widget.viewModel.textColor),
      ),
      child: TextField(
        style: TextStyle(
          fontSize: 16,
          overflow: TextOverflow.visible,
          color: widget.viewModel.textColor,
        ),
        controller: _locationController,
        onChanged: (final String locToSearch) async {
          // TODO(Rob): Add Google Places autocomplete logic here to show suggestions as the user types
        },
        // onEditingComplete: () {
        //   //
        // },
        decoration: InputDecoration(
          icon: Container(
            margin: const EdgeInsets.only(left: 16),
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              AppIcons.searchLocation,
              color: widget.viewModel.textColor,
            ),
          ),
          isDense: true,
          hintText: tr('settings.find_location'),
          hintStyle: TextStyle(
            color: widget.viewModel.textColor.withOpacity(0.6),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
