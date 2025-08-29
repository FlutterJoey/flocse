import 'dart:async';
import 'package:flutter/material.dart';

import 'component_registry.dart';
import 'event.dart';
import 'event_listener.dart';

/// An independent element in the application
///
/// A component is defined by the following characteristics:
/// 1. A component does not have any dependencies to other components
/// 2. A component is fully testable as a unit
/// 3. Communication is only possible through the broadcasting and receiving of
/// events
/// 5. is synchronous, meaning that an event needs to exit a component before entering the next
///
/// Every component lives inside a registry, therefor has access to the container
/// that provides the implementation
abstract mixin class Component {
  late final ComponentRegistry componentRegistry;
  late final int priority;

  /// sends an event onto the eventbus
  FutureOr<void> send<T extends Event>(T event) async {
    await componentRegistry.sendEvent<T>(event, this);
  }

  /// used to register a callback to an event
  @mustCallSuper
  void registerEvent<T extends Event>(EventListener<T> onEvent,
      [int? priority]) {
    componentRegistry.registerListener(onEvent, this, priority);
  }

  /// called when registering/unregistering events;
  FutureOr<void> initListeners();

  /// called when the component is loaded
  void onLoad() {}

  /// called when the component is unloaded;
  void onUnload() {}

  FutureOr<void> onError(Object error, StackTrace trace, Event event) async {
    throw error;
  }
}
