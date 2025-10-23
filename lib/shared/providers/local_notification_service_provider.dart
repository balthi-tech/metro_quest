import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/services/notification/local_notification_service.dart';
import 'package:metro_quest/shared/providers/notification_payload_provider.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final service = NotificationService(
    onNotificationResponse: (String? payload) => ref.read(notificationPayloadProvider.notifier).setPayload(payload),
  );

  service.init();
  return service;
});
