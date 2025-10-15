import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LinePresentationPage extends ConsumerStatefulWidget {
  final String lineId;
  const LinePresentationPage({super.key, required this.lineId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinePresentationPageState();
}

class _LinePresentationPageState extends ConsumerState<LinePresentationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go('/lines');
          },
        ),
        title: const Text('Détails de la ligne'),
      ),
      body: const Center(
        child: Text('Contenu des détails de la ligne à implémenter'),
      ),
    );
  }
}
