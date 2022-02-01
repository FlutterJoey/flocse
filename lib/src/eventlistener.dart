import 'dart:async';

import 'package:flocse/flocse.dart';

import 'event.dart';

typedef EventListener<T extends Event> = FutureOr<void> Function(T event);

extension EventType<T extends Event> on EventListener<T> {
  Type getType() {
    return T;
  }
}
