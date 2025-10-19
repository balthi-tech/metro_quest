import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/entities/metro_line_filter_criteria.dart';

class FilteredLinesUseCase {
  FilteredLinesUseCase();

  List<MetroLine> execute({
    required List<MetroLine> metroLines,
    MetroLineFilterCriterias? criteria,
  }) {
    return metroLines.where((line) {
      if (criteria?.id != null && line.id != criteria?.id) {
        return false;
      }
      if (criteria?.name != null && line.name != criteria?.name) {
        return false;
      }
      return true;
    }).toList();
  }
}
