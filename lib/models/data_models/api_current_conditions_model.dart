// ignore_for_file: non_constant_identifier_names

import 'package:forecast_v3/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class APICurrentConditions extends Entity<APICurrentConditions> {
  final APIAQI? air_quality;
  final APICondition? condition;
  final bool? is_day;
  final String? last_updated;
  final String? wind_dir;
  final int? last_updated_epoch;
  final int? wind_degree;
  final int? pressure_mb;
  final int? humidity;
  final int? uv;
  final double? pressure_in;
  final double? temp_c;
  final double? temp_f;
  final double? temp_k;
  final double? wind_mph;
  final double? wind_kph;
  final double? wind_knots;
  final double? wind_ms;
  final double? pressure_kpa;
  final double? pressure_atm;
  final double? feelslike_c;
  final double? feelslike_f;
  final double? feelslike_k;

  const APICurrentConditions({
    required this.last_updated_epoch,
    required this.last_updated,
    required this.temp_c,
    required this.temp_f,
    required this.temp_k,
    required this.is_day,
    required this.condition,
    required this.wind_mph,
    required this.wind_kph,
    required this.wind_ms,
    required this.wind_knots,
    required this.wind_degree,
    required this.wind_dir,
    required this.pressure_mb,
    required this.pressure_in,
    required this.pressure_kpa,
    required this.pressure_atm,
    required this.humidity,
    required this.feelslike_c,
    required this.feelslike_f,
    required this.feelslike_k,
    required this.uv,
    required this.air_quality,
  });
  @override
  factory APICurrentConditions.createEmpty() => const APICurrentConditions(
        last_updated_epoch: null,
        last_updated: null,
        temp_c: null,
        temp_f: null,
        temp_k: null,
        is_day: null,
        condition: null,
        wind_mph: null,
        wind_kph: null,
        wind_ms: null,
        wind_knots: null,
        wind_degree: null,
        wind_dir: null,
        pressure_mb: null,
        pressure_in: null,
        pressure_kpa: null,
        pressure_atm: null,
        humidity: null,
        feelslike_c: null,
        feelslike_f: null,
        feelslike_k: null,
        uv: null,
        air_quality: null,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APICurrentConditions &&
          other.last_updated_epoch == last_updated_epoch &&
          other.last_updated == last_updated &&
          other.temp_c == temp_c &&
          other.temp_f == temp_f &&
          other.temp_k == temp_k &&
          other.is_day == is_day &&
          other.condition == condition &&
          other.wind_mph == wind_mph &&
          other.wind_kph == wind_kph &&
          other.wind_ms == wind_ms &&
          other.wind_knots == wind_knots &&
          other.wind_degree == wind_degree &&
          other.wind_dir == wind_dir &&
          other.pressure_mb == pressure_mb &&
          other.pressure_in == pressure_in &&
          other.pressure_kpa == pressure_kpa &&
          other.pressure_atm == pressure_atm &&
          other.humidity == humidity &&
          other.feelslike_c == feelslike_c &&
          other.feelslike_f == feelslike_f &&
          other.feelslike_k == feelslike_k &&
          other.uv == uv &&
          other.air_quality == air_quality;

  @override
  int get hashCode =>
      last_updated_epoch.hashCode ^
      last_updated.hashCode ^
      temp_c.hashCode ^
      temp_f.hashCode ^
      temp_k.hashCode ^
      is_day.hashCode ^
      condition.hashCode ^
      wind_mph.hashCode ^
      wind_kph.hashCode ^
      wind_ms.hashCode ^
      wind_knots.hashCode ^
      wind_degree.hashCode ^
      wind_dir.hashCode ^
      pressure_mb.hashCode ^
      pressure_in.hashCode ^
      pressure_kpa.hashCode ^
      pressure_atm.hashCode ^
      humidity.hashCode ^
      feelslike_c.hashCode ^
      feelslike_f.hashCode ^
      feelslike_k.hashCode ^
      uv.hashCode ^
      air_quality.hashCode;

  @override
  APICurrentConditions copyWith({
    final int? last_updated_epoch,
    final String? last_updated,
    final double? temp_c,
    final double? temp_f,
    final double? temp_k,
    final bool? is_day,
    final APICondition? condition,
    final double? wind_mph,
    final double? wind_kph,
    final double? wind_ms,
    final double? wind_knots,
    final int? wind_degree,
    final String? wind_dir,
    final int? pressure_mb,
    final double? pressure_in,
    final double? pressure_kpa,
    final double? pressure_atm,
    final int? humidity,
    final double? feelslike_c,
    final double? feelslike_f,
    final double? feelslike_k,
    final int? uv,
    final APIAQI? air_quality,
  }) =>
      APICurrentConditions(
        last_updated_epoch: last_updated_epoch ?? this.last_updated_epoch,
        last_updated: last_updated ?? this.last_updated,
        temp_c: temp_c ?? this.temp_c,
        temp_f: temp_f ?? this.temp_f,
        temp_k: temp_k ?? this.temp_k,
        is_day: is_day ?? this.is_day,
        condition: condition ?? this.condition,
        wind_mph: wind_mph ?? this.wind_mph,
        wind_kph: wind_kph ?? this.wind_kph,
        wind_knots: wind_knots ?? this.wind_knots,
        wind_ms: wind_ms ?? this.wind_ms,
        wind_degree: wind_degree ?? this.wind_degree,
        wind_dir: wind_dir ?? this.wind_dir,
        pressure_mb: pressure_mb ?? this.pressure_mb,
        pressure_in: pressure_in ?? this.pressure_in,
        pressure_kpa: pressure_kpa ?? this.pressure_kpa,
        pressure_atm: pressure_atm ?? this.pressure_atm,
        humidity: humidity ?? this.humidity,
        feelslike_c: feelslike_c ?? this.feelslike_c,
        feelslike_f: feelslike_f ?? this.feelslike_f,
        feelslike_k: feelslike_k ?? this.feelslike_k,
        uv: uv ?? this.uv,
        air_quality: air_quality ?? this.air_quality,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'last_updated_epoch': last_updated_epoch,
        'last_updated': last_updated,
        'temp_c': temp_c,
        'temp_f': temp_f,
        'temp_k': temp_k,
        'is_day': is_day,
        'condition': condition,
        'wind_mph': wind_mph,
        'wind_kph': wind_kph,
        'wind_knots': wind_kph,
        'wind_ms': wind_kph,
        'wind_degree': wind_degree,
        'wind_dir': wind_dir,
        'pressure_mb': pressure_mb,
        'pressure_in': pressure_in,
        'pressure_kpa': pressure_kpa,
        'pressure_atm': pressure_atm,
        'humidity': humidity,
        'feelslike_c': feelslike_c,
        'feelslike_f': feelslike_f,
        'feelslike_k': feelslike_k,
        'uv': uv,
        'air_quality': air_quality
      };

  @override
  APICurrentConditions.fromJson(final dynamic json)
      : last_updated_epoch = Entity.parseJsonInt(json['last_updated_epoch']),
        last_updated = json['last_updated'],
        temp_c = Entity.parseJsonDouble(json['temp_c']),
        temp_f = Entity.parseJsonDouble(json['temp_f']),
        temp_k = Entity.parseJsonDouble(json['temp_c']) + 273.15,
        is_day = Entity.parseJsonBool(json['is_day']),
        condition = APICondition.fromJson(json['condition']),
        wind_mph = Entity.parseJsonDouble(json['wind_mph']),
        wind_kph = Entity.parseJsonDouble(json['wind_kph']),
        wind_ms = Entity.parseJsonDouble(json['wind_kph']) / 3.6,
        wind_knots = Entity.parseJsonDouble(json['wind_kph']) / 1.852,
        wind_degree = Entity.parseJsonInt(json['wind_degree']),
        wind_dir = json['wind_dir'],
        pressure_mb = Entity.parseJsonInt(json['pressure_mb']),
        pressure_in = Entity.parseJsonDouble(json['pressure_in']),
        pressure_kpa = Entity.parseJsonDouble(json['pressure_mb'] / 10),
        pressure_atm = Entity.parseJsonDouble(json['pressure_in'] * 0.033),
        humidity = Entity.parseJsonInt(json['humidity']),
        feelslike_c = Entity.parseJsonDouble(json['feelslike_c']),
        feelslike_f = Entity.parseJsonDouble(json['feelslike_f']),
        feelslike_k = Entity.parseJsonDouble(json['feelslike_c'] + 273.15),
        uv = Entity.parseJsonInt(json['uv']),
        air_quality = APIAQI.fromJson(json['air_quality']);

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid =>
      last_updated_epoch != null &&
      last_updated != null &&
      temp_c != null &&
      temp_f != null &&
      temp_k != null &&
      is_day != null &&
      condition != null &&
      wind_mph != null &&
      wind_kph != null &&
      wind_ms != null &&
      wind_knots != null &&
      wind_degree != null &&
      wind_dir != null &&
      pressure_mb != null &&
      pressure_in != null &&
      pressure_kpa != null &&
      pressure_atm != null &&
      humidity != null &&
      feelslike_c != null &&
      feelslike_f != null &&
      feelslike_k != null &&
      uv != null &&
      air_quality != null;
}
