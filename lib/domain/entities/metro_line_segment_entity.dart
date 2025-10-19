import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class MetroLineSegment {
  final List<GeoPoint> coordinates;
  final GeoPoint start;
  final GeoPoint end;

  const MetroLineSegment({
    required this.coordinates,
    required this.start,
    required this.end,
  });
}
