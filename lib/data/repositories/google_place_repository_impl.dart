import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/data/sources/google_place_datasource.dart';
import 'package:metro_quest/domain/entities/place_entity.dart';
import 'package:metro_quest/domain/entities/place_filter_category_entity.dart';
import 'package:metro_quest/domain/repositories/google_place_repository.dart';

class GooglePlaceRepositoryImpl implements GooglePlacesRepository {
  final GooglePlacesDataSource _datasource;

  GooglePlaceRepositoryImpl(this._datasource);

  @override
  Future<List<Place>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    required PlaceCategory category,
    double radius = 300,
  }) async {
    try {
      final dtos = await _datasource.searchNearby(
        latitude: latitude,
        longitude: longitude,
        category: category,
        radius: radius,
        maxResults: 20,
      );

      final places = dtos.places.map((dto) => dto.toDomain()).toList();

      for (var place in places) {
        Log.d('Fetched place: ${place.toString()}');
      }

      return places;
    } catch (e) {
      Log.e(e.toString());

      return [];
    }
  }
}
