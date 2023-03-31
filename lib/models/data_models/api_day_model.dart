// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';

@immutable
class APIDay extends Entity<APIDay> {
  final double? maxtemp_c;
  final double? maxtemp_f;
  final double? mintemp_c;
  final double? mintemp_f;
  final double? avghumidity;
  final double? uv;
  final bool? daily_will_it_rain;
  final int? daily_chance_of_rain;
  final APICondition? condition;
  final APIAQI? air_quality;

  const APIDay({
    required this.maxtemp_c,
    required this.maxtemp_f,
    required this.mintemp_c,
    required this.mintemp_f,
    required this.avghumidity,
    required this.daily_will_it_rain,
    required this.daily_chance_of_rain,
    required this.condition,
    required this.uv,
    required this.air_quality,
  });

  @override
  factory APIDay.createEmpty() => const APIDay(
        maxtemp_c: null,
        maxtemp_f: null,
        mintemp_c: null,
        mintemp_f: null,
        avghumidity: null,
        daily_will_it_rain: null,
        daily_chance_of_rain: null,
        condition: null,
        uv: null,
        air_quality: null,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APIDay &&
          other.maxtemp_c == maxtemp_c &&
          other.maxtemp_f == maxtemp_f &&
          other.mintemp_c == mintemp_c &&
          other.mintemp_f == mintemp_f &&
          other.avghumidity == avghumidity &&
          other.daily_will_it_rain == daily_will_it_rain &&
          other.daily_chance_of_rain == daily_chance_of_rain &&
          other.condition == condition &&
          other.uv == uv &&
          other.air_quality == air_quality;

  @override
  int get hashCode =>
      maxtemp_c.hashCode ^
      maxtemp_f.hashCode ^
      mintemp_c.hashCode ^
      mintemp_f.hashCode ^
      avghumidity.hashCode ^
      daily_will_it_rain.hashCode ^
      daily_chance_of_rain.hashCode ^
      condition.hashCode ^
      uv.hashCode ^
      air_quality.hashCode;

  @override
  APIDay copyWith({
    final double? maxtemp_c,
    final double? maxtemp_f,
    final double? mintemp_c,
    final double? mintemp_f,
    final int? avghumidity,
    final int? daily_will_it_rain,
    final int? daily_chance_of_rain,
    final APICondition? condition,
    final int? uv,
    final APIAQI? air_quality,
  }) =>
      APIDay(
        maxtemp_c: maxtemp_c ?? this.maxtemp_c,
        maxtemp_f: maxtemp_f ?? this.maxtemp_f,
        mintemp_c: mintemp_c ?? this.mintemp_c,
        mintemp_f: mintemp_f ?? this.mintemp_f,
        avghumidity: avghumidity as double? ?? this.avghumidity,
        daily_will_it_rain:
            daily_will_it_rain as bool? ?? this.daily_will_it_rain,
        daily_chance_of_rain: daily_chance_of_rain ?? this.daily_chance_of_rain,
        condition: condition ?? this.condition,
        uv: uv as double? ?? this.uv,
        air_quality: air_quality ?? this.air_quality,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'maxtemp_c': maxtemp_c,
        'maxtemp_f': maxtemp_f,
        'mintemp_c': mintemp_c,
        'mintemp_f': mintemp_f,
        'avghumidity': avghumidity,
        'daily_will_it_rain': daily_will_it_rain,
        'daily_chance_of_rain': daily_chance_of_rain,
        'condition': condition,
        'uv': uv,
        'air_quality': air_quality
      };

  @override
  APIDay.fromJson(final dynamic json)
      : maxtemp_c = Entity.parseJsonDouble(json['maxtemp_c']),
        maxtemp_f = Entity.parseJsonDouble(json['maxtemp_f']),
        mintemp_c = Entity.parseJsonDouble(json['mintemp_c']),
        mintemp_f = Entity.parseJsonDouble(json['mintemp_f']),
        avghumidity = Entity.parseJsonDouble(json['avghumidity']),
        daily_will_it_rain = Entity.parseJsonBool(json['daily_will_it_rain']),
        daily_chance_of_rain =
            Entity.parseJsonInt(json['daily_chance_of_rain']),
        condition = APICondition.fromJson(json['condition']),
        uv = Entity.parseJsonDouble(json['uv']),
        air_quality = APIAQI.fromJson(json['air_quality']);

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid =>
      maxtemp_c != null &&
      maxtemp_f != null &&
      mintemp_c != null &&
      mintemp_f != null &&
      avghumidity != null &&
      daily_will_it_rain != null &&
      daily_chance_of_rain != null &&
      condition != null &&
      uv != null &&
      air_quality != null;
}
