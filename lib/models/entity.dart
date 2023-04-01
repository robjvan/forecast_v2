import 'package:flutter/material.dart';

@immutable
abstract class Entity<T> {
  const Entity();
  Entity<T> copyWith();
  bool get isValid;
  bool get isNotValid;
  const Entity.fromJson(final Map<String, dynamic> json);
  Map<String, dynamic> toJson();
  const Entity.createEmpty();

  static bool parseJsonBool(final dynamic value) {
    if (value is bool) return value;
    if (value is num) return value == 1;
    if (value is String) return value.toLowerCase() == 'true';
    return false;
  }

  static DateTime parseJsonDate(final dynamic value) {
    if (value is DateTime) return value;
    if (value is num) return DateTime.fromMillisecondsSinceEpoch(value as int);
    if (value is String) return DateTime.parse(value);
    return DateTime.now();
  }

  static num parseJsonNum(final dynamic value) {
    if (value is num) return value;
    if (value is String) return num.parse(value);
    if (value is bool) return value ? 1 : 0;
    return -1;
  }

  static double parseJsonDouble(final dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.parse(value);
    if (value is bool) return value ? 1.0 : 0.0;
    return -1;
  }

  static int parseJsonInt(final dynamic value) {
    if (value is num) return value.toInt();
    if (value is String) return int.parse(value);
    if (value is bool) return value ? 1 : 0;
    return -1;
  }

  static String asString(final dynamic value) => value.toString();
}
