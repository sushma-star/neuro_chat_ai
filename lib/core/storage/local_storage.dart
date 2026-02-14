
import 'package:hive/hive.dart';

class LocalStorage {
  static const String historyBox = 'history_box';

  /// Save a new history entry
  static Future<void> saveHistory(String feature, String text) async {
    final box = await Hive.openBox(historyBox);
    final timestamp = DateTime.now().toIso8601String();
    await box.put(timestamp, {'feature': feature, 'text': text, 'time': timestamp});
  }
  static const String boxName = "historyBox";
  static Future<void> saveMessage(String text) async {
    final box = await Hive.openBox(boxName);
    box.add(text);
  }

  static Future<List<String>> getMessages() async {
    final box = await Hive.openBox(boxName);
    return box.values.cast<String>().toList();
  }
  /// Get all history entries
  static Future<List<Map<String, dynamic>>> getHistory() async {
    final box = await Hive.openBox(historyBox);
    final history = <Map<String, dynamic>>[];
    for (var key in box.keys) {
      final value = box.get(key);
      history.add(Map<String, dynamic>.from(value));
    }
    history.sort((a, b) => b['time'].compareTo(a['time'])); // newest first
    return history;
  }

  /// Clear all history
  static Future<void> clearHistory() async {
    final box = await Hive.openBox(historyBox);
    await box.clear();
  }
}
