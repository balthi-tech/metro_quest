import 'package:metro_quest/core/utils/csv_parser.dart';
import 'package:metro_quest/data/models/metro_line_dto.dart';

abstract class LineDataSource {
  Future<List<MetroLineDto>> fetchMetroLinesDto();
}

class LineLocalDataSource implements LineDataSource {
  final String metroLineTracesCsvPath;
  final CsvParser csvParser;

  LineLocalDataSource({
    required this.metroLineTracesCsvPath,
    required this.csvParser,
  });

  @override
  Future<List<MetroLineDto>> fetchMetroLinesDto() async {
    final row = await csvParser.loadCsvFromAsset(metroLineTracesCsvPath, ';');
    final headers = row.first;
    final List<MetroLineDto> dtos = [];

    for (int i = 1; i < row.length; i++) {
      final rowMap = csvParser.mapRowToHeader(headers, row[i]);
      dtos.add(MetroLineDto.fromCsv(rowMap));
    }

    return dtos;
  }
}
