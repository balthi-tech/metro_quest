import 'package:flutter/cupertino.dart';
import 'package:metro_quest/data/models/trace_dto.dart';
import 'package:metro_quest/data/sources/lines_datasource.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_line_segment_entity.dart';
import 'package:metro_quest/domain/entities/metro_line_trace_entity.dart';
import 'package:metro_quest/domain/repositories/lines_repository.dart';

class LineRepositoryImpl implements LineRepository {
  final LineDataSource lineDataSource;

  LineRepositoryImpl({required this.lineDataSource});

  @override
  Future<List<MetroLine>> getAllLines() async {
    final unSortedTraces = await lineDataSource.fetchTracesDto();

    Map<String, List<TraceDto>> tracesMap = {};
    for (var trace in unSortedTraces) {
      if (tracesMap.containsKey(trace.resCom)) {
        tracesMap[trace.resCom]!.add(trace);
      } else {
        tracesMap[trace.resCom] = [trace];
      }
    }

    print('Grouped traces into ${tracesMap.length} lines');

    List<MetroLine> lines = [];

    for (var key in tracesMap.keys) {
      print('Line $key has ${tracesMap[key]!.length} traces');

      final newLine = MetroLine(
        id: key,
        name: key,
        color: Color(
          int.parse('0xff${tracesMap[key]!.first.colourWebHexa}'),
        ),
        stationsIds: [],
        // traces: tracesMap[key]!.map((e) => e.geoShape).toList(),
        lineTrace: MetroLineTrace(
          lineId: key,
          segments: tracesMap[key]!
              .map(
                (e) => MetroLineSegment(
                  coordinates: e.geoShape.coordinates,
                ),
              )
              .toList(),
        ),

        // lineTrace:  -> to be implemented
      );

      lines.add(newLine);
    }

    // convert the map into a list of Line entities

    print('Fetched ${unSortedTraces.length} traces');

    return lines;
  }
}
