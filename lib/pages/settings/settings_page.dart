import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
  static const String routeName = '/settings';
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(final BuildContext context) {
    return const Placeholder();
  }
}
