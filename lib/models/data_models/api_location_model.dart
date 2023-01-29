// ignore_for_file: non_constant_identifier_names

import 'package:forecast_v3/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class APILocation extends Entity<APILocation> {
  final String? name;
  final String? region;
  final String? country;
  final String? tz_id;
  final String? localtime;
  final double? lat;
  final double? long;
  final int? localtime_epoch;

  const APILocation({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.long,
    required this.tz_id,
    required this.localtime_epoch,
    required this.localtime,
  });

  @override
  factory APILocation.createEmpty() => const APILocation(
        name: null,
        region: null,
        country: null,
        lat: null,
        long: null,
        tz_id: null,
        localtime_epoch: null,
        localtime: null,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APILocation &&
          other.name == name &&
          other.region == region &&
          other.country == country &&
          other.lat == lat &&
          other.long == long &&
          other.tz_id == tz_id &&
          other.localtime_epoch == localtime_epoch &&
          other.localtime == localtime;

  @override
  int get hashCode =>
      name.hashCode ^
      region.hashCode ^
      country.hashCode ^
      lat.hashCode ^
      long.hashCode ^
      tz_id.hashCode ^
      localtime_epoch.hashCode ^
      localtime.hashCode;

  @override
  APILocation copyWith({
    final String? name,
    final String? region,
    final String? country,
    final double? lat,
    final double? long,
    final String? tz_id,
    final int? localtime_epoch,
    final String? localtime,
  }) =>
      APILocation(
        name: name ?? this.name,
        region: region ?? this.region,
        country: country ?? this.country,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        tz_id: tz_id ?? this.tz_id,
        localtime_epoch: localtime_epoch ?? this.localtime_epoch,
        localtime: localtime ?? this.localtime,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'region': region,
        'country': country,
        'lat': lat,
        'lon': long,
        'tz_id': tz_id,
        'localtime_epoch': localtime_epoch,
        'localtime': localtime
      };

  @override
  APILocation.fromJson(final Map<String, dynamic> json)
      : name = json['name'],
        region = json['region'],
        country = json['country'],
        lat = Entity.parseJsonDouble(json['lat']),
        long = Entity.parseJsonDouble(json['lon']),
        tz_id = json['tz_id'],
        localtime_epoch = Entity.parseJsonInt(json['localtime_epoch']),
        localtime = json['localtime'];

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid =>
      name != null &&
      region != null &&
      country != null &&
      lat != null &&
      long != null &&
      tz_id != null &&
      localtime_epoch != null &&
      localtime != null;
}
