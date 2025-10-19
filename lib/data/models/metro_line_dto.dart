import 'package:flutter/material.dart';
import 'package:metro_quest/data/models/metro_line_trace_dto.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';

class MetroLineDto {
  final String routeId;
  final String routeShortName;
  final String routeLongName;
  final String routeType;
  final String routeColor;
  final String routeUrl;
  final MetroLineTraceDto shape;
  final String idIlico;
  final String operatorName;
  final String networkName;
  final String url;
  final String longNameFirst;
  final String geoPoint2d;

  MetroLineDto({
    required this.routeId,
    required this.routeShortName,
    required this.routeLongName,
    required this.routeType,
    required this.routeColor,
    required this.routeUrl,
    required this.shape,
    required this.idIlico,
    required this.operatorName,
    required this.networkName,
    required this.url,
    required this.longNameFirst,
    required this.geoPoint2d,
  });

  factory MetroLineDto.fromCsv(Map<String, String> csvRow) {
    return MetroLineDto(
      routeId: csvRow['route_id'] ?? '',
      routeShortName: csvRow['route_short_name'] ?? '',
      routeLongName: csvRow['route_long_name'] ?? '',
      routeType: csvRow['route_type'] ?? '',
      routeColor: csvRow['route_color'] ?? '',
      routeUrl: csvRow['route_url'] ?? '',
      shape: MetroLineTraceDto.fromString(csvRow['shape'] ?? ''),
      idIlico: csvRow['id_ilico'] ?? '',
      operatorName: csvRow['operatorname'] ?? '',
      networkName: csvRow['networkname'] ?? '',
      url: csvRow['url'] ?? '',
      longNameFirst: csvRow['long_name_first'] ?? '',
      geoPoint2d: csvRow['geo_point_2d'] ?? '',
    );
  }

  MetroLine toDomain() {
    return MetroLine(
      id: routeId,
      name: routeLongName,
      color: Color(int.parse('0xFF$routeColor')),
      lineTrace: shape.toDomain(routeId),
    );
  }

  @override
  String toString() {
    return 'MetroLineDto(routeId: $routeId, routeShortName: $routeShortName, routeLongName: $routeLongName, routeType: $routeType, routeColor: $routeColor, routeUrl: $routeUrl, shape: $shape, idIlico: $idIlico, operatorName: $operatorName, networkName: $networkName, url: $url, longNameFirst: $longNameFirst, geoPoint2d: $geoPoint2d)';
  }
}
