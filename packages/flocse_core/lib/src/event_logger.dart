import 'dart:async';

import 'package:flocse_core/flocse_core.dart';

class EventLogger {
  EventLogger(FutureOr<void> Function(String) logger) : _logger = logger;

  final FutureOr<void> Function(String) _logger;

  void logEvent(EventLog log) {
    _logger.call(log.toString());
  }
}

class EventLog {
  final Component? component;
  final Event event;

  const EventLog(this.event, this.component);

  @override
  String toString() {
    return 'An event of type ${event.runtimeType} '
        'was fired by ${component?.runtimeType ?? 'registry'}';
  }
}
