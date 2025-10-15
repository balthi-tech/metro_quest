import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';

class LineController extends AsyncNotifier<List<MetroLine>> {
  @override
  Future<List<MetroLine>> build() async {
    final getlinesUseCase = ref.read(getlinesUseCaseProvider);

    return getlinesUseCase.execute();
  }
}
