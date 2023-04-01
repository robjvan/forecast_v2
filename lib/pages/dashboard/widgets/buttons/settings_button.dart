import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/dashboard/widgets/dashboard_widgets_view_model.dart';

class SettingsButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SettingsButton(this.scaffoldKey, {super.key});

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardWidgetsViewModel>(
      builder: (final _, final DashboardWidgetsViewModel vm) {
        return IconButton(
          style: IconButton.styleFrom(
            backgroundColor: vm.cardColor.withOpacity(0.5),
          ),
          icon: Icon(Icons.settings, color: vm.textColor),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        );
      },
      converter: DashboardWidgetsViewModel.create,
    );
  }
}
