import 'package:metro_quest/domain/entities/metro_line_entity.dart';

abstract class LineRepository {
  Future<List<MetroLine>> getAllLines();
}
