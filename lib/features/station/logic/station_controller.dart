import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';
import 'package:metro_quest/shared/providers/visited_station_provider.dart';

class StationController extends AsyncNotifier<List<MetroStation>> {
  final List<MetroStation> _allStations = [];

  @override
  Future<List<MetroStation>> build() async {
    final getStationsUseCase = ref.read(getStationsUseCaseProvider);
    final stations = await getStationsUseCase.execute();

    final linesAsync = await ref.watch(lineControllerProvider.future);
    final linesMap = {for (var line in linesAsync) line.id: line};

    _allStations.clear();

    final enrichedStations = enrichStationsWithLineColors(stations, linesMap);

    _allStations.addAll(enrichedStations);

    return _applyVisitedStatus(_allStations);
  }

  List<MetroStation> enrichStationsWithLineColors(
    List<MetroStation> stations,
    Map<String, MetroLine> lineMap,
  ) {
    return stations.map((station) {
      final metroLine = lineMap[station.lineId];
      return station.copyWith(lineColor: metroLine?.color);
    }).toList();
  }

  Future<void> refreshVisited() async {
    final newData = _applyVisitedStatus(_allStations);
    if (!_listEquals(state.value, newData)) {
      state = AsyncValue.data(newData);
    }
  }

  List<MetroStation> _applyVisitedStatus(List<MetroStation> stations) {
    final visitedIds = ref.read(visitedStationServiceProvider).getVisitedStationIds();
    return stations.map((s) => s.copyWith(visited: visitedIds.contains(s.id))).toList();
  }

  bool _listEquals(List<MetroStation>? a, List<MetroStation>? b) {
    if (a == null || b == null) return false;
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id || a[i].visited != b[i].visited) {
        return false;
      }
    }
    return true;
  }

  Future<void> visitStation(String stationId, bool isVisited) async {
    if (!isVisited) {
      await ref.read(visitedStationServiceProvider).unmarkVisited(stationId);
    } else {
      await ref.read(visitedStationServiceProvider).markVisited(stationId);
    }
    await refreshVisited();
  }
}
