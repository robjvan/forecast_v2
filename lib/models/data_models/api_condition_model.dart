import 'package:forecast_v3/models/models.dart';
import 'package:flutter/material.dart';

@immutable
class APICondition extends Entity<APICondition> {
  final String? text;
  final String? icon;
  final int? code;

  const APICondition({
    required this.text,
    required this.icon,
    required this.code,
  });

  @override
  factory APICondition.createEmpty() =>
      const APICondition(text: null, icon: null, code: null);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is APICondition &&
          other.text == text &&
          other.icon == icon &&
          other.code == code;

  @override
  int get hashCode => text.hashCode ^ icon.hashCode ^ code.hashCode;

  @override
  APICondition copyWith({
    final String? text,
    final String? icon,
    final int? code,
  }) =>
      APICondition(
        text: text ?? this.text,
        icon: icon ?? this.icon,
        code: code ?? this.code,
      );

  @override
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'text': text, 'icon': icon, 'code': code};

  @override
  APICondition.fromJson(final dynamic json)
      : text = json['text'],
        icon = json['icon'],
        code = Entity.parseJsonInt(json['code']);

  @override
  bool get isNotValid => !isValid;

  @override
  bool get isValid => text != null && icon != null && code != null;
}
