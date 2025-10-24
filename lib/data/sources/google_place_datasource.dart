import 'package:dio/dio.dart';
import 'package:metro_quest/data/models/google_place/nearby_search_response.dart';
import 'package:metro_quest/domain/entities/place_filter_category_entity.dart';

abstract class GooglePlacesDataSource {
  Future<GooglePlaceNearbySearchResponse> searchNearby({
    required double latitude,
    required double longitude,
    required PlaceCategory category,
    double radius,
    int maxResults,
    String rankPreference,
    String languageCode,
    PlaceFieldMask fieldMask,
  });
}

class GooglePlacesRemoteDataSource implements GooglePlacesDataSource {
  final Dio dio;

  GooglePlacesRemoteDataSource({required String apiKey})
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://places.googleapis.com/v1/',
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': apiKey,
          },
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

  @override
  Future<GooglePlaceNearbySearchResponse> searchNearby({
    required double latitude,
    required double longitude,
    required PlaceCategory category,
    double radius = 1000,
    int maxResults = 10,
    String rankPreference = 'POPULARITY',
    String languageCode = 'fr',
    PlaceFieldMask fieldMask = const PlaceFieldMask(),
  }) async {
    final params = categoryParams[category]!;

    final data = {
      'includedTypes': params.includedTypes,
      if (params.excludedTypes.isNotEmpty) 'excludedTypes': params.excludedTypes,
      if (params.includedPrimaryTypes.isNotEmpty) 'includedPrimaryTypes': params.includedPrimaryTypes,
      if (params.excludedPrimaryTypes.isNotEmpty) 'excludedPrimaryTypes': params.excludedPrimaryTypes,
      'maxResultCount': maxResults,
      'rankPreference': rankPreference,
      'languageCode': languageCode,
      'locationRestriction': {
        'circle': {
          'center': {'latitude': latitude, 'longitude': longitude},
          'radius': radius,
        },
      },
    };

    try {
      final response = await dio.post(
        'places:searchNearby',
        data: data,
        options: Options(
          headers: {'X-Goog-FieldMask': fieldMask.headerValue},
        ),
      );

      // TODO: Check if the data returned is okay for use case, and maybe update Place entity accordingly to needs

      final result = GooglePlaceNearbySearchResponse.fromJson(response.data ?? {});

      return result;
    } on DioException catch (e) {
      throw Exception('Google Places API error: ${e.response?.data ?? e.message}');
    }
  }
}
