import 'package:metro_quest/core/utils/csv_parser.dart';
import 'package:metro_quest/data/models/station_dto.dart';

abstract class StationDataSource {
  Future<List<StationDTO>> fetchStationDTOs();
}

class StationLocalDataSource implements StationDataSource {
  final String csvAssetPath;
  final CsvParser csvParser;

  StationLocalDataSource({
    required this.csvAssetPath,
    required this.csvParser,
  });

  @override
  Future<List<StationDTO>> fetchStationDTOs() async {
    final rows = await csvParser.loadCsvFromAsset(csvAssetPath, ';');
    final headers = rows.first;

    int columnIndex(String name) => csvParser.findColumnIndex(headers, name);

    String getValue(List<dynamic> row, String name) => row[columnIndex(name)].toString();

    List<StationDTO> dtos = [];

    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];

      dtos.add(
        StationDTO(
          routeId: getValue(row, 'id'),
          routeLongName: getValue(row, 'route_long_name'),
          stopId: getValue(row, 'stop_id'),
          stopName: getValue(row, 'stop_name'),
          stopLon: getValue(row, 'stop_lon'),
          stopLat: getValue(row, 'stop_lat'),
          operatorName: getValue(row, 'operatorname'),
          shortName: getValue(row, 'shortname'),
          mode: getValue(row, 'mode'),
          nomCommune: getValue(row, 'nom_commune'),
          codeInsee: getValue(row, 'code_insee'),
          pointgeo: row[columnIndex('pointgeo')] != null
              ? (row[columnIndex('pointgeo')] as String).split(',').map((e) => double.tryParse(e) ?? 0.0).toList()
              : null,
        ),
      );
    }

    return dtos;
  }
}
