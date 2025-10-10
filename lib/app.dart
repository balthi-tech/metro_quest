import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/router/app_router.dart';
import 'package:metro_quest/core/theme/theme.dart';
import 'package:metro_quest/core/theme/util.dart';

class MetroQuestApp extends ConsumerWidget {
  const MetroQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    TextTheme textTheme = createTextTheme(context, "Lato", "Raleway");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: kDebugMode,
      title: 'Metro Quest',
      themeMode: ThemeMode.light,
      darkTheme: theme.dark(),
      theme: theme.light(),
      routerConfig: router,
    );
  }
}
