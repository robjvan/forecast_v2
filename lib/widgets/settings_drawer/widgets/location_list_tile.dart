import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
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
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white
                    .withOpacity(index == viewModel.activeIndex ? 0.9 : 0.6),
                BlendMode.dstATop,
              ),
              child: WeatherBg(
                width: sw,
                height: 50,
                weatherType: viewModel.weatherType(
                  viewModel.weatherDataList[index]!.currentConditions.condition!
                      .code,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: <Widget>[
                Text(
                  index == 0
                      ? 'settings.current_location'.tr
                      : viewModel.weatherDataList[index]!.location.name!,
                  style: TextStyle(
                    color: viewModel.textColor,
                    fontWeight: index == viewModel.activeIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                const Spacer(),
                index == 0
                    ? Icon(
                        Icons.location_on_outlined,
                        color: viewModel.textColor,
                      )
                    : const Icon(Icons.delete)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
