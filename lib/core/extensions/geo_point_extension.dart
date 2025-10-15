import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:metro_quest/domain/entities/geo_point_entity.dart';

extension GeoPointMapping on GeoPoint {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension LatLngMapping on LatLng {
  GeoPoint toGeoPoint() => GeoPoint(latitude: latitude, longitude: longitude);
}
