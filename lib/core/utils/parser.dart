class Parsers {
  static double? parseDouble(String? val) => val == null || val.isEmpty ? null : double.tryParse(val);
  static int? parseInt(String? val) => val == null || val.isEmpty ? null : int.tryParse(val);
  static DateTime? parseDate(String? val) => val == null || val.isEmpty ? null : DateTime.tryParse(val);
}
