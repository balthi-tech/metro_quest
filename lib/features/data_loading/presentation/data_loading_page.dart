import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/features/data_loading/logic/data_loading_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';

class DataLoadingPage extends ConsumerWidget {
  const DataLoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dataLoadingControllerProvider);

    ref.listen(dataLoadingControllerProvider, (_, next) {
      if (next.isRefreshing == false && next.hasValue && !next.hasError) {
        context.go('/');
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text("Data Loading")),
      body: _buildBody(state, context),
    );
  }

  Widget _buildBody(AsyncValue<void> state, BuildContext context) {
    return asyncValueWrapper(
      asyncValue: state,
      data: (_) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Données chargées avec succès! Redirection...", textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: Text("Continuer"),
            ),
          ],
        ),
      ),
    );
  }
}
