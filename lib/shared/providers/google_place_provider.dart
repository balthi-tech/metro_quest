import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/data/repositories/google_place_repository_impl.dart';
import 'package:metro_quest/data/sources/google_place_datasource.dart';
import 'package:metro_quest/domain/repositories/google_place_repository.dart';
import 'package:metro_quest/domain/usecases/google_place/get_nearby_places_usecase.dart';

// Provider pour la DataSource distante des lieux Google Places
final placeDataSource = Provider<GooglePlacesDataSource>((ref) {
  final apiKey =
      dotenv.env['GOOGLE_PLACES_API_KEY'] ?? (throw Exception('GOOGLE_PLACES_API_KEY is not set in .env file'));

  Log.d("Google Places API Key: ${apiKey.length} characters");
  return GooglePlacesRemoteDataSource(apiKey: apiKey);
});

// Provider pour le repository des lieux Google Places
final placeRepositoryProvider = Provider<GooglePlacesRepository>((ref) {
  final dataSource = ref.read(placeDataSource);
  return GooglePlaceRepositoryImpl(dataSource);
});

// Provider pour le use case de récupération des lieux à proximité
final getNearbyPlacesUseCaseProvider = Provider<GetNearbyPlacesUseCase>((ref) {
  final repository = ref.read(placeRepositoryProvider);
  return GetNearbyPlacesUseCase(repository);
});
