///
/// Copyright (C) 2018 Andrious Solutions
///
/// This program is free software; you can redistribute it and/or
/// modify it under the terms of the GNU General Public License
/// as published by the Free Software Foundation; either version 3
/// of the License, or any later version.
///
/// You may obtain a copy of the License at
///
///  http://www.apache.org/licenses/LICENSE-2.0
///
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
///          Created  05 Jun 2018
///
library prefs;

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// The App's Preferences.
class Prefs {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static SharedPreferences? _prefsInstance;

  /// In case the developer does not explicitly call the init() function.
  static bool _initCalled = false;

  /// Initialize the SharedPreferences object in the State object's iniState() function.
  static Future<SharedPreferences> init() async {
    _initCalled = true;
    _prefsInstance = await _prefs;
    return _prefs;
  }

  /// Best to clean up by calling this function in the State object's dispose() function.
  static void dispose() {
    _prefs.whenComplete(() => null);
    _prefsInstance = null;
  }

  /// Returns all keys in the persistent storage.
  static Set<String> getKeys() {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getKeysF() instead. SharedPreferences not ready yet!");
    return _prefsInstance!.getKeys();
  }

  /// Reads a value of any type from persistent storage.
  static dynamic get(String key) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance!.get(key);
  }

  static bool getBool(String key, [bool? defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getBoolF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static int getInt(String key, [int? defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getIntF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance!.getInt(key) ?? defValue ?? 0;
  }

  static double getDouble(String key, [double? defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getDoubleF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance!.getDouble(key) ?? defValue ?? 0.0;
  }

  static String getString(String key, [String? defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getStringF(key)instead. SharedPreferences not ready yet!");
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static List<String> getStringList(String key, [List<String>? defValue]) {
    assert(_initCalled,
        "Prefs.init() must be called first in an initState() preferably!");
    assert(_prefsInstance != null,
        "Maybe call Prefs.getStringListF(key) instead. SharedPreferences not ready yet!");
    return _prefsInstance?.getStringList(key) ?? defValue ?? [""];
  }

  /// Saves a boolean [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  // static Future<bool> setBool(String key, bool value) async {
  //   var instance = await _prefs;
  //   return instance?.setBool(key, value) ?? Future.value(false);
  // }
  static Future<bool> setBool(String key, bool value) async {
    var instance = await _prefs;
    return instance.setBool(key, value);
  }

  /// Saves an integer [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  // static Future<bool> setInt(String key, int value) async {
  //   var instance = await _prefs;
  //   return instance?.setInt(key, value) ?? Future.value(false);
  // }
  static Future<bool> setInt(String key, int value) async {
    var instance = await _prefs;
    return instance.setInt(key, value);
  }

  /// Saves a double [value] to persistent storage in the background.
  /// Android doesn't support storing doubles, so it will be stored as a float.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  // static Future<bool> setDouble(String key, double value) async {
  //   var instance = await _prefs;
  //   return instance?.setDouble(key, value) ?? Future.value(false);
  // }
  static Future<bool> setDouble(String key, double value) async {
    var instance = await _prefs;
    return instance.setDouble(key, value);
  }

  /// Saves a string [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  // static Future<bool> setString(String key, String value) async {
  //   var instance = await _prefs;
  //   return instance?.setString(key, value) ?? Future.value(false);
  // }
  static Future<bool> setString(String key, String value) async {
    var instance = await _prefs;
    return instance.setString(key, value);
  }

  static bool isUserLoggedIn() {
    var userId = Prefs.getString('userId');
    return !(userId == '');
  }
}
