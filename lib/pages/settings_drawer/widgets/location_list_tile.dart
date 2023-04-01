import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/settings_drawer/settings_drawer_view_model.dart';
import 'package:forecast/redux/actions.dart';
import 'package:forecast/utilities/utilities.dart';
import 'package:get/get.dart';

class LocationListTile extends StatelessWidget {
  final int index;

  const LocationListTile(this.index, {final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;

    String getCityName(final SettingsDrawerViewModel vm) {
      return index == 0
          ? '${'current_location'.tr}, ${vm.weatherDataList[index]!.currentConditions.temp_c!.round()}c'
          : '${vm.weatherDataList[index]!.location.name!}, ${vm.weatherDataList[index]!.currentConditions.temp_c!.round()}c';
    }

    Widget buildConfirmDeleteDialog(final SettingsDrawerViewModel vm) {
      final String locationName = index == 0
          ? 'current_location'.tr
          : vm.weatherDataList[index]!.location.name!;

      return SimpleDialog(
        contentPadding: const EdgeInsets.all(16.0),
        backgroundColor: vm.cardColor,
        children: <Widget>[
          Text(
            'Are you sure you want to delete',
            style: TextStyle(
              color: vm.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '$locationName?',
            style: TextStyle(
              color: vm.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            'This cannot be undone!',
            style: TextStyle(
              color: vm.textColor,
              fontStyle: FontStyle.italic,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: Get.back,
                child: Text(
                  'cancel'.tr,
                  style: const TextStyle(color: AppColors.lavender),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: vm.useDarkMode
                      ? const Color(0x88D0BCFF)
                      : const Color.fromARGB(135, 188, 189, 255),
                ),
                onPressed: () => Get.back(result: true),
                child: Text(
                  'ok'.tr,
                  style: TextStyle(
                    color: vm.textColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget buildTileBackground(final SettingsDrawerViewModel vm) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: vm.useAnimatedBackgrounds
            ? index == vm.activeIndex
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      vm.cardColor.withOpacity(
                        index == vm.activeIndex ? 0.8 : 0.3,
                      ),
                      BlendMode.dstATop,
                    ),
                    child: WeatherBg(
                      width: sw,
                      height: 48,
                      weatherType: vm.weatherType(
                        vm.weatherDataList[index]!.currentConditions.condition!
                                .code ??
                            1000,
                        index,
                      ),
                    ),
                  )
                : Container(
                    width: sw,
                    height: 48,
                    color: index == vm.activeIndex
                        ? Theme.of(context).primaryColor
                        : vm.useDarkMode
                            ? AppColors.locationTileDarkGrey
                            : AppColors.lightGrey,
                  )
            : Container(
                width: sw,
                height: 48,
                color: index == vm.activeIndex
                    ? Theme.of(context).primaryColor
                    : vm.useDarkMode
                        ? AppColors.locationTileDarkGrey
                        : AppColors.lightGrey,
              ),
      );
    }

    Widget buildTileContent(final SettingsDrawerViewModel vm) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: sw - 136,
              child: Text(
                getCityName(vm),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: index == vm.activeIndex
                      ? vm.textColor
                      : vm.textColor.withOpacity(0.6),
                  fontWeight: index == vm.activeIndex
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
                      color: index == vm.activeIndex
                          ? vm.textColor
                          : vm.textColor.withOpacity(0.3),
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      bool confirmDelete = false;
                      confirmDelete =
                          await Get.dialog(buildConfirmDeleteDialog(vm)) ??
                              false;

                      if (confirmDelete) {
                        /**
                       * Check if our activeIndex is higher than the 
                       * index of the location being deleted.
                       * If so, we need to decrement our activeIndex 
                       * to avoid out of range errors
                       */
                        if (vm.activeIndex >= index) {
                          vm.dispatch(
                            UpdateCurrentLocationIndexAction(
                              vm.activeIndex - 1,
                            ),
                          );
                          vm.saveUserSettings();
                        }

                        /// Dispatch action to remove location from lists
                        await vm.dispatch(removeLocationFromListAction(index));
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: index == vm.activeIndex
                          ? vm.textColor
                          : vm.textColor.withOpacity(0.3),
                    ),
                  ),
          ],
        ),
      );
    }

    return StoreConnector<AppState, SettingsDrawerViewModel>(
      distinct: true,
      converter: SettingsDrawerViewModel.create,
      builder: (final _, final SettingsDrawerViewModel vm) {
        return Container(
          height: 48,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 2,
          ),
          child: InkWell(
            onTap: () {
              vm.dispatch(UpdateCurrentLocationIndexAction(index));
              vm.saveUserSettings();
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                buildTileBackground(vm),
                buildTileContent(vm),
              ],
            ),
          ),
        );
      },
    );
  }
}
