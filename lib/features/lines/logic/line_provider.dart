import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/data/repositories/lines_repository_impl.dart';
import 'package:metro_quest/data/sources/lines_datasource.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/repositories/lines_repository.dart';
import 'package:metro_quest/domain/usecases/lines/get_all_lines_usecase.dart';
import 'package:metro_quest/features/lines/logic/line_controller.dart';
import 'package:metro_quest/shared/providers/csv_reader_provider.dart';

final lineControllerProvider = AsyncNotifierProvider<LineController, List<MetroLine>>(() {
  return LineController();
});

final lineDataSourceProvider = Provider<LineDataSource>((ref) {
  return LineLocalDataSource(
    tracesCsvPath: 'assets/data/traces.csv',
    csvParser: ref.read(csvParserProvider),
  );
});

final stationRepositoryProvider = Provider<LineRepository>((ref) {
  final lineDataSource = ref.read(lineDataSourceProvider);
  return LineRepositoryImpl(lineDataSource: lineDataSource);
});

final getlinesUseCaseProvider = Provider<GetLinesUseCase>((ref) {
  final repository = ref.read(stationRepositoryProvider);
  return GetLinesUseCase(repository: repository);
});
