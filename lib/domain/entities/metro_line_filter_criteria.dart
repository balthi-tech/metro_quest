import 'package:equatable/equatable.dart';
import 'package:metro_quest/domain/entities/metro_line_sort_criteria.dart';

class MetroLineFilterCriterias extends Equatable {
  final String? id;
  final String? name;
  final MetroLineSortCriteria? sortBy;

  const MetroLineFilterCriterias({
    this.id,
    this.name,
    this.sortBy,
  });

  @override
  List<Object?> get props => [id, name, sortBy];
}
