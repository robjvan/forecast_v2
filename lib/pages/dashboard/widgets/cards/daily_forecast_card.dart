import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/dashboard/widgets/cards/daily_forecast_view_model.dart';
import 'package:forecast/pages/dashboard/widgets/hourly_condition_icon.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@immutable
class DailyForecastCard extends StatelessWidget {
  const DailyForecastCard({super.key});

  /// Build hourly forecast conditions icons
  Widget buildConditionsRow(final DailyForecastViewModel vm) {
    List<Widget> buildRowChildren() {
      final List<Widget> rowChildren = <Widget>[];

      for (int i = 0; i < vm.dailyConditionIcons.length; i++) {
        rowChildren.add(
          ForecastConditionsIcon(
            timeString: vm.dayStrings[i],
            iconUrl: vm.dailyConditionIcons[i],
            chanceOfRain: vm.dailyChanceOfRainSeries[i].toString(),
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
  Widget buildTempChart(final DailyForecastViewModel vm) {
    return vm.lowestTemp != 400
        ? SizedBox(
            height: 160,
            child: SfCartesianChart(
              enableSideBySideSeriesPlacement: true,
              primaryXAxis: CategoryAxis(
                isVisible: false,
              ),
              plotAreaBorderWidth: 0,
              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(color: vm.textColor),
                minimum: vm.lowestTemp - 3,
                maximum: vm.highestTemp + 3,
              ),
              series: <SplineSeries<DailyTemp, String>>[
                SplineSeries<DailyTemp, String>(
                  splineType: SplineType.monotonic,
                  dataSource: vm.dailyHighDataSeries,
                  color: Colors.red.withOpacity(0.8),
                  xValueMapper: (final DailyTemp day, final _) => day.day,
                  yValueMapper: (final DailyTemp day, final _) => day.temp,
                  markerSettings: const MarkerSettings(
                    height: 4,
                    width: 4,
                    isVisible: true,
                  ),
                  dataLabelSettings: DataLabelSettings(
                    textStyle: TextStyle(color: vm.textColor),
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,
                  ),
                ),
                SplineSeries<DailyTemp, String>(
                  splineType: SplineType.monotonic,
                  dataSource: vm.dailyLowDataSeries,
                  color: Colors.blueAccent,
                  xValueMapper: (final DailyTemp day, final _) => day.day,
                  yValueMapper: (final DailyTemp day, final _) => day.temp,
                  markerSettings: const MarkerSettings(
                    height: 4,
                    width: 4,
                    isVisible: true,
                  ),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.bottom,
                    textStyle: TextStyle(color: vm.textColor),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, DailyForecastViewModel>(
      distinct: true,
      converter: DailyForecastViewModel.create,
      builder: (final _, final DailyForecastViewModel vm) {
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
