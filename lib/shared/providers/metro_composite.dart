import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/utils/combined_async_value.dart';
import 'package:metro_quest/domain/entities/metro_combined_state.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';

final metroCombinedProvider = Provider<AsyncValue<MetroCombinedState>>((ref) {
  final stationsAsync = ref.watch(stationControllerProvider);
  final linesAsync = ref.watch(lineControllerProvider);

  return combineAsyncValues(
    stationsAsync,
    linesAsync,
    (stations, lines) => MetroCombinedState(stations: stations, lines: lines),
  );
});
