import 'package:flutter/material.dart';

@immutable
class HourlyData {
  final int hour;
  final int temp;

  const HourlyData({required this.hour, required this.temp});
}
