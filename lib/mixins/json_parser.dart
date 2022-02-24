mixin JsonParser {
  static DateTime? millisecondsToDate(data) {
    if (data == null) return null;

    final millisecondsTimes = toIntOrZero(data);

    if (millisecondsTimes == 0) return null;

    return DateTime.fromMillisecondsSinceEpoch(millisecondsTimes);
  }

  static bool toBool(bool? value) {
    return value ?? false;
  }

  static int toIntOrDefault(data, int defaultValue) {
    if (data == null) return defaultValue;

    return int.tryParse(data.toString()) ?? defaultValue;
  }

  static int toIntOrZero(data) {
    return toIntOrDefault(data, 0);
  }

  static Map<String, dynamic> toMaporEmpty(data) {
    return data ?? {};
  }

  static List toListorEmpty(data) {
    return data ?? [];
  }

  static double toDoubleOrDefault(data, double defaultValue) {
    if (data == null) return defaultValue;

    return double.tryParse(data.toString()) ?? defaultValue;
  }

  static double toDoubleOrZero(data) {
    return toDoubleOrDefault(data, 0.0);
  }

  static String toStringorEmpty(data) {
    return data ?? "";
  }

  static List<String> toStringList(List<dynamic> data) {
    final _data = data;

    return _data.map((item) => item.toString()).toList();
  }

  static List<int> toIntList(List<dynamic> data) {
    final _data = data;
    return _data.map((item) => (toIntOrZero(item))).toList();
  }

  static List<int> toDoubleList(List<dynamic> data) {
    final _data = data;
    return _data.map((item) => (toIntOrZero(item))).toList();
  }

  static dynamic toEnumOrNull(data, List<dynamic> enumValues) {
    if (data == null) return null;

    return enumValues[data];
  }

  static int toEpoch(Map data, String key) {
    final value = data[key];
    if (value == null) {
      return 0;
    }

    if (value is String) {
      return DateTime.parse(value).millisecondsSinceEpoch;
    }

    return value;
  }
}
