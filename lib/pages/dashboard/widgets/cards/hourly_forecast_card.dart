import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/dashboard/widgets/cards/hourly_forecast_view_model.dart';
import 'package:forecast/pages/dashboard/widgets/hourly_condition_icon.dart';
import 'package:forecast/redux/app_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@immutable
class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({super.key});

  /// Build hourly forecast conditions icons
  Widget buildConditionsRow(final HourlyForecastViewModel vm) {
    List<Widget> buildRowChildren() {
      final List<Widget> rowChildren = <Widget>[];

      for (int i = 0; i < vm.hourlyConditionIcons.length; i++) {
        rowChildren.add(
          ForecastConditionsIcon(
            timeString: vm.timeStrings[i],
            iconUrl: vm.hourlyConditionIcons[i],
            chanceOfRain: vm.hourlyChanceOfRainSeries[i].toString(),
          ),
        );
      }
      return rowChildren;
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 24),
        width: 325,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: buildRowChildren(),
        ),
      ),
    );
  }

  /// Build the hourly forecast chart
  Widget buildTempChart(final HourlyForecastViewModel vm) {
    return vm.lowestTemp != 400
        ? SizedBox(
            height: 160,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(color: vm.textColor),
                minimum: vm.lowestTemp.round() - 3,
                maximum: vm.highestTemp.round() + 3,
              ),
              primaryXAxis: CategoryAxis(
                // rangePadding: ChartRangePadding.round,
                isVisible: false,
              ),
              series: <ChartSeries<dynamic, dynamic>>[
                SplineSeries<dynamic, dynamic>(
                  dataSource: vm.hourlyChartDataSeries,
                  xValueMapper: (final dynamic data, final _) => data.hour,
                  yValueMapper: (final dynamic data, final _) => data.temp,
                  splineType: SplineType.monotonic,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.bottom,
                    textStyle: TextStyle(color: vm.textColor),
                  ),
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    height: 4,
                    width: 4,
                  ),
                  color: Colors.green,
                ),
              ],
            ),
          )
        : Container();
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, HourlyForecastViewModel>(
      distinct: true,
      converter: HourlyForecastViewModel.create,
      builder: (final _, final HourlyForecastViewModel vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: vm.cardColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: <Widget>[
                buildConditionsRow(vm),
                buildTempChart(vm),
              ],
            ),
          ),
        );
      },
    );
  }
}
