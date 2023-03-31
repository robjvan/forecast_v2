import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

class WeatherIconParser {
  static WeatherType? weatherType(final int code, final bool isDay) {
    switch (code) {
      case 1000:
      case 1003:
        return isDay ? WeatherType.sunny : WeatherType.sunnyNight;
      case 1006:
        return isDay ? WeatherType.cloudy : WeatherType.cloudyNight;
      case 1009:
        return WeatherType.overcast;
      case 1030:
      case 1063:
      case 1150:
      case 1153:
      case 1180:
      case 1183:
      case 1198:
      case 1240:
      case 1249:
      case 1273:
        return WeatherType.lightRainy;
      case 1168:
      case 1186:
      case 1189:
      case 1243:
      case 1252:
        return WeatherType.middleRainy;
      case 1171:
      case 1192:
      case 1195:
      case 1201:
      case 1246:
        return WeatherType.heavyRainy;
      case 1066:
      case 1069:
      case 1072:
      case 1204:
      case 1210:
      case 1213:
      case 1237:
      case 1255:
      case 1261:
        return WeatherType.lightSnow;
      case 1114:
      case 1207:
      case 1216:
      case 1219:
      case 1258:
      case 1264:
        return WeatherType.middleSnow;
      case 1117:
      case 1222:
      case 1225:
        return WeatherType.heavySnow;
      case 1135:
      case 1147:
        return WeatherType.foggy;
      case 1087:
      case 1276:
      case 1279:
      case 1282:
        return WeatherType.thunder;
    }
    return null;
  }
  
  // static IconData? weatherIcon(final int code, final bool isDay) {
  //   switch (code) {
  //     case 1000:
  //     case 1003:
  //       return isDay ? WeatherIcons.day_sunny : WeatherIcons.night_clear;
  //     case 1006:
  //       return isDay ? WeatherIcons.day_cloudy : WeatherIcons.night_cloudy;
  //     case 1009:
  //       return isDay
  //           ? WeatherIcons.day_sunny_overcast
  //           : WeatherIcons.night_partly_cloudy;
  //     case 1030:
  //     case 1063:
  //     case 1150:
  //     case 1153:
  //     case 1180:
  //     case 1183:
  //     case 1198:
  //     case 1240:
  //     case 1249:
  //     case 1273:
  //       return isDay
  //           ? WeatherIcons.day_sprinkle
  //           : WeatherIcons.night_alt_sprinkle;
  //     case 1168:
  //     case 1186:
  //     case 1189:
  //     case 1243:
  //     case 1252:
  //       return isDay ? WeatherIcons.day_showers : WeatherIcons.night_showers;
  //     case 1171:
  //     case 1192:
  //     case 1195:
  //     case 1201:
  //     case 1246:
  //       return isDay ? WeatherIcons.day_rain : WeatherIcons.night_rain;
  //     case 1066:
  //     case 1069:
  //     case 1072:
  //     case 1204:
  //     case 1210:
  //     case 1213:
  //     case 1237:
  //     case 1255:
  //     case 1261:
  //       return isDay ? WeatherIcons.day_snow : WeatherIcons.night_snow;
  //     case 1114:
  //     case 1207:
  //     case 1216:
  //     case 1219:
  //     case 1258:
  //     case 1264:
  //       return isDay ? WeatherIcons.day_snow : WeatherIcons.night_snow;
  //     case 1117:
  //     case 1222:
  //     case 1225:
  //       return isDay ? WeatherIcons.day_snow : WeatherIcons.night_snow;
  //     case 1135:
  //     case 1147:
  //       return isDay ? WeatherIcons.day_fog : WeatherIcons.night_fog;
  //     case 1087:
  //     case 1276:
  //     case 1279:
  //     case 1282:
  //       return isDay
  //           ? WeatherIcons.day_thunderstorm
  //           : WeatherIcons.night_thunderstorm;
  //   }
  //   return null;
  // }
}
