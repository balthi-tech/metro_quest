import 'package:metro_quest/domain/entities/sort_criteria.dart';

enum MetroStationSortCriteria implements SortCriteria {
  nameAsc,
  nameDesc,
  distanceAsc,
  distanceDesc,
  idAsc,
  idDesc;

  @override
  String label() {
    switch (this) {
      case MetroStationSortCriteria.nameAsc:
        return 'Nom (A-Z)';
      case MetroStationSortCriteria.nameDesc:
        return 'Nom (Z-A)';
      case MetroStationSortCriteria.distanceAsc:
        return 'Distance (plus proche)';
      case MetroStationSortCriteria.distanceDesc:
        return 'Distance (plus éloigné)';
      case MetroStationSortCriteria.idAsc:
        return 'ID (croissant)';
      case MetroStationSortCriteria.idDesc:
        return 'ID (décroissant)';
    }
  }
}
