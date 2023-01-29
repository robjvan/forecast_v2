// ignore_for_file: non_constant_identifier_names

import 'package:forecast_v3/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class APIForecastDay extends Entity<APIForecastDay> {
  final String? date;
  final int? date_epoch;
  final APIDay? day;
  final APIAstro? astro;
  final List<APIHour>? hour;

  const APIForecastDay({
    required this.date,
    required this.date_epoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  @override
  factory APIForecastDay.createEmpty() => const APIForecastDay(
        date: null,
        date_epoch: null,
        day: null,
        astro: null,
        hour: null,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APIForecastDay &&
          other.date == date &&
          other.date_epoch == date_epoch &&
          other.day == day &&
          other.astro == astro &&
          other.hour == hour;

  @override
  int get hashCode =>
      date.hashCode ^
      date_epoch.hashCode ^
      day.hashCode ^
      astro.hashCode ^
      hour.hashCode;

  @override
  APIForecastDay copyWith({
    final String? date,
    final int? date_epoch,
    final APIDay? day,
    final APIAstro? astro,
    final List<APIHour>? hour,
  }) =>
      APIForecastDay(
        date: date ?? this.date,
        date_epoch: date_epoch ?? this.date_epoch,
        day: day ?? this.day,
        astro: astro ?? this.astro,
        hour: hour ?? this.hour,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date,
        'date_epoch': date_epoch,
        'day': day,
        'astro': astro,
        'hour': hour
      };

  @override
  APIForecastDay.fromJson(final dynamic json)
      : date = json['date'],
        date_epoch = Entity.parseJsonInt(json['date_epoch']),
        day = APIDay.fromJson(json['day']),
        astro = APIAstro.fromJson(json['astro']),
        hour = (json['hour'] as List<dynamic>)
            .map((final dynamic i) => APIHour.fromJson(i))
            .toList();

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid =>
      date != null &&
      date_epoch != null &&
      day != null &&
      astro != null &&
      hour != null;
}
