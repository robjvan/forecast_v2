import 'package:flutter/material.dart';
import 'package:forecast/utilities/localization/en.dart';
import 'package:forecast/utilities/localization/es.dart';
import 'package:forecast/utilities/localization/fr.dart';
import 'package:get/get.dart';

@immutable
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
        'en': englishStrings,
        'fr': frenchStrings,
        'es': spanishStrings,
      };
}
