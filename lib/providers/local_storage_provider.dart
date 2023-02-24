import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:forecast_v3/models/models.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageProvider {
  /// Write user settings to local storage
  static Future<bool> writeSettingsData(final UserSettings userSettings) async {
    bool saveSuccesful = false;
    const String filename = 'user_settings';
    final File file = File(
      '${(await getApplicationDocumentsDirectory()).path}/$filename.json',
    );

    /// TODO(Rob): Add backup file of old settings

    /// Read data from storage and store it in [savedFile]
    final File savedFile = await file.writeAsString(
      json.encode(userSettings.toJson()),
    );

    /// Check the length of [savedFile].
    /// If it is over 0 bytes, save was successful.
    //! If the save failed but the old data was not cleared, this would give a false positive
    // TODO(Rob): Add check for successful save
    if (savedFile.lengthSync() > 0) {
      saveSuccesful = true;
    }

    // Return bool result of save operation where true = successful
    return saveSuccesful;
  }

  /// Read saved user settings from local storage
  static Future<Map<String, dynamic>> readSettingsData() async {
    Map<String, dynamic> result = {};
    const String filename = 'user_settings';
    final File file = File(
      '${(await getApplicationDocumentsDirectory()).path}/$filename.json',
    );

    if (file.existsSync()) {
      final Map<String, dynamic> readResult =
          json.decode(await file.readAsString());
      if (readResult.isNotEmpty) {
        result = readResult;
      }
    }

    return result;
  }

  /// Save list of user locations to local storage
  static Future<bool> writeLocationsData(
    final List<Location> userLocations,
  ) async {
    bool saveSuccesful = false;
    const String filename = 'user_locations';
    final File file = File(
      '${(await getApplicationDocumentsDirectory()).path}/$filename.json',
    );

    final File savedFile = await file.writeAsString(json.encode(userLocations));

    if (savedFile.lengthSync() > 0) {
      saveSuccesful = true;
    }

    return saveSuccesful;
  }

  /// Read list of saved user locations from local storage
  static Future<List<dynamic>> readLocationsData() async {
    List<dynamic> result = [];
    const String filename = 'user_locations';
    final File file = File(
      '${(await getApplicationDocumentsDirectory()).path}/$filename.json',
    );
    List<dynamic> readResult = [];

    if (file.existsSync()) {
      try {
        readResult = json.decode(await file.readAsString());
      } on Exception catch (_) {}
      if (readResult.isNotEmpty) {
        result = readResult;
      }
    }

    return result;
  }
}
