import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/data/repositories/stations_repository_impl.dart';
import 'package:metro_quest/data/sources/stations_datasource.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/repositories/stations_repository.dart';
import 'package:metro_quest/domain/usecases/stations/filtered_stations_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/get_all_stations_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/get_stations_with_distance_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/select_random_station_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/sort_stations_usecase.dart';
import 'package:metro_quest/features/station/logic/station_controller.dart';

import 'package:metro_quest/shared/providers/csv_reader_provider.dart';
import 'package:metro_quest/shared/providers/location_service_provider.dart';

// Provider combiné pour le filtrage et le tri des stations
final filteredSortedStationsProvider = FutureProvider.family<List<MetroStation>, MetroStationFilterCriterias?>((
  ref,
  criteria,
) async {
  final stations = await ref.watch(stationControllerProvider.future);
  final filterUseCase = ref.watch(filterStationsUseCaseProvider);
  final sortUseCase = ref.watch(sortStationsUseCaseProvider);
  final getStationsWithDistanceUseCase = ref.watch(getStationsWithDistanceUseCaseProvider);

  // 1. filtre d'abord
  final filtered = filterUseCase.execute(metroStations: stations, criteria: criteria);

  // 2. calcule la distance pour chaque station filtrée

  final asyncPosition = ref.watch(userPositionProvider);

  final userPosition = asyncPosition.when(
    data: (position) => position,
    loading: () => null,
    error: (_, _) => null,
  );

  final stationsToSort = userPosition == null
      ? filtered
      : await getStationsWithDistanceUseCase.execute(stations: filtered, currentPosition: userPosition);

  // 3. tri selon le critère
  final sorted = sortUseCase.execute(
    metroStations: stationsToSort,
    criteria: criteria?.sortBy,
    userLocation: userPosition,
  );

  return sorted;
});

// Provider pour le controller
final stationControllerProvider = AsyncNotifierProvider<StationController, List<MetroStation>>(
  () => StationController(),
);

// Provider pour la DataSource locale
final stationDataSourceProvider = Provider<StationDataSource>((ref) {
  return StationLocalDataSource(
    metroStationsCsvPath: 'assets/data/metro_station.csv',
    funFactsCsvPath: 'assets/data/metro_station_fun_fact.csv',
    historyFactsCsvPath: 'assets/data/metro_station_history_fact.csv',
    csvParser: ref.read(csvParserProvider),
  );
});

// Provider pour le repository (implémentation)
final stationRepositoryProvider = Provider<StationRepository>((ref) {
  final stationDataSource = ref.read(stationDataSourceProvider);
  return StationRepositoryImpl(stationDataSource: stationDataSource);
});

// Provider UseCase
final getStationsUseCaseProvider = Provider<GetStationsUseCase>((ref) {
  final repository = ref.read(stationRepositoryProvider);
  return GetStationsUseCase(repository: repository);
});

final filterStationsUseCaseProvider = Provider<FilteredStationsUseCase>((ref) {
  return FilteredStationsUseCase();
});

final sortStationsUseCaseProvider = Provider<SortedStationsUseCase>((ref) {
  return SortedStationsUseCase();
});

final getStationsWithDistanceUseCaseProvider = Provider<GetStationsWithDistanceUseCase>((ref) {
  return GetStationsWithDistanceUseCase();
});

// Random provider
final randomProvider = Provider<Random>((ref) {
  return Random();
});

// SelectRandomStationUseCase
final selectRandomStationUseCaseProvider = Provider<SelectRandomStationUseCase>((ref) {
  return SelectRandomStationUseCase(random: ref.read(randomProvider));
});
