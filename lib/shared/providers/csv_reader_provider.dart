import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/utils/csv_parser.dart';

final csvParserProvider = Provider<CsvParser>((ref) => CsvParser());
