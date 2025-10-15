import 'package:metro_quest/core/utils/csv_parser.dart';
import 'package:metro_quest/data/models/trace_dto.dart';

abstract class LineDataSource {
  Future<List<TraceDto>> fetchTracesDto();
}

class LineLocalDataSource implements LineDataSource {
  final String tracesCsvPath;
  final CsvParser csvParser;

  LineLocalDataSource({
    required this.tracesCsvPath,
    required this.csvParser,
  });

  @override
  Future<List<TraceDto>> fetchTracesDto() async {
    final rows = await csvParser.loadCsvFromAsset(tracesCsvPath, ';');
    final headers = rows.first;
    final List<TraceDto> dtos = [];

    for (int i = 1; i < rows.length; i++) {
      final rowMap = csvParser.mapRowToHeader(headers, rows[i]);
      dtos.add(TraceDto.fromCsv(rowMap));
    }

    print('Fetched ${dtos.length} traces from CSV.');
    return dtos;
  }

  // @override
  // Future<List<TraceDto>> fetchTracesDto() async {
  //   final rows = await csvParser.loadCsvFromAsset('assets/data/traces.csv', ';');
  //   final headers = rows.first;

  //   int columnIndex(String name) => csvParser.findColumnIndex(headers, name);

  //   String getValue(List<dynamic> row, String name) => row[columnIndex(name)].toString();

  //   List<TraceDto> dtos = [];

  //   for (int i = 1; i < rows.length; i++) {
  //     final row = rows[i];

  //     dtos.add(
  //       TraceDto(
  //         geoPoint: getValue(row, 'geo_point_2d'),
  //         geoShape: GeoShapeDto.fromString(getValue(row, 'geo_shape')),
  //         idrefliga: getValue(row, 'idrefliga'),
  //         idrefligc: getValue(row, 'idrefligc'),
  //         indiceLig: getValue(row, 'indice_lig'),
  //         resCom: getValue(row, 'res_com'),
  //         reseau: getValue(row, 'reseau'),
  //         mode: getValue(row, 'mode'),
  //         train: int.tryParse(getValue(row, 'train')),
  //         rer: int.tryParse(getValue(row, 'rer')),
  //         metro: int.tryParse(getValue(row, 'metro')),
  //         tramway: int.tryParse(getValue(row, 'tramway')),
  //         val: int.tryParse(getValue(row, 'val')),
  //         idf: int.tryParse(getValue(row, 'idf')),
  //         extcode: getValue(row, 'extcode'),
  //         shapeLeng: double.tryParse(getValue(row, 'shape_leng')),
  //         colourWebHexa: getValue(row, 'colourweb_hexa'),
  //         colourPrintCmjn: getValue(row, 'colourprint_cmjn'),
  //         pictoFinal: getValue(row, 'picto_final').isNotEmpty ? getValue(row, 'picto_final') : null,
  //         exploitant: getValue(row, 'exploitant'),
  //         dateMes: DateTime.tryParse(getValue(row, 'date_mes')),
  //       ),
  //     );
  //   }

  //   print('Fetched ${dtos.length} traces from CSV.');

  //   return dtos;
  // }
}
