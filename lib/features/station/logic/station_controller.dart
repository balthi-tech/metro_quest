import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/domain/usecases/get_all_stations_usecase.dart';

class StationController extends AsyncNotifier<List<Station>> {
  final GetStationsUseCase getStationsUseCase;

  StationController(
    this.getStationsUseCase,
  );

  @override
  Future<List<Station>> build() async {
    return getStationsUseCase.execute();
  }
}
