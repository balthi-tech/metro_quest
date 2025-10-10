import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/features/data_loading/logic/data_loading_controller.dart';

final dataLoadingControllerProvider = AsyncNotifierProvider<DataLoadingController, void>(
  () => DataLoadingController(),
);
