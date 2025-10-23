import 'package:go_router/go_router.dart';
import 'package:metro_quest/core/utils/log.dart';
import 'package:metro_quest/domain/entities/notification_payload.dart';

class NotificationHandlerService {
  final GoRouter router;

  NotificationHandlerService({required this.router});

  void handleNotificationPayload(String rawPayload) {
    Log.d('Handling notification payload: $rawPayload');

    final payload = NotificationPayload.fromJson(rawPayload);

    Log.d('Parsed payload type: ${payload.runtimeType}');

    switch (payload.runtimeType) {
      case const (ProximityNotificationPayload):
        Log.d('Handling ProximityNotificationPayload');
        final typedPayload = payload as ProximityNotificationPayload;
        router.push('/station/${typedPayload.stationId}');
        break;
      case const (EventNotificationPayload):
        final typedPayload = payload as EventNotificationPayload;
        router.push('/event/${typedPayload.eventId}');
        break;
      default:
        break;
    }
  }
}
