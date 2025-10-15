import 'package:metro_quest/core/utils/csv_parser.dart';
import 'package:metro_quest/data/models/station_dto.dart';
import 'package:metro_quest/domain/entities/fact_entity.dart';

abstract class StationDataSource {
  Future<List<StationDTO>> fetchStationDTOs();
  Future<Map<String, Fact>> fetchFunFacts();
  Future<Map<String, Fact>> fetchHistoryFacts();
}

class StationLocalDataSource implements StationDataSource {
  final String metroStationsCsvPath;
  final String funFactsCsvPath;
  final String historyFactsCsvPath;
  final CsvParser csvParser;

  StationLocalDataSource({
    required this.metroStationsCsvPath,
    required this.funFactsCsvPath,
    required this.historyFactsCsvPath,
    required this.csvParser,
  });

  @override
  Future<List<StationDTO>> fetchStationDTOs() async {
    final rows = await csvParser.loadCsvFromAsset(metroStationsCsvPath, ';');
    final headers = rows.first;
    final List<StationDTO> dtos = [];

    for (int i = 1; i < rows.length; i++) {
      final rowMap = csvParser.mapRowToHeader(headers, rows[i]);
      dtos.add(StationDTO.fromCsv(rowMap));
    }

    final uniqueDtos = <String, StationDTO>{};
    for (var dto in dtos) {
      final key = '${dto.stopName}-${dto.routeLongName}';
      if (!uniqueDtos.containsKey(key)) {
        uniqueDtos[key] = dto;
      }
    }
    return uniqueDtos.values.toList();
  }

  @override
  Future<Map<String, Fact>> fetchFunFacts() async {
    final rows = await csvParser.loadCsvFromAsset(funFactsCsvPath, ';', eol: '\n');
    final headers = rows.first;

    int columnIndex(String name) => csvParser.findColumnIndex(headers, name);

    String getValue(List<dynamic> row, String name) => row[columnIndex(name)].toString();

    final Map<String, Fact> funFactsMap = {};

    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      final stopId = getValue(row, 'stop_id');
      final funFactContent = getValue(row, 'funfact');
      final funFactSource = getValue(row, 'funfactSource');

      Fact funFact = Fact(content: funFactContent, source: funFactSource);

      if (stopId.isNotEmpty && funFact.content.isNotEmpty && funFact.source.isNotEmpty) {
        funFactsMap[stopId] = funFact;
      }
    }

    return funFactsMap;
  }

  @override
  Future<Map<String, Fact>> fetchHistoryFacts() async {
    final rows = await csvParser.loadCsvFromAsset(historyFactsCsvPath, ';', eol: '\n');
    final headers = rows.first;

    int columnIndex(String name) => csvParser.findColumnIndex(headers, name);

    String getValue(List<dynamic> row, String name) => row[columnIndex(name)].toString();

    final Map<String, Fact> historyFactsMap = {};

    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      final stopId = getValue(row, 'stop_id');
      final historyFactContent = getValue(row, 'historyfact');
      final historyFactSource = getValue(row, 'historyfactSource');

      Fact historyFact = Fact(content: historyFactContent, source: historyFactSource);

      if (stopId.isNotEmpty && historyFact.content.isNotEmpty && historyFact.source.isNotEmpty) {
        historyFactsMap[stopId] = historyFact;
      }
    }

    return historyFactsMap;
  }
}
