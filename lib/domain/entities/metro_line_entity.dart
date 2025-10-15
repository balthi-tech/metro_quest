import 'package:flutter/material.dart';
// import 'package:metro_quest/data/models/trace_dto.dart';
import 'package:metro_quest/domain/entities/metro_line_trace_entity.dart';

class MetroLine {
  final String id;
  final String name;
  final Color color;
  final List<String> stationsIds;
  // final List<GeoShapeDto> traces;
  final MetroLineTrace lineTrace;

  MetroLine({
    required this.id,
    required this.name,
    required this.color,
    required this.stationsIds,
    // required this.traces,
    required this.lineTrace,
  });
}
