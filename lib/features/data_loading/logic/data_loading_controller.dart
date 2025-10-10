import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/features/station/logic/station_provider.dart';

class DataLoadingController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Préchargez ici toutes les données nécessaires
    // Par exemple, appeler stationController, attendez qu'il soit chargé

    final stationController = ref.read(stationControllerProvider.notifier);

    await stationController.build();

    // Ajoutez d'autres préchargements ici si besoin
  }
}
