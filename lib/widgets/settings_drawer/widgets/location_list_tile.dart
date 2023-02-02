
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast_v3/redux/actions.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:forecast_v3/widgets/settings_drawer/settings_drawer_view_model.dart';
import 'package:get/get.dart';

class LocationListTile extends StatelessWidget {
  final SettingsDrawerViewModel viewModel;
  final int index;

  const LocationListTile(this.viewModel, this.index, {final Key? key})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;

    String getCityName() {
      return index == 0
          ? '${'settings.current_location'.tr}, ${viewModel.weatherDataList[index]!.currentConditions.temp_c!.round()}c'
          : '${viewModel.weatherDataList[index]!.location.name!}, ${viewModel.weatherDataList[index]!.currentConditions.temp_c!.round()}c';
    }

    Widget buildTileBackground(final SettingsDrawerViewModel viewModel) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: viewModel.useAnimatedBackgrounds
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                  viewModel.panelColor.withOpacity(
                    index == viewModel.activeIndex ? 0.8 : 0.3,
                  ),
                  BlendMode.dstATop,
                ),
                child: WeatherBg(
                  width: sw,
                  height: 48,
                  weatherType: viewModel.weatherType(
                    viewModel.weatherDataList[index]!.currentConditions
                            .condition!.code ??
                        1000,
                    index,
                  ),
                ),
              )
            : Container(
                width: sw,
                height: 48,
                color: index == viewModel.activeIndex
                    ? Theme.of(context).primaryColor
                    : viewModel.useDarkMode
                        ? AppColors.locationTileDarkGrey
                        : AppColors.lightGrey,
              ),
      );
    }

    Widget buildTileContent(final SettingsDrawerViewModel viewModel) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: sw - 136,
              child: Text(
                getCityName(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: index == viewModel.activeIndex
                      ? viewModel.textColor
                      : viewModel.textColor.withOpacity(0.6),
                  fontWeight: index == viewModel.activeIndex
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            const Spacer(),
            index == 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: index == viewModel.activeIndex
                          ? viewModel.textColor
                          : viewModel.textColor.withOpacity(0.3),
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      /**
                       * Check if our activeIndex is higher than the 
                       * index of the location being deleted.
                       * If so, we need to decrement our activeIndex 
                       * to avoid out of range errors
                       */
                      if (viewModel.activeIndex >= index) {
                        viewModel.dispatch(
                          UpdateCurrentLocationIndexAction(
                            viewModel.activeIndex - 1,
                          ),
                        );
                      }

                      /// Dispatch action to remove location from lists
                      await viewModel
                          .dispatch(removeLocationFromListAction(index));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: index == viewModel.activeIndex
                          ? viewModel.textColor
                          : viewModel.textColor.withOpacity(0.3),
                    ),
                  ),
          ],
        ),
      );
    }

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      child: InkWell(
        onTap: () =>
            viewModel.dispatch(UpdateCurrentLocationIndexAction(index)),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            buildTileBackground(viewModel),
            buildTileContent(viewModel),
          ],
        ),
      ),
    );
  }
}
