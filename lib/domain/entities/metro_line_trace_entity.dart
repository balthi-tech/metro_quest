import 'package:metro_quest/domain/entities/metro_line_segment_entity.dart';

class MetroLineTrace {
  final String lineId;
  final List<MetroLineSegment> segments;

  const MetroLineTrace({
    required this.lineId,
    required this.segments,
  });
}
