import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

enum LogColors {
  basic,
  error,
  warning;

  static const _whiteColor = 97;
  static const _redColor = 31;
  static const _yellowColor = 33;

  int toColorNumber() {
    switch (this) {
      case LogColors.basic:
        return _whiteColor;
      case LogColors.error:
        return _redColor;
      case LogColors.warning:
        return _yellowColor;
    }
  }
}

abstract class Log {
  static final _regexPrefix = RegExp(r'#2\s+[a-z\s]*([a-zA-Z_]+)');

  static String _getPrefix() {
    final stacktrace = StackTrace.current.toString();
    final match = _regexPrefix.firstMatch(stacktrace);
    final prefix = match != null ? match.group(1)! : "UNKNOWN";

    return prefix;
  }

  static String colorWrapper(
    String message, [
    LogColors colors = LogColors.basic,
  ]) {
    return "\x1B[${colors.toColorNumber()}m$message\x1B[0m";
  }

  static void d(String message) {
    if (!kDebugMode) {
      return;
    }

    final prefix = _getPrefix();
    final content = colorWrapper(message, LogColors.basic);
    developer.log("\t> $content", name: prefix);
  }

  static void e(String message, [StackTrace? stackTrace]) {
    if (!kDebugMode) {
      return;
    }

    final prefix = _getPrefix();
    final content = colorWrapper(message, LogColors.error);

    developer.log(
      "\t> (ERROR) $content",
      name: prefix,
      stackTrace: stackTrace ?? StackTrace.current,
    );

    // final crashlyticsProvider = Injector.get<CrashlyticsProvider>();
    // crashlyticsProvider.reportLogError(
    //   message,
    //   stackTrace ?? StackTrace.current,
    // );
  }

  static void w(String message) {
    if (!kDebugMode) {
      return;
    }

    final prefix = _getPrefix();
    final content = colorWrapper(message, LogColors.warning);

    developer.log("\t> (WARNING) $content", name: prefix);
  }
}
