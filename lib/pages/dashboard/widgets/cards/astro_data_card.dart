import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast/models/models.dart';
import 'package:forecast/pages/dashboard/widgets/cards/astro_data_view_model.dart';
import 'package:forecast/utilities/theme.dart';
import 'package:get/get.dart';

@immutable
class AstroDataCard extends StatelessWidget {
  const AstroDataCard({super.key});

  Widget buildContent(final AstroDataViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'sunrise'.tr,
              style:
                  AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            ),
            Text(
              vm.sunriseString,
              style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
            ),
            const SizedBox(height: 8.0),
            Text(
              'sunset'.tr,
              style:
                  AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            ),
            Text(
              vm.sunsetString,
              style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'moonphase'.tr,
              style:
                  AppStyles.dataCardHeaderStyle.copyWith(color: vm.textColor),
            ),
            Text(
              vm.moonPhaseString.tr,
              style: AppStyles.dataCardDataStyle.copyWith(color: vm.textColor),
            ),
            const SizedBox(height: 16.0),
            vm.moonPhaseIcon,
          ],
        ),
      ],
    );
  }

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, AstroDataViewModel>(
      distinct: true,
      converter: AstroDataViewModel.create,
      builder: (final _, final AstroDataViewModel vm) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: vm.cardColor.withOpacity(0.5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: buildContent(vm),
          ),
        );
      },
    );
  }
}
