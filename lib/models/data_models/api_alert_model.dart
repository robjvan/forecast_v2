import 'package:forecast_v3/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class APIAlert extends Entity<APIAlert> {
  final String? headline;
  final String? msgtype;
  final String? severity;
  final String? urgency;
  final String? areas;
  final String? category;
  final String? certainty;
  final String? event;
  final String? note;
  final String? effective;
  final String? expires;
  final String? desc;
  final String? instruction;

  const APIAlert({
    required this.headline,
    required this.msgtype,
    required this.severity,
    required this.urgency,
    required this.areas,
    required this.category,
    required this.certainty,
    required this.event,
    required this.note,
    required this.effective,
    required this.expires,
    required this.desc,
    required this.instruction,
  });

  @override
  factory APIAlert.createEmpty() => const APIAlert(
        areas: null,
        category: null,
        certainty: null,
        desc: null,
        effective: null,
        expires: null,
        event: null,
        headline: null,
        instruction: null,
        msgtype: null,
        note: null,
        severity: null,
        urgency: null,
      );

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APIAlert &&
          other.areas == areas &&
          other.category == category &&
          other.certainty == certainty &&
          other.desc == desc &&
          other.effective == effective &&
          other.expires == expires &&
          other.event == event &&
          other.headline == headline &&
          other.msgtype == msgtype &&
          other.note == note &&
          other.severity == severity &&
          other.urgency == urgency &&
          other.instruction == instruction;

  @override
  int get hashCode =>
      areas.hashCode ^
      category.hashCode ^
      certainty.hashCode ^
      desc.hashCode ^
      effective.hashCode ^
      expires.hashCode ^
      event.hashCode ^
      headline.hashCode ^
      msgtype.hashCode ^
      note.hashCode ^
      severity.hashCode ^
      urgency.hashCode ^
      instruction.hashCode;

  @override
  APIAlert copyWith({
    final String? headline,
    final String? msgtype,
    final String? severity,
    final String? urgency,
    final String? areas,
    final String? category,
    final String? certainty,
    final String? event,
    final String? note,
    final String? effective,
    final String? expires,
    final String? desc,
    final String? instruction,
  }) =>
      APIAlert(
        headline: headline ?? this.headline,
        msgtype: msgtype ?? this.msgtype,
        severity: severity ?? this.severity,
        urgency: urgency ?? this.urgency,
        areas: areas ?? this.areas,
        category: category ?? this.category,
        certainty: certainty ?? this.certainty,
        event: event ?? this.event,
        note: note ?? this.note,
        effective: effective ?? this.effective,
        expires: expires ?? this.expires,
        desc: desc ?? this.desc,
        instruction: instruction ?? this.instruction,
      );

  @override
  APIAlert.fromJson(final Map<String, dynamic> json)
      : headline = json['headline'],
        msgtype = json['msgtype'],
        severity = json['severity'],
        urgency = json['urgency'],
        areas = json['areas'],
        category = json['category'],
        certainty = json['certainty'],
        event = json['event'],
        note = json['note'],
        effective = json['effective'],
        expires = json['expires'],
        desc = json['desc'],
        instruction = json['instruction'];

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'headline': headline,
        'msgtype': msgtype,
        'severity': severity,
        'urgency': urgency,
        'areas': areas,
        'category': category,
        'certainty': certainty,
        'event': event,
        'note': note,
        'effective': effective,
        'expires': expires,
        'desc': desc,
        'instruction': instruction
      };

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid =>
      headline != null &&
      msgtype != null &&
      severity != null &&
      urgency != null &&
      areas != null &&
      category != null &&
      certainty != null &&
      event != null &&
      note != null &&
      effective != null &&
      expires != null &&
      desc != null &&
      instruction != null;
}
