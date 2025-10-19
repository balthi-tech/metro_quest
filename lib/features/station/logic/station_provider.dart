import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/data/repositories/stations_repository_impl.dart';
import 'package:metro_quest/data/sources/stations_datasource.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/repositories/stations_repository.dart';
import 'package:metro_quest/domain/usecases/stations/filtered_stations_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/get_all_stations_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/get_stations_with_distance_usecase.dart';
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
  final locationService = ref.watch(locationServiceProvider);

  final userPosition = await locationService.getCurrentPosition();

  // 1. filtre d'abord
  final filtered = filterUseCase.execute(metroStations: stations, criteria: criteria);

  // 2. calcule la distance pour chaque station filtrée

  final withDistance = await getStationsWithDistanceUseCase.execute(filtered);

  // 3. tri selon le critère
  final sorted = sortUseCase.execute(
    metroStations: withDistance,
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
  final locationService = ref.read(locationServiceProvider);
  return GetStationsWithDistanceUseCase(locationService);
});
