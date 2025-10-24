import 'package:metro_quest/data/models/google_place/google_place_dto.dart';

class GooglePlaceNearbySearchResponse {
  final List<GooglePlaceDto> places;

  GooglePlaceNearbySearchResponse({required this.places});

  factory GooglePlaceNearbySearchResponse.fromJson(Map<String, dynamic> json) {
    return GooglePlaceNearbySearchResponse(
      places: (json['places'] as List<dynamic>?)?.map((e) => GooglePlaceDto.fromJson(e)).toList() ?? [],
    );
  }
}
