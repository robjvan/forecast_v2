import 'dart:developer';

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

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      child: InkWell(
        onTap: () {
          // log('current index changed to: $index');
          viewModel.dispatch(UpdateCurrentLocationIndexAction(index));
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: viewModel.useAnimatedBackgrounds
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        viewModel.panelColor.withOpacity(
                          index == viewModel.activeIndex ? 0.8 : 0.2,
                        ),
                        BlendMode.dstATop,
                      ),
                      child: WeatherBg(
                        width: sw,
                        height: 60,
                        weatherType: viewModel.weatherType(
                          viewModel.weatherDataList[index]!.currentConditions
                              .condition!.code,
                        ),
                      ),
                    )
                  : Container(
                      width: sw,
                      height: 60,
                      // color: viewModel.textColor.withOpacity(0.2),
                      color: index == viewModel.activeIndex
                          ? Theme.of(context).primaryColor
                          : viewModel.useDarkMode
                              ? const Color(0xFF303030)
                              : AppColors.lightGrey,
                    ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: <Widget>[
                  Text(
                    index == 0
                        ? 'settings.current_location'.tr
                        : '${viewModel.weatherDataList[index]!.location.name!}, ${viewModel.weatherDataList[index]!.location.region!}',
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
                  const Spacer(),
                  index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: index == viewModel.activeIndex
                                ? viewModel.textColor
                                : viewModel.textColor.withOpacity(0.3),
                          ),
                      )
                      : IconButton(
                          onPressed: () {
                            log('Delete pressed');
                            if (viewModel.activeIndex == index) {
                              viewModel.dispatch(
                                UpdateCurrentLocationIndexAction(index - 1),
                              );
                            }
                            viewModel
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
            ),
          ],
        ),
      ),
      
    );
  }
}
