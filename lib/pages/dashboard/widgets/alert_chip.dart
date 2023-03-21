import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/widgets/dashboard_widgets_view_model.dart';

class AlertChip extends StatelessWidget {
  const AlertChip({super.key});

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardWidgetsViewModel>(
        distinct: true,
        converter: DashboardWidgetsViewModel.create,
        builder: (
          final BuildContext context,
          final DashboardWidgetsViewModel vm,
        ) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // TODO(Rob): Add dialog for weather alert details using vm.activeAlerts
            },
            child: const Text('ALERT'),
          );
        });
  }
}
