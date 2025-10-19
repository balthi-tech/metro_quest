import 'package:flutter/material.dart';
import 'package:metro_quest/domain/entities/metro_line_trace_entity.dart';

class MetroLine {
  final String id;
  final String name;
  final Color color;
  final MetroLineTrace lineTrace;
  final double? distanceFromUser;

  MetroLine({
    required this.id,
    required this.name,
    required this.color,
    required this.lineTrace,
    this.distanceFromUser,
  });

  @override
  String toString() {
    return 'MetroLine(id: $id, name: $name, color: $color, lineTrace: $lineTrace, distanceFromUser: $distanceFromUser)';
  }

  MetroLine copyWith({double? distanceFromUser}) {
    return MetroLine(
      id: id,
      name: name,
      color: color,
      lineTrace: lineTrace,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }
}
