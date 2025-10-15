import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/features/metro_map/logic/metro_map_controller.dart';

final metroMapControllerProvider = AsyncNotifierProvider.family<MetroMapController, MetroMapState, List<Station>>(
  (List<Station> stations) => MetroMapController(stations),
);
