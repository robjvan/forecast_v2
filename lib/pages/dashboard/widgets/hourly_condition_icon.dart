import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/dashboard/widgets/dashboard_widgets_view_model.dart';
import 'package:forecast_v3/utilities/utilities.dart';

@immutable
class ForecastConditionsIcon extends StatelessWidget {
  final String timeString;
  final String iconUrl;
  final String chanceOfRain;

  const ForecastConditionsIcon({
    required this.timeString,
    required this.iconUrl,
    required this.chanceOfRain,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DashboardWidgetsViewModel>(
      distinct: true,
      converter: DashboardWidgetsViewModel.create,
      builder: (final _, final DashboardWidgetsViewModel vm) {
        return Column(
          children: <Widget>[
            Text(
              timeString,
              style:
                  AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            ),
            const SizedBox(height: 4),
            CachedNetworkImage(
              imageUrl: iconUrl,
              width: 40,
            ),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/water_drop2.png',
                  height: 12,
                  color: vm.textColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '$chanceOfRain%',
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
