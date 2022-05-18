import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

class EventLogger {
  EventLogger();

  void logEvent(EventLog log) {
    debugPrint(log.toString());
  }
}

class EventLog {
  Component? component;
  Event event;

  EventLog(this.event, this.component);

  @override
  String toString() {
    return 'An event of type ${event.runtimeType} '
        'was fired by ${component?.runtimeType ?? 'registry'}';
  }
}
