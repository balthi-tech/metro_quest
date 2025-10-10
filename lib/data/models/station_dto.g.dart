// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationDTO _$StationDTOFromJson(Map<String, dynamic> json) => StationDTO(
  routeId: json['routeId'] as String,
  routeLongName: json['routeLongName'] as String,
  stopId: json['stopId'] as String,
  stopName: json['stopName'] as String,
  stopLon: json['stopLon'] as String,
  stopLat: json['stopLat'] as String,
  operatorName: json['operatorName'] as String,
  shortName: json['shortName'] as String,
  mode: json['mode'] as String,
  pointgeo: (json['pointgeo'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  nomCommune: json['nomCommune'] as String,
  codeInsee: json['codeInsee'] as String,
);

Map<String, dynamic> _$StationDTOToJson(StationDTO instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'routeLongName': instance.routeLongName,
      'stopId': instance.stopId,
      'stopName': instance.stopName,
      'stopLon': instance.stopLon,
      'stopLat': instance.stopLat,
      'operatorName': instance.operatorName,
      'shortName': instance.shortName,
      'mode': instance.mode,
      'pointgeo': instance.pointgeo,
      'nomCommune': instance.nomCommune,
      'codeInsee': instance.codeInsee,
    };
