import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/dashboard/widgets/dialogs/weather_alert_dialog_view_model.dart';
import 'package:forecast/utilities/theme.dart';
import 'package:get/get.dart';

@immutable
class WeatherAlertDialog extends StatelessWidget {
  const WeatherAlertDialog({super.key});

  @override
  Widget build(final BuildContext context) {
    /// Build our header section
    Widget buildHeader(final WeatherAlertDialogViewModel vm) {
      return Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Text(
                  vm.msgType.isNotEmpty ? vm.msgType : 'alert'.tr,
                  style: AppStyles.drawerHeaderTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: vm.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ), // api msgtype
              vm.headline.isNotEmpty
                  ? Text(
                      vm.headline,
                      style: AppStyles.dataCardDataStyle
                          .copyWith(color: vm.textColor),
                    )
                  : Container(),
              const SizedBox(height: 8),
            ],
          ),
        ],
      );
    }

    /// Build severity section
    Widget buildSeverity(final WeatherAlertDialogViewModel vm) {
      return vm.severity.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'severity'.tr,
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                ),
                Text(
                  vm.severity,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
                const SizedBox(height: 8),
              ],
            )
          : Container();
    }

    /// Build areas section
    Widget buildAreas(final WeatherAlertDialogViewModel vm) {
      return vm.areas.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'areas-affected'.tr,
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                ),
                Text(
                  vm.areas,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
                const SizedBox(height: 8),
              ],
            )
          : Container();
    }

    /// Build centainty section
    Widget buildCertainty(final WeatherAlertDialogViewModel vm) {
      return vm.certainty.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'certainty'.tr,
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                ),
                Text(
                  vm.certainty,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
                const SizedBox(height: 8),
              ],
            )
          : Container();
    }

    /// Build urgency section
    Widget buildUrgency(final WeatherAlertDialogViewModel vm) {
      return vm.urgency.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'urgency'.tr,
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                ),
                Text(
                  vm.urgency,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
                const SizedBox(height: 8),
              ],
            )
          : Container();
    }

    /// Build effective section
    Widget buildEffective(final WeatherAlertDialogViewModel vm) {
      return vm.effective.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'effective'.tr,
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                ),
                Text(
                  vm.effective,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
                const SizedBox(height: 8),
              ],
            )
          : Container();
    }

    /// Build expires section
    Widget buildExpires(final WeatherAlertDialogViewModel vm) {
      return vm.expires.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'expires'.tr,
                  style: AppStyles.dataCardHeaderStyle.copyWith(
                    color: vm.textColor,
                  ),
                ),
                Text(
                  vm.expires,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
                const SizedBox(height: 8),
              ],
            )
          : Container();
    }

    /// Build description section
    Widget buildDescription(final WeatherAlertDialogViewModel vm) {
      return vm.description.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'description'.tr,
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                ),
                Text(
                  vm.description,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ),
                const SizedBox(height: 8),
              ],
            )
          : Container();
    }

    /// Build description section
    Widget buildInstructions(final WeatherAlertDialogViewModel vm) {
      return vm.instruction.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'instructions'.tr,
                  style: AppStyles.dataCardHeaderStyle
                      .copyWith(color: vm.textColor),
                ),
                Text(
                  vm.instruction,
                  style:
                      AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
                ), // api instruction
              ],
            )
          : Container();
    }

    /// Build our OK button
    Widget buildOkButton(final WeatherAlertDialogViewModel vm) {
      return Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: vm.cardColor,
            foregroundColor: vm.textColor,
          ),
          onPressed: Get.back,
          child: Text('ok'.tr),
        ),
      );
    }

    return StoreConnector<AppState, WeatherAlertDialogViewModel>(
      distinct: true,
      converter: WeatherAlertDialogViewModel.create,
      builder: (final _, final WeatherAlertDialogViewModel vm) {
        return Dialog(
          backgroundColor: vm.cardColor,
          insetPadding: const EdgeInsets.all(32),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildHeader(vm),
                      buildSeverity(vm),
                      buildAreas(vm),
                      buildCertainty(vm),
                      buildUrgency(vm),
                      buildEffective(vm),
                      buildExpires(vm),
                      buildDescription(vm),
                      buildInstructions(vm),
                      buildOkButton(vm),
                    ],
                  ),
                ),
                Positioned(
                  right: -8,
                  top: -8,
                  child: IconButton(
                    color: Colors.red,
                    icon: Icon(
                      Icons.close,
                      color: vm.textColor,
                    ),
                    onPressed: Get.back,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
