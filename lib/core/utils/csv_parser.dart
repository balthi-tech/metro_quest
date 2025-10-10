import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvParser {
  Future<List<List<dynamic>>> loadCsvFromAsset(String assetPath, String fieldDelimiter) async {
    final csvString = await rootBundle.loadString(assetPath);
    final rows = const CsvToListConverter().convert(csvString, fieldDelimiter: fieldDelimiter);
    return rows;
  }

  int findColumnIndex(List<dynamic> headerRow, String columnName) {
    final index = headerRow.indexWhere((element) => element.toString() == columnName);

    if (index == -1) {
      throw Exception('Column "$columnName" not found in CSV header.');
    }
    return index;
  }
}
