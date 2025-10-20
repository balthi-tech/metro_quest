import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/core/router/error_page.dart';
import 'package:metro_quest/features/data_loading/presentation/data_loading_page.dart';
import 'package:metro_quest/features/home/presentation/home_page.dart';
import 'package:metro_quest/features/line_detail/presentation/line_presentation_page.dart';
import 'package:metro_quest/features/lines/presentation/metro_lines_page.dart';
import 'package:metro_quest/features/nearest_station/presentation/nearest_station_page.dart';
import 'package:metro_quest/features/station_detail/presentation/station_presentation_page.dart';

// navigator key to control navigation outside of widget context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/data-loading',
      debugLogDiagnostics: false, // Set to true to enable debug logging
      routes: [
        GoRoute(
          path: '/data-loading',
          name: 'dataLoading',
          pageBuilder: (context, state) => const MaterialPage(child: DataLoadingPage()),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return ScaffoldWithTabs(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              pageBuilder: (_, _) => NoTransitionPage(child: HomePage()),
            ),
            GoRoute(
              path: '/lines',
              pageBuilder: (_, _) => NoTransitionPage(child: MetroLinesPage()),
            ),
            GoRoute(
              path: '/stations',
              pageBuilder: (_, _) => NoTransitionPage(child: AllStationsPage()),
            ),
          ],
        ),

        GoRoute(
          path: '/line/:id',
          name: 'lineDetail',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return MaterialPage(child: LinePresentationPage(lineId: id));
          },
        ),
        GoRoute(
          path: '/station/:id',
          name: 'stationDetail',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return MaterialPage(child: StationDetailPage(stationId: id));
          },
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage(child: ErrorPage()),
    );
  },
);

class ScaffoldWithTabs extends StatefulWidget {
  final Widget child;
  const ScaffoldWithTabs({required this.child, super.key});

  @override
  State<ScaffoldWithTabs> createState() => _ScaffoldWithTabsState();
}

class _ScaffoldWithTabsState extends State<ScaffoldWithTabs> {
  int _currentIndex = 0;

  static const _locationToIndex = {
    '/': 0,
    '/lines': 1,
    '/stations': 2,
  };

  static const _indexToLocation = {
    0: '/',
    1: '/lines',
    2: '/stations',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouter.of(context).state.path;

    _currentIndex = _locationToIndex[location] ?? 0;
  }

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      context.go(_indexToLocation[index]!);

      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Lines'),
          BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Stations'),
        ],
      ),
    );
  }
}
