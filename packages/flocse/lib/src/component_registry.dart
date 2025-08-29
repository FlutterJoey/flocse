import 'dart:async';

import 'package:flocse/src/component.dart';
import 'package:flocse/src/event.dart';
import 'package:flocse/src/event_logger.dart';
import 'package:flocse/src/event_listener.dart';

class ComponentRegistry {
  final Map<Type, List<dynamic>> _listeners = {};

  final List<Component> components = [];
  final EventLogger? _logger;

  ComponentRegistry({
    EventLogger? logger,
  }) : _logger = logger;

  /// Sends an event to all listeners of the given type
  Future<void> sendEvent<T extends Event>(T event,
      [Component? sender]) async {
    _logger?.logEvent(EventLog(event, sender));
    for (var listener in _retrieveListeners(event.runtimeType)) {
      var reference = listener as _ListenerReference<T>;
      if (!event.isCancelled()) {
        try {
          await reference.listener.call(event);
        } catch (e, s) {
          // notify component of error, but never stop call order.
          await reference.component.onError(e, s, event);
        }
      }
    }
  }

  void registerComponent(Component component, [int? priority]) {
    components.add(component);
    component.priority = priority ?? components.indexOf(component);
    _initializeComponent(component);
  }

  void unregister(Component component) {
    // remove component and make sure no references are kept
    _unloadComponent(component);
    components.removeWhere((element) => element == component);
  }

  void _unloadComponent(Component component) {
    _listeners.forEach((key, value) {
      value.removeWhere((element) => element.component == component);
    });
    component.onUnload();
  }

  void _initializeComponent(Component component) async {
    component.componentRegistry = this;
    await component.initListeners();
    component.onLoad();
  }

  /// Registers a listener which is fired when an avent of type T is sent.
  ///
  /// The order of execution is determined by the priority of listener if set,
  /// else by the priority of the component.
  ///
  /// Priority does not ensure that the listener is called before or after other
  /// listeners. It is only used to determine the order of execution. If all
  /// listeners are asynchronous but use await in their internal logic, the
  /// order of execution is always the same.
  void registerListener<T extends Event>(
      EventListener<T> listener, Component component,
      [int? priority]) {
    _retrieveListeners(listener.getType())
      ..add(_ListenerReference<T>(
          listener, component, priority ?? component.priority))
      ..sort();
  }

  List<dynamic> _retrieveListeners(Type type) {
    return _listeners.putIfAbsent(type, () => []);
  }

  void dispose() {
    // get rid of dual reference between component and registry
    components.clear();
  }
}

class _ListenerReference<T extends Event> implements Comparable {
  final EventListener<T> listener;
  final Component component;
  final List<T> history = [];
  final int priority;
  _ListenerReference(this.listener, this.component, this.priority);

  @override
  int compareTo(covariant _ListenerReference other) {
    return priority - other.priority;
  }
}
