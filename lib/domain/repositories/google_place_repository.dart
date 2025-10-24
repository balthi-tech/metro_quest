import 'package:metro_quest/domain/entities/place_entity.dart';
import 'package:metro_quest/domain/entities/place_filter_category_entity.dart';

abstract class GooglePlacesRepository {
  Future<List<Place>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    required PlaceCategory category,
    double radius = 300,
  });
}
