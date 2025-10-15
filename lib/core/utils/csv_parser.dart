import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvParser {
  Future<List<List<dynamic>>> loadCsvFromAsset(String assetPath, String fieldDelimiter, {String? eol}) async {
    final csvString = await rootBundle.loadString(assetPath);
    final rows = const CsvToListConverter().convert(csvString, fieldDelimiter: fieldDelimiter, eol: eol);
    return rows;
  }

  int findColumnIndex(List<dynamic> headerRow, String columnName) {
    final index = headerRow.indexWhere((element) => element.toString() == columnName);
    if (index == -1) {
      throw Exception('Column "$columnName" not found in CSV header.');
    }
    return index;
  }

  // Transforme une ligne de données en Map<String,String> selon l'en-tête
  Map<String, String> mapRowToHeader(List<dynamic> headerRow, List<dynamic> dataRow) {
    final headers = headerRow.map((e) => e.toString()).toList();
    final values = dataRow.map((e) => e.toString()).toList();
    return Map.fromIterables(headers, values);
  }
}
