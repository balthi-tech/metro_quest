import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/core/router/error_page.dart';
import 'package:metro_quest/features/data_loading/presentation/data_loading_page.dart';
import 'package:metro_quest/features/home/presentation/home_page.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: '/data-loading',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/data-loading',
          name: 'dataLoading',
          pageBuilder: (context, state) => const MaterialPage(child: DataLoadingPage()),
        ),

        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
        ),

        // GoRoute(
        //   path: '/station/:id',
        //   name: 'stationDetail',
        //   pageBuilder: (context, state) {
        //     final id = state.params['id']!;
        //     return MaterialPage(child: StationDetailScreen(stationId: id));
        //   },
        // ),
        // Ajouter d'autres routes ici (ex: discovery, challenges, settings)
      ],
      // Optional: error page
      errorPageBuilder: (context, state) => MaterialPage(child: ErrorPage()),
    );
  },
);
