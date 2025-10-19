import 'package:metro_quest/domain/entities/fact_entity.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';

class MetroStationDto {
  final String routeId;
  final String routeLongName;
  final String stopId;
  final String stopName;
  final String stopLon;
  final String stopLat;
  final String operatorName;
  final String shortName;
  final String mode;
  final List<double>? pointgeo;
  final String nomCommune;
  final String codeInsee;

  MetroStationDto({
    required this.routeId,
    required this.routeLongName,
    required this.stopId,
    required this.stopName,
    required this.stopLon,
    required this.stopLat,
    required this.operatorName,
    required this.shortName,
    required this.mode,
    this.pointgeo,
    required this.nomCommune,
    required this.codeInsee,
  });

  @override
  String toString() {
    return 'MetroStationDto(routeId: $routeId, routeLongName: $routeLongName, stopId: $stopId, stopName: $stopName, stopLon: $stopLon, stopLat: $stopLat, operatorName: $operatorName, shortName: $shortName, mode: $mode, pointgeo: $pointgeo, nomCommune: $nomCommune, codeInsee: $codeInsee)';
  }

  factory MetroStationDto.fromCsv(Map<String, String> csvRow) {
    List<double>? parsePointGeo(String? val) {
      if (val == null || val.isEmpty) return null;
      return val.split(',').map((e) => double.tryParse(e) ?? 0.0).toList();
    }

    return MetroStationDto(
      routeId: csvRow['id'] ?? '',
      routeLongName: csvRow['route_long_name'] ?? '',
      stopId: csvRow['stop_id'] ?? '',
      stopName: csvRow['stop_name'] ?? '',
      stopLon: csvRow['stop_lon'] ?? '',
      stopLat: csvRow['stop_lat'] ?? '',
      operatorName: csvRow['operatorname'] ?? '',
      shortName: csvRow['shortname'] ?? '',
      mode: csvRow['mode'] ?? '',
      nomCommune: csvRow['nom_commune'] ?? '',
      codeInsee: csvRow['code_insee'] ?? '',
      pointgeo: parsePointGeo(csvRow['pointgeo']),
    );
  }

  MetroStation toDomain({
    Fact? funfact,
    Fact? historyFact,
  }) {
    if (pointgeo == null || pointgeo!.length != 2) {
      throw Exception('GeoPoint is required and must have exactly 2 coordinates');
    }

    return MetroStation(
      id: stopId,
      name: stopName,
      lineId: routeId,
      lineName: routeLongName,
      city: nomCommune,
      geoPoint: GeoPoint(latitude: pointgeo![0], longitude: pointgeo![1]),
      funFact: funfact,
      historyFact: historyFact,
    );
  }
}
