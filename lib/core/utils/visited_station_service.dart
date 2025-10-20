import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';
import 'package:metro_quest/core/constants/hive_boxes.dart';

class VisitedStationService {
  late Box<String> _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(HiveBoxes.visitedStationsBox)) {
      if (kDebugMode) {
        print('Opening visited stations box');
      }
      await Hive.openBox<String>(HiveBoxes.visitedStationsBox);
    }

    _box = Hive.box(HiveBoxes.visitedStationsBox);
  }

  Future<void> markVisited(String stationId) async {
    await _box.put(stationId, stationId);
  }

  Future<void> unmarkVisited(String stationId) async {
    await _box.delete(stationId);
  }

  Set<String> getVisitedStationIds() {
    return _box.values.toSet();
  }

  bool isVisited(String stationId) {
    return _box.containsKey(stationId);
  }
}
