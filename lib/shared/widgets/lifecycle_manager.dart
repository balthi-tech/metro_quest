import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/shared/providers/background_location_service_provider.dart';
import 'package:metro_quest/shared/providers/notification_handler_service_provider.dart';
import 'package:metro_quest/shared/providers/notification_payload_provider.dart';

class LifecycleManager extends ConsumerStatefulWidget {
  final Widget child;

  const LifecycleManager({required this.child, super.key});

  @override
  ConsumerState<LifecycleManager> createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends ConsumerState<LifecycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // initialize background location service
    ref.read(backgroundLocationServiceProvider);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _onResumed();

        break;
      case AppLifecycleState.paused:
        // TODO: Suspendre ou optimiser background location
        Log.d("App paused");
        break;
      case AppLifecycleState.inactive:
        Log.d("App inactive");
        break;
      case AppLifecycleState.detached:
        Log.d("App detached");
        break;
      case AppLifecycleState.hidden:
        Log.d("App hidden");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(notificationPayloadProvider, (previous, next) {
      if (next != null) {
        final handler = ref.read(notificationHandlerProvider);
        handler.handleNotificationPayload(next);

        // Reset après traitement
        ref.read(notificationPayloadProvider.notifier).setPayload(null);
      }
    });
    return widget.child;
  }

  void _onResumed() {
    // TODO: Redémarrer service GPS, vérifier notifications, raffraichir UI
    Log.d("App resumed");

    final payload = ref.read(notificationPayloadProvider);

    if (payload != null) {
      final handler = ref.read(notificationHandlerProvider);
      handler.handleNotificationPayload(payload);

      // Reset après traitement
      ref.read(notificationPayloadProvider.notifier).setPayload(null);
    }
  }
}
