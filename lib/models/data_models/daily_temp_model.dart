import 'package:flutter/material.dart';

@immutable
class DailyTemp {
  final String day;
  final int temp;

  const DailyTemp({required this.day, required this.temp});
}
