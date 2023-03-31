export 'app_keys.dart';
export 'config.dart';
export 'icons.dart';
export 'routes.dart';
export 'theme.dart';
export 'translations.dart';
export 'validators.dart';
export 'weather_icon_parser.dart';

// double toKelvin(final double input) => input + 273.15;

extension ToKelvin on double {
  double toKelvin() => this + 273.15;
}
