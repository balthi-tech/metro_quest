import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationPayloadNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setPayload(String? payload) {
    state = payload;
  }
}
