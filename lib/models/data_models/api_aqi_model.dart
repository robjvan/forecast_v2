// ignore_for_file: non_constant_identifier_names

import 'package:forecast_v3/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class APIAQI extends Entity<APIAQI> {
  final double? co;
  final double? no2;
  final double? o3;
  final double? so2;
  final double? pm2_5;
  final double? pm10;
  final int? us_epa_index;
  final int? gb_defra_index;

  const APIAQI({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.us_epa_index,
    required this.gb_defra_index,
  });

  @override
  factory APIAQI.createEmpty() => const APIAQI(
        co: null,
        no2: null,
        o3: null,
        so2: null,
        pm2_5: null,
        pm10: null,
        us_epa_index: null,
        gb_defra_index: null,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APIAQI &&
          other.co == co &&
          other.no2 == no2 &&
          other.o3 == o3 &&
          other.so2 == so2 &&
          other.pm2_5 == pm2_5 &&
          other.pm10 == pm10 &&
          other.us_epa_index == us_epa_index &&
          other.gb_defra_index == gb_defra_index;

  @override
  int get hashCode =>
      co.hashCode ^
      no2.hashCode ^
      o3.hashCode ^
      so2.hashCode ^
      pm2_5.hashCode ^
      pm10.hashCode ^
      us_epa_index.hashCode ^
      gb_defra_index.hashCode;

  @override
  APIAQI copyWith({
    final double? co,
    final double? no2,
    final double? o3,
    final double? so2,
    final double? pm2_5,
    final double? pm10,
    final int? us_epa_index,
    final int? gb_defra_index,
  }) =>
      APIAQI(
        co: co ?? this.co,
        no2: no2 ?? this.no2,
        o3: o3 ?? this.o3,
        so2: so2 ?? this.so2,
        pm2_5: pm2_5 ?? this.pm2_5,
        pm10: pm10 ?? this.pm10,
        us_epa_index: us_epa_index ?? this.us_epa_index,
        gb_defra_index: gb_defra_index ?? this.gb_defra_index,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'co': co,
        'no2': no2,
        'o3': o3,
        'so2': so2,
        'pm2_5': pm2_5,
        'pm10': pm10,
        'us_epa_index': us_epa_index,
        'gb_defra_index': gb_defra_index
      };

  @override
  APIAQI.fromJson(final dynamic json)
      : co = Entity.parseJsonDouble(json['co']),
        no2 = Entity.parseJsonDouble(json['no2']),
        o3 = Entity.parseJsonDouble(json['o3']),
        so2 = Entity.parseJsonDouble(json['so2']),
        pm2_5 = Entity.parseJsonDouble(json['pm2_5']),
        pm10 = Entity.parseJsonDouble(json['pm10']),
        us_epa_index = Entity.parseJsonInt(json['us_epa_index']),
        gb_defra_index = Entity.parseJsonInt(json['gb_defra_index']);

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid =>
      co != null &&
      no2 != null &&
      o3 != null &&
      so2 != null &&
      pm2_5 != null &&
      pm10 != null &&
      us_epa_index != null &&
      gb_defra_index != null;
}
