import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_entity.dart';

class MetroCombinedState {
  final List<MetroStation> stations;
  final List<MetroLine> lines;

  MetroCombinedState({
    required this.stations,
    required this.lines,
  });
}
