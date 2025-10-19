import 'dart:convert';

import 'package:metro_quest/data/models/geo_point_dto.dart';
import 'package:metro_quest/data/models/metro_line_trace_segment_dto.dart';
import 'package:metro_quest/domain/entities/metro_line_trace_entity.dart';

// describes a trace of a metro line as a series of geographical points

class MetroLineTraceDto {
  final String type;
  final List<MetroSegmentDto> segments;

  MetroLineTraceDto({required this.type, required this.segments});

  factory MetroLineTraceDto.fromJson(Map<String, dynamic> json) {
    return MetroLineTraceDto(
      type: json['type'] as String,
      segments: (json['coordinates'] as List<dynamic>).map((segment) {
        return MetroSegmentDto(
          (segment as List<dynamic>).map((point) {
            final list = point as List<dynamic>;
            // GeoJSON standard : [longitude, latitude]
            return GeoPointDto(
              latitude: (list[1] as num).toDouble(),
              longitude: (list[0] as num).toDouble(),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  factory MetroLineTraceDto.fromString(String str) {
    final Map<String, dynamic> json = str.isNotEmpty
        ? jsonDecode(str) as Map<String, dynamic>
        : {'coordinates': [], 'type': ''};
    return MetroLineTraceDto.fromJson(json);
  }

  // factory MetroLineTraceDto.fromString(String str) {
  //   print('Parsing MetroLineTraceDto from string: $str');

  //   try {
  //     final Map<String, dynamic> json = jsonDecode(str) as Map<String, dynamic>;
  //     return MetroLineTraceDto.fromJson(json);
  //   } catch (_) {
  //     // Tentative de parsing simplifiée si str est une coordonnée simple
  //     final parts = str.split(',').map((e) => e.trim()).toList();
  //     if (parts.length == 2) {
  //       final lon = double.tryParse(parts[0]);
  //       final lat = double.tryParse(parts[1]);
  //       if (lon != null && lat != null) {
  //         return MetroLineTraceDto(
  //           type: 'MultiLineString',
  //           segments: [
  //             MetroSegmentDto([
  //               GeoPointDto(latitude: lat, longitude: lon),
  //             ]),
  //           ],
  //         );
  //       }
  //     }
  //     rethrow; // autrement re-lance l’erreur
  //   }
  // }

  MetroLineTrace toDomain(String lineId) {
    return MetroLineTrace(
      lineId: lineId,
      segments: segments.map((segmentDto) => segmentDto.toDomain()).toList(),
    );
  }

  @override
  String toString() => 'MetroLineTraceDto(type: $type, segments: $segments)';
}
