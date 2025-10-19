import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/data/repositories/lines_repository_impl.dart';
import 'package:metro_quest/data/sources/lines_datasource.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_line_filter_criteria.dart';
import 'package:metro_quest/domain/entities/metro_line_sort_criteria.dart';
import 'package:metro_quest/domain/entities/metro_station_filter_criteria.dart';
import 'package:metro_quest/domain/entities/metro_station_sort_criteria.dart';
import 'package:metro_quest/domain/repositories/lines_repository.dart';
import 'package:metro_quest/domain/usecases/lines/get_all_lines_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/filtered_lines_usecase.dart';
import 'package:metro_quest/domain/usecases/stations/sort_lines_usecase.dart';
import 'package:metro_quest/features/lines/logic/line_controller.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/providers/csv_reader_provider.dart';

// Provider combiné pour le filtrage et le tri des lignes
final filteredSortedLinesProvider = FutureProvider.family<List<MetroLine>, MetroLineFilterCriterias?>((
  ref,
  criteria,
) async {
  final lines = await ref.watch(lineControllerProvider.future);
  final filterUseCase = ref.watch(filterLinesUseCaseProvider);
  final sortUseCase = ref.watch(sortLinesUseCaseProvider);

  // 1. filtre d'abord
  final filtered = filterUseCase.execute(metroLines: lines, criteria: criteria);

  // 2. Check si sort by distance is required

  final bool sortByDistanceNeeded =
      criteria?.sortBy == MetroLineSortCriteria.distanceAsc || criteria?.sortBy == MetroLineSortCriteria.distanceDesc;

  MetroStationSortCriteria? sortCriteria = criteria?.sortBy == MetroLineSortCriteria.distanceAsc
      ? MetroStationSortCriteria.distanceAsc
      : criteria?.sortBy == MetroLineSortCriteria.distanceDesc
      ? MetroStationSortCriteria.distanceDesc
      : null;

  if (sortByDistanceNeeded) {
    // Récupère les stations triées par distance
    final sortedStations = await ref.watch(
      filteredSortedStationsProvider(
        MetroStationFilterCriterias(sortBy: sortCriteria),
      ).future,
    );

    // 3. tri selon le critère avec les stations triées par distance
    final sorted = sortUseCase.execute(
      metroLines: filtered,
      sortedStationsByDistance: sortedStations,
      criteria: criteria?.sortBy,
    );

    return sorted;
  }

  // 3. tri selon le critère avec les stations triées par distance
  final sorted = sortUseCase.execute(
    metroLines: filtered,
    criteria: criteria?.sortBy,
  );

  return sorted;
});

// Provider pour le controller des lignes
final lineControllerProvider = AsyncNotifierProvider<LineController, List<MetroLine>>(() {
  return LineController();
});

// Provider pour la DataSource locale des lignes
final lineDataSourceProvider = Provider<LineDataSource>((ref) {
  return LineLocalDataSource(
    csvParser: ref.read(csvParserProvider),
    metroLineTracesCsvPath: 'assets/data/metro/paris/metro_lines_data.csv',
  );
});

// Provider pour le repository des lignes
final stationRepositoryProvider = Provider<LineRepository>((ref) {
  final lineDataSource = ref.read(lineDataSourceProvider);
  return LineRepositoryImpl(lineDataSource: lineDataSource);
});

// Provider pour le use case de récupération de toutes les lignes
final getlinesUseCaseProvider = Provider<GetLinesUseCase>((ref) {
  final repository = ref.read(stationRepositoryProvider);
  return GetLinesUseCase(repository: repository);
});

final filterLinesUseCaseProvider = Provider<FilteredLinesUseCase>((ref) {
  return FilteredLinesUseCase();
});

final sortLinesUseCaseProvider = Provider<SortedLinesUseCase>((ref) {
  return SortedLinesUseCase();
});
