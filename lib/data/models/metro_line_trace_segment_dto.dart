import 'package:metro_quest/data/models/geo_point_dto.dart';
import 'package:metro_quest/domain/entities/metro_line_segment_entity.dart';

class MetroSegmentDto {
  final List<GeoPointDto> points;

  MetroSegmentDto(this.points);

  MetroLineSegment toDomain() {
    return MetroLineSegment(
      coordinates: points.map((point) => point.toDomain()).toList(),
      start: points.first.toDomain(),
      end: points.last.toDomain(),
    );
  }
}
