import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';

class MetroLinesPage extends ConsumerStatefulWidget {
  const MetroLinesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MetroLinesPageState();
}

class _MetroLinesPageState extends ConsumerState<MetroLinesPage> {
  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(lineControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lignes de métro'),
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (lines) {
          return ListView.builder(
            itemCount: lines.length,
            itemBuilder: (context, index) {
              final line = lines[index];
              return ListTile(
                title: Text(line.name),
                subtitle: Text('ID de la ligne: ${line.id}'),
                leading: CircleAvatar(
                  backgroundColor: line.color,
                  child: Text(
                    line.name.substring(0, 1),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  context.go('/line/${line.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
