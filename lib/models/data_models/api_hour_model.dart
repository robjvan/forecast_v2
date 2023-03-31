// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';

@immutable
class APIHour extends Entity<APIHour> {
  final String? time;
  final String? wind_dir;
  final APICondition? condition;
  final double? temp_c;
  final double? temp_f;
  final double? wind_mph;
  final double? wind_kph;
  final double? pressure_mb;
  final double? pressure_in;
  final double? feelslike_c;
  final double? feelslike_f;
  final bool? will_it_rain;
  final bool? will_it_snow;
  final int? wind_degree;
  final int? time_epoch;
  final int? humidity;
  final int? cloud;
  final int? chance_of_rain;
  final int? uv;
  final APIAQI? air_quality;

  const APIHour({
    required this.time_epoch,
    required this.time,
    required this.temp_c,
    required this.temp_f,
    required this.condition,
    required this.wind_mph,
    required this.wind_kph,
    required this.wind_degree,
    required this.wind_dir,
    required this.pressure_mb,
    required this.pressure_in,
    required this.humidity,
    required this.cloud,
    required this.feelslike_c,
    required this.feelslike_f,
    required this.will_it_rain,
    required this.chance_of_rain,
    required this.will_it_snow,
    required this.uv,
    required this.air_quality,
  });

