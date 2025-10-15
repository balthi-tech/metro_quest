import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/data/repositories/stations_repository_impl.dart';
import 'package:metro_quest/data/sources/stations_datasource.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/repositories/stations_repository.dart';
import 'package:metro_quest/domain/usecases/stations/get_all_stations_usecase.dart';
import 'package:metro_quest/features/station/logic/station_controller.dart';
import 'package:metro_quest/shared/providers/csv_reader_provider.dart';

final stationControllerProvider = AsyncNotifierProvider<StationController, List<Station>>(() {
  return StationController();
});

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
