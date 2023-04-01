import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/dashboard/widgets/dashboard_widgets_view_model.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:get/get.dart';

@immutable

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardWidgetsViewModel>(
      distinct: true,
      converter: DashboardWidgetsViewModel.create,
      builder: (final _, final DashboardWidgetsViewModel vm) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'loading'.tr,
                  style: AppStyles.loadingMessageTextStyle,
                ),
                const SizedBox(height: 32.0),
                const CircularProgressIndicator(
                  strokeWidth: 5,
                  color: AppColors.lavender,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