  @override
  factory APIHour.createEmpty() => const APIHour(
        time_epoch: null,
        time: null,
        temp_c: null,
        temp_f: null,
        condition: null,
        wind_mph: null,
        wind_kph: null,
        wind_degree: null,
        wind_dir: null,
        pressure_mb: null,
        pressure_in: null,
        humidity: null,
        cloud: null,
        feelslike_c: null,
        feelslike_f: null,
        will_it_rain: null,
        chance_of_rain: null,
        will_it_snow: null,
        uv: null,
        air_quality: null,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APIHour &&
          other.time_epoch == time_epoch &&
          other.time == time &&
          other.temp_c == temp_c &&
          other.temp_f == temp_f &&
          other.condition == condition &&
          other.wind_mph == wind_mph &&
          other.wind_kph == wind_kph &&
          other.wind_degree == wind_degree &&
          other.wind_dir == wind_dir &&
          other.pressure_mb == pressure_mb &&
          other.pressure_in == pressure_in &&
          other.humidity == humidity &&
          other.cloud == cloud &&
          other.feelslike_c == feelslike_c &&
          other.feelslike_f == feelslike_f &&
          other.will_it_rain == will_it_rain &&
          other.chance_of_rain == chance_of_rain &&
          other.will_it_snow == will_it_snow &&
          other.uv == uv &&
          other.air_quality == air_quality;

  @override
  int get hashCode =>
      time_epoch.hashCode ^
      time.hashCode ^
      temp_c.hashCode ^
      temp_f.hashCode ^
      condition.hashCode ^
      wind_mph.hashCode ^
      wind_kph.hashCode ^
      wind_degree.hashCode ^
      wind_dir.hashCode ^
      pressure_mb.hashCode ^
      pressure_in.hashCode ^
      humidity.hashCode ^
      cloud.hashCode ^
      feelslike_c.hashCode ^
      feelslike_f.hashCode ^
      will_it_rain.hashCode ^
      chance_of_rain.hashCode ^
      will_it_snow.hashCode ^
      uv.hashCode ^
      air_quality.hashCode;

  @override
  APIHour copyWith({
    final int? time_epoch,
    final String? time,
    final double? temp_c,
    final double? temp_f,
    final APICondition? condition,
    final double? wind_mph,
    final double? wind_kph,
    final int? wind_degree,
    final String? wind_dir,
    final int? pressure_mb,
    final double? pressure_in,
    final int? humidity,
    final int? cloud,
    final double? feelslike_c,
    final double? feelslike_f,
    final bool? will_it_rain,
    final int? chance_of_rain,
    final bool? will_it_snow,
    final int? uv,
    final APIAQI? air_quality,
  }) =>
      APIHour(
        time_epoch: time_epoch ?? this.time_epoch,
        time: time ?? this.time,
        temp_c: temp_c ?? this.temp_c,
        temp_f: temp_f ?? this.temp_f,
        condition: condition ?? this.condition,
        wind_mph: wind_mph ?? this.wind_mph,
        wind_kph: wind_kph ?? this.wind_kph,
        wind_degree: wind_degree ?? this.wind_degree,
        wind_dir: wind_dir ?? this.wind_dir,
        pressure_mb: pressure_mb as double? ?? this.pressure_mb,
        pressure_in: pressure_in ?? this.pressure_in,
        humidity: humidity ?? this.humidity,
        cloud: cloud ?? this.cloud,
        feelslike_c: feelslike_c ?? this.feelslike_c,
        feelslike_f: feelslike_f ?? this.feelslike_f,
        will_it_rain: will_it_rain ?? this.will_it_rain,
        chance_of_rain: chance_of_rain ?? this.chance_of_rain,
        will_it_snow: will_it_snow ?? this.will_it_snow,
        uv: uv ?? this.uv,
        air_quality: air_quality ?? this.air_quality,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'time_epoch': time_epoch,
        'time': time,
        'temp_c': temp_c,
        'temp_f': temp_f,
        'condition': condition,
        'wind_mph': wind_mph,
        'wind_kph': wind_kph,
        'wind_degree': wind_degree,
        'wind_dir': wind_dir,
        'pressure_mb': pressure_mb,
        'pressure_in': pressure_in,
        'humidity': humidity,
        'cloud': cloud,
        'feelslike_c': feelslike_c,
        'feelslike_f': feelslike_f,
        'will_it_rain': will_it_rain,
        'chance_of_rain': chance_of_rain,
        'will_it_snow': will_it_snow,
        'uv': uv,
        'air_quality': air_quality
      };

  @override
  APIHour.fromJson(final dynamic json)
      : time_epoch = Entity.parseJsonInt(json['time_epoch']),
        time = json['time'],
        temp_c = Entity.parseJsonDouble(json['temp_c']),
        temp_f = Entity.parseJsonDouble(json['temp_f']),
        condition = APICondition.fromJson(json['condition']),
        wind_mph = Entity.parseJsonDouble(json['wind_mph']),
        wind_kph = Entity.parseJsonDouble(json['wind_kph']),
        wind_degree = Entity.parseJsonInt(json['wind_degree']),
        wind_dir = json['wind_dir'],
        pressure_mb = Entity.parseJsonDouble(json['pressure_mb']),
        pressure_in = Entity.parseJsonDouble(json['pressure_in']),
        humidity = Entity.parseJsonInt(json['humidity']),
        cloud = Entity.parseJsonInt(json['cloud']),
        feelslike_c = Entity.parseJsonDouble(json['feelslike_c']),
        feelslike_f = Entity.parseJsonDouble(json['feelslike_f']),
        will_it_rain = Entity.parseJsonBool(json['will_it_rain']),
        chance_of_rain = Entity.parseJsonInt(json['chance_of_rain']),
        will_it_snow = Entity.parseJsonBool(json['will_it_snow']),
        uv = Entity.parseJsonInt(json['uv']),
        air_quality = APIAQI.fromJson(json['air_quality']);

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid =>
      time_epoch != null &&
      time != null &&
      temp_c != null &&
      temp_f != null &&
      condition != null &&
      wind_mph != null &&
      wind_kph != null &&
      wind_degree != null &&
      wind_dir != null &&
      pressure_mb != null &&
      pressure_in != null &&
      humidity != null &&
      cloud != null &&
      feelslike_c != null &&
      feelslike_f != null &&
      will_it_rain != null &&
      chance_of_rain != null &&
      will_it_snow != null &&
      uv != null &&
      air_quality != null;
}
