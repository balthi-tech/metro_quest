import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class GeoPointDto {
  final double latitude;
  final double longitude;

  GeoPointDto({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'GeoPointDto(latitude: $latitude, longitude: $longitude)';
  }

  GeoPoint toDomain() {
    return GeoPoint(latitude: latitude, longitude: longitude);
  }
}
