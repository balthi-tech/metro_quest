import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/app.dart';
import 'package:metro_quest/core/services/database/hive_service.dart';
import 'package:metro_quest/shared/widgets/lifecycle_manager.dart';

void main() async {
  // Uncomment the line below to enable rebuild debugging
  // debugPrintRebuildDirtyWidgets = true;
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: LifecycleManager(
        child: MetroQuestApp(),
      ),
    ),
  );
}
