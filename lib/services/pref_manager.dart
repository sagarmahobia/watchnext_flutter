import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class CacheManger {
  static const String _prefix = "cache_";
  static const String _expires = "_expires";
  static const String _keys = "keys";

  final SharedPreferences prefs;

  CacheManger(this.prefs);

  void cacheResponse(String key, String value, expires) {
    key = _prefix + key;
    prefs.setString(key, value);
    prefs.setString(key + _expires, expires.toString());

    addKey(key);
  }

  Future<String?> getCacheOrRemoveIfExpired(String key) async {
    key = _prefix + key;
    var containsKey = prefs.containsKey(key);
    if (!containsKey) {
      return null;
    }
    bool expired = DateTime.parse(prefs.getString(key + _expires)!)
        .isBefore(DateTime.now());

    if (expired) {
      await prefs.remove(key);
      await prefs.remove(key + _expires);
      await removeKey(key);
      return null;
    }

    return prefs.getString(key);
  }

  Future<void> clearCache() async {
    var keys = prefs.getStringList(_keys) ?? [];
    for (var key in keys) {
      await prefs.remove(key);
      await prefs.remove(key + _expires);
    }
    await prefs.remove(_keys);
  }

  Future<void> clearExpiredCache() async {
    var keys = prefs.getStringList(_keys) ?? [];
    for (var key in keys) {
      //check contains key

      var containsKey = prefs.containsKey(key + _expires);

      bool expired = containsKey
          ? DateTime.parse(prefs.getString(key + _expires)!)
              .isBefore(DateTime.now())
          : true;
      if (expired) {
        await prefs.remove(key);
        await prefs.remove(key + _expires);
      }
    }
  }

  void addKey(String key) {
    var keys = prefs.getStringList(_keys) ?? [];
    keys.add(key);
    prefs.setStringList(_keys, keys);
  }

  Future<void> removeKey(String key) async {
    var keys = prefs.getStringList(_keys) ?? [];
    await keys.remove(key);
    prefs.setStringList(_keys, keys);
  }

  //print all keys
  void printKeys() {
    var keys = prefs.getStringList(_keys) ?? [];

    if (kDebugMode) {
      print("keys: $keys");
    }
  }
}
