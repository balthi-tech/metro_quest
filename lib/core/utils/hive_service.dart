import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:metro_quest/core/constants/hive_boxes.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await _openBoxes();
  }

  static Future<void> _openBoxes() async {
    await Hive.openBox<String>(HiveBoxes.visitedStationsBox);
  }
}
