import 'package:metro_quest/domain/entities/sort_criteria.dart';

enum MetroLineSortCriteria implements SortCriteria {
  nameAsc,
  nameDesc,
  distanceAsc,
  distanceDesc,
  idAsc,
  idDesc;

  @override
  String label() {
    switch (this) {
      case MetroLineSortCriteria.nameAsc:
        return 'Nom (A-Z)';
      case MetroLineSortCriteria.nameDesc:
        return 'Nom (Z-A)';
      case MetroLineSortCriteria.distanceAsc:
        return 'Distance (plus proche)';
      case MetroLineSortCriteria.distanceDesc:
        return 'Distance (plus éloigné)';
      case MetroLineSortCriteria.idAsc:
        return 'ID (croissant)';
      case MetroLineSortCriteria.idDesc:
        return 'ID (décroissant)';
    }
  }
}
