import 'package:equatable/equatable.dart';
import 'package:metro_quest/domain/entities/fact_entity.dart';
import 'package:metro_quest/domain/entities/metro_station_sort_criteria.dart';

class MetroStationFilterCriterias extends Equatable {
  final String? lineId;
  final String? lineName;
  final String? id;
  final String? name;
  final String? city;
  final Fact? funFact;
  final Fact? historyFact;
  final MetroStationSortCriteria? sortBy;

  const MetroStationFilterCriterias({
    this.lineId,
    this.lineName,
    this.id,
    this.name,
    this.city,
    this.funFact,
    this.historyFact,
    this.sortBy,
  });

  @override
  List<Object?> get props => [lineId, lineName, id, name, city, funFact, historyFact, sortBy];
}
