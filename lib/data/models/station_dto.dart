import 'package:json_annotation/json_annotation.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';

part 'station_dto.g.dart';

@JsonSerializable()
class StationDTO {
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

  StationDTO({
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

  factory StationDTO.fromJson(Map<String, dynamic> json) => _$StationDTOFromJson(json);
  Map<String, dynamic> toJson() => _$StationDTOToJson(this);

  Station toDomain({
    String? funfact,
    String? histoire,
    bool visited = false,
  }) {
    return Station(
      routeId: routeId,
      routeLongName: routeLongName,
      stopId: stopId,
      stopName: stopName,
      stopLon: stopLon,
      stopLat: stopLat,
      operatorName: operatorName,
      shortName: shortName,
      mode: mode,
      pointgeo: pointgeo,
      nomCommune: nomCommune,
      codeInsee: codeInsee,
      funfact: funfact,
      histoire: histoire,
      visited: visited,
    );
  }
}
