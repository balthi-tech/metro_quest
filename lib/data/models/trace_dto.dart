import 'dart:convert';

import 'package:metro_quest/core/utils/parser.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class GeoShapeDto {
  final List<GeoPoint> coordinates;
  final String type;

  GeoShapeDto({required this.coordinates, required this.type});

  factory GeoShapeDto.fromJson(Map<String, dynamic> json) {
    return GeoShapeDto(
      coordinates: (json['coordinates'] as List<dynamic>).map((coord) {
        // GeoJSON standard: [longitude, latitude]
        var list = coord as List<dynamic>;
        return GeoPoint(longitude: list[0] as double, latitude: list[1] as double);
      }).toList(),
      type: json['type'] as String,
    );
  }

  factory GeoShapeDto.fromString(String str) {
    final Map<String, dynamic> json = str.isNotEmpty
        ? jsonDecode(str) as Map<String, dynamic>
        : {'coordinates': [], 'type': ''};
    return GeoShapeDto.fromJson(json);
  }

  @override
  String toString() => 'GeoShapeDto(coordinates: $coordinates, type: $type)';
}

class TraceDto {
  final String geoPoint;
  final GeoShapeDto geoShape;
  final String idrefliga;
  final String idrefligc;
  final String indiceLig;
  final String resCom;
  final String reseau;
  final String mode;
  final int? train;
  final int? rer;
  final int? metro;
  final int? tramway;
  final int? val;
  final int? idf;
  final String extcode;
  final double? shapeLeng;
  final String colourWebHexa;
  final String colourPrintCmjn;
  final String? pictoFinal;
  final String exploitant;
  final DateTime? dateMes;

  TraceDto({
    required this.geoPoint,
    required this.geoShape,
    required this.idrefliga,
    required this.idrefligc,
    required this.indiceLig,
    required this.resCom,
    required this.reseau,
    required this.mode,
    this.train,
    this.rer,
    this.metro,
    this.tramway,
    this.val,
    this.idf,
    required this.extcode,
    this.shapeLeng,
    required this.colourWebHexa,
    required this.colourPrintCmjn,
    this.pictoFinal,
    required this.exploitant,
    this.dateMes,
  });

  factory TraceDto.fromCsv(Map<String, String> csvRow) {
    return TraceDto(
      geoPoint: csvRow['geo_point_2d'] ?? '',
      geoShape: GeoShapeDto.fromString(csvRow['geo_shape'] ?? ''),
      idrefliga: csvRow['idrefliga'] ?? '',
      idrefligc: csvRow['idrefligc'] ?? '',
      indiceLig: csvRow['indice_lig'] ?? '',
      resCom: csvRow['res_com'] ?? '',
      reseau: csvRow['reseau'] ?? '',
      mode: csvRow['mode'] ?? '',
      train: Parsers.parseInt(csvRow['train']),
      rer: Parsers.parseInt(csvRow['rer']),
      metro: Parsers.parseInt(csvRow['metro']),
      tramway: Parsers.parseInt(csvRow['tramway']),
      val: Parsers.parseInt(csvRow['val']),
      idf: Parsers.parseInt(csvRow['idf']),
      extcode: csvRow['extcode'] ?? '',
      shapeLeng: Parsers.parseDouble(csvRow['shape_leng']),
      colourWebHexa: csvRow['colourweb_hexa'] ?? '',
      colourPrintCmjn: csvRow['colourprint_cmjn'] ?? '',
      pictoFinal: (csvRow['picto_final'] != null && csvRow['picto_final']!.isNotEmpty) ? csvRow['picto_final'] : null,
      exploitant: csvRow['exploitant'] ?? '',
      dateMes: Parsers.parseDate(csvRow['date_mes']),
    );
  }

  @override
  String toString() {
    return 'TraceDto(geoPoint: $geoPoint, geoShape: $geoShape, idrefliga: $idrefliga, idrefligc: $idrefligc, indiceLig: $indiceLig, resCom: $resCom, reseau: $reseau, mode: $mode, train: $train, rer: $rer, metro: $metro, tramway: $tramway, val: $val, idf: $idf, extcode: $extcode, shapeLeng: $shapeLeng, colourWebHexa: $colourWebHexa, colourPrintCmjn: $colourPrintCmjn, pictoFinal: $pictoFinal, exploitant: $exploitant, dateMes: $dateMes)';
  }
}
