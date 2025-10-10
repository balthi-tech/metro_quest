import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/utils/csv_parser.dart';
import 'package:metro_quest/data/repositories/station_repository_impl.dart';
import 'package:metro_quest/data/sources/station_datasource.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/repositories/station_repository.dart';
import 'package:metro_quest/domain/usecases/get_all_stations_usecase.dart';
import 'package:metro_quest/features/station/logic/station_controller.dart';

final stationControllerProvider = AsyncNotifierProvider<StationController, List<Station>>(
  () => StationController(
    GetStationsUseCase(
      repository: StationRepositoryImpl(
        dataSource: StationLocalDataSource(
          csvAssetPath: 'assets/data/metro_station.csv',
          csvParser: CsvParser(),
        ),
      ),
    ),
  ),
);

final csvParserProvider = Provider<CsvParser>((ref) => CsvParser());

// Provider pour la DataSource locale
final stationDataSourceProvider = Provider<StationDataSource>((ref) {
  return StationLocalDataSource(
    csvAssetPath: 'assets/data/metro_station.csv',
    csvParser: ref.read(csvParserProvider),
  );
});

// Provider pour le repository (implémentation)
final stationRepositoryProvider = Provider<StationRepository>((ref) {
  final dataSource = ref.read(stationDataSourceProvider);
  return StationRepositoryImpl(dataSource: dataSource);
});

// Provider UseCase
final getStationsUseCaseProvider = Provider<GetStationsUseCase>((ref) {
  final repository = ref.read(stationRepositoryProvider);
  return GetStationsUseCase(repository: repository);
});
