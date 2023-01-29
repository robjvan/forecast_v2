import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/settings/settings_view_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
  static const String routeName = '/settings';
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, SettingsPageViewModel>(
      // onInit: onInit,
      converter: SettingsPageViewModel.create,
      builder: (final BuildContext context, final SettingsPageViewModel vm) {
        return Scaffold(
          body: Center(
            child: Text(vm.message),
          ),
        );
      },
    );
  }
}
