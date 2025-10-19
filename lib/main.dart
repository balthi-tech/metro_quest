import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/app.dart';
import 'package:metro_quest/core/utils/hive_service.dart';

void main() async {
  // Uncomment the line below to enable rebuild debugging
  // debugPrintRebuildDirtyWidgets = true;
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  runApp(const ProviderScope(child: MetroQuestApp()));
}
