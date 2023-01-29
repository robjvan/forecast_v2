import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final Function onInit;
  const DashboardPage({required this.onInit, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
  static const String routeName = '/dashboard';
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(final BuildContext context) {
    return const Placeholder();
  }
}
