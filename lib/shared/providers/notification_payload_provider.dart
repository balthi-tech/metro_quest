import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/shared/providers/notification_payload_notifier.dart';

final notificationPayloadProvider = NotifierProvider<NotificationPayloadNotifier, String?>(
  () => NotificationPayloadNotifier(),
);
