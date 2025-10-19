import 'package:metro_quest/data/sources/lines_datasource.dart';
import 'package:metro_quest/domain/entities/metro_line_entity.dart';
import 'package:metro_quest/domain/repositories/lines_repository.dart';

class LineRepositoryImpl implements LineRepository {
  final LineDataSource lineDataSource;

  LineRepositoryImpl({required this.lineDataSource});

  @override
  Future<List<MetroLine>> getAllLines() async {
    final metroLinesDto = await lineDataSource.fetchMetroLinesDto();

    final metroLines = metroLinesDto.map((dto) => dto.toDomain()).toList();

    return metroLines;
  }
}
