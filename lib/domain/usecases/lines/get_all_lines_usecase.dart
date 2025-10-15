import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/repositories/lines_repository.dart';

class GetLinesUseCase {
  final LineRepository repository;

  GetLinesUseCase({required this.repository});

  Future<List<MetroLine>> execute() async {
    return await repository.getAllLines();
  }
}
