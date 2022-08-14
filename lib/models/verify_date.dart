String? verify_date(Map map, String key) {
  if (map[key] != null && (map[key] as String).isNotEmpty) {
    return map[key];
  }
  return null;
}