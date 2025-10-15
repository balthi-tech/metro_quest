import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/station_entity.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';

class StationController extends AsyncNotifier<List<Station>> {
  @override
  Future<List<Station>> build() async {
    final getStationsUseCase = ref.read(getStationsUseCaseProvider);

    return getStationsUseCase.execute();
  }
}
