import 'dart:math';

import 'package:metro_quest/domain/entities/geo_point_entity.dart';

class DistanceCalculator {
  static double calculateDistance(GeoPoint point1, GeoPoint point2) {
    const earthRadius = 6371; // en km
    final dLat = _deg2rad(point2.latitude - point1.latitude);
    final dLon = _deg2rad(point2.longitude - point1.longitude);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(point1.latitude)) * cos(_deg2rad(point2.latitude)) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static double _deg2rad(double deg) => deg * (pi / 180);
}
