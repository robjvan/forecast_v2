import 'package:flutter/material.dart';
import 'package:forecast_v3/utilities/localization/en.dart';
import 'package:forecast_v3/utilities/localization/es.dart';
import 'package:forecast_v3/utilities/localization/fr.dart';
import 'package:get/get.dart';

@immutable
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': englishStrings,
        'fr': frenchStrings,
        'es': spanishStrings,
      };
}
