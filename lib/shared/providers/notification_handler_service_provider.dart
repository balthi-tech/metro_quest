import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metro_quest/core/router/app_router.dart';
import 'package:metro_quest/core/services/notification/notification_handler_service.dart';

final notificationHandlerProvider = Provider<NotificationHandlerService>((ref) {
  final router = ref.watch(routerProvider);
  return NotificationHandlerService(router: router);
});
