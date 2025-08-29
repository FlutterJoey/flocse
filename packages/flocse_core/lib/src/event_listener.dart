import 'dart:async';

import 'event.dart';

/// Used for listening to events
typedef EventListener<T extends Event> = FutureOr<void> Function(T event);

/// an extension to expose the runtimetype of an event to enable event
/// registering and filtering
extension EventType<T extends Event> on EventListener<T> {
  Type getType() {
    return T;
  }
}
