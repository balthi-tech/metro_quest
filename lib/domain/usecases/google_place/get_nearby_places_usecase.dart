import 'package:metro_quest/domain/entities/place_entity.dart';
import 'package:metro_quest/domain/entities/place_filter_category_entity.dart';
import 'package:metro_quest/domain/repositories/google_place_repository.dart';

class GetNearbyPlacesUseCase {
  final GooglePlacesRepository repository;

  GetNearbyPlacesUseCase(this.repository);

  Future<List<Place>> execute({
    required double latitude,
    required double longitude,
    required PlaceCategory category,
    double radius = 300,
  }) {
    return repository.getNearbyPlaces(
      latitude: latitude,
      longitude: longitude,
      radius: radius,
      category: category,
    );
  }
}
