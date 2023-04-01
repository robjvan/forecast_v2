// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:forecast/models/models.dart';

@immutable
class APIAstro extends Entity<APIAstro> {
  final String? sunrise;
  final String? sunset;
  final String? moon_phase;

  const APIAstro({
    required this.sunrise,
    required this.sunset,
    required this.moon_phase,
  });

  @override
  factory APIAstro.createEmpty() =>
      const APIAstro(sunrise: null, sunset: null, moon_phase: null);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APIAstro &&
          other.sunrise == sunrise &&
          other.sunset == sunset &&
          other.moon_phase == moon_phase;

  @override
  int get hashCode => sunrise.hashCode ^ sunset.hashCode ^ moon_phase.hashCode;

  @override
  APIAstro copyWith({
    final String? sunrise,
    final String? sunset,
    final String? moon_phase,
  }) =>
      APIAstro(
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
        moon_phase: moon_phase ?? this.moon_phase,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'sunrise': sunrise,
        'sunset': sunset,
        'moon_phase': moon_phase
      };

  @override
  APIAstro.fromJson(final dynamic json)
      : sunrise = json['sunrise'],
        sunset = json['sunset'],
        moon_phase = json['moon_phase'];

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid => sunrise != null && sunset != null && moon_phase != null;
}
