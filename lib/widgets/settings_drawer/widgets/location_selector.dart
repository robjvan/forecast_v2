import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

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
      child: GooglePlaceAutoCompleteTextField(
        googleAPIKey: AppKeys.googleApiKey,
        textStyle: TextStyle(
          fontSize: 16,
          overflow: TextOverflow.visible,
          color: widget.viewModel.textColor,
        ),
        textEditingController: _locationController,
        // countries: const <String>['ca', 'us', 'uk'],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (final Prediction prediction) {
          /// This method will return latlng with place detail
          final Location newLocation = Location(
            latitude: double.parse(prediction.lat!),
            longitude: double.parse(prediction.lng!),
            name: prediction.description!.split(', ')[0],
            region: prediction.description!.split(', ').length > 1
                ? prediction.description!.split(', ')[1]
                : '',
          );
          widget.viewModel.dispatch(addLocationToListAction(newLocation));
        },
        itmClick: (final Prediction prediction) {
          _locationController.clear();
        },
        inputDecoration: InputDecoration(
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
          hintText: 'settings.find_location'.tr,
          hintStyle: TextStyle(
            color: widget.viewModel.textColor.withOpacity(0.6),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
