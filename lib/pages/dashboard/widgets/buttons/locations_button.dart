import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/pages/dashboard/widgets/dashboard_widgets_view_model.dart';
import 'package:forecast_v3/redux/app_state.dart';

class LocationsButton extends StatelessWidget {
  const LocationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashboardWidgetsViewModel>(
      builder: (final _, final DashboardWidgetsViewModel vm) {
        return IconButton(
          style: IconButton.styleFrom(
            backgroundColor: vm.cardColor.withOpacity(0.5),
          ),
          icon: Icon(Icons.location_city, color: vm.textColor),
          onPressed: () {
            // TODO(Rob): Add dialog to change current location
          },
        );
      },
      converter: DashboardWidgetsViewModel.create,
    );
  }
}
