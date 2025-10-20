import 'package:flutter/material.dart';
import 'package:metro_quest/domain/entities/sort_criteria.dart';

class MetroFilterButton<T extends SortCriteria> extends StatefulWidget {
  final List<T> values;
  final T? initialCriteria;
  final ValueChanged<T>? onCriteriaSelected;
  final Color? color;

  const MetroFilterButton({
    super.key,
    required this.values,
    this.initialCriteria,
    this.onCriteriaSelected,
    this.color,
  });

  @override
  State<MetroFilterButton<T>> createState() => _MetroFilterButtonState<T>();
}

class _MetroFilterButtonState<T extends SortCriteria> extends State<MetroFilterButton<T>> {
  late T? selectedCriteria = widget.initialCriteria;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      icon: Icon(
        Icons.filter_list,
        color: widget.color,
      ),
      tooltip: 'Trier',
      position: PopupMenuPosition.under,
      offset: const Offset(0, 8),
      initialValue: selectedCriteria,
      onSelected: (T criteria) {
        setState(() => selectedCriteria = criteria);
        widget.onCriteriaSelected?.call(criteria);
      },
      itemBuilder: (context) => widget.values
          .map(
            (criteria) => PopupMenuItem<T>(
              value: criteria,
              child: Text('Trier par ${criteria.label()}'),
            ),
          )
          .toList(),
    );
  }
}
