import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:metro_quest/domain/entities/metro_line_filter_criteria.dart';
import 'package:metro_quest/domain/entities/metro_line_sort_criteria.dart';
import 'package:metro_quest/features/lines/logic/line_provider.dart';
import 'package:metro_quest/shared/widgets/async_value_wrapper.dart';

class MetroLinesPage extends ConsumerStatefulWidget {
  const MetroLinesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MetroLinesPageState();
}

class _MetroLinesPageState extends ConsumerState<MetroLinesPage> {
  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(
      filteredSortedLinesProvider(
        MetroLineFilterCriterias(
          sortBy: MetroLineSortCriteria.distanceAsc,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lignes de métro'),
      ),
      body: asyncValueWrapper(
        asyncValue: asyncState,
        data: (lines) {
          // // sort lines by name
          // lines.sort((a, b) => a.id.compareTo(b.id));

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
                trailing: line.distanceFromUser != null
                    ? Text('${line.distanceFromUser!.toStringAsFixed(2)} km')
                    : null,
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
