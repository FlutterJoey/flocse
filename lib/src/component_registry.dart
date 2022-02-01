import 'dart:async';

import 'package:flocse/src/component.dart';
import 'package:flocse/src/event.dart';
import 'package:flocse/src/eventlistener.dart';

class ComponentRegistry {
  final Map<Type, List<dynamic>> _listeners = {};

  final List<Component> components = [];

  FutureOr<void> sendEvent<T extends Event>(T event) async {
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
    if (priority == null) {
      components.add(component);
    } else {
      components.insert(priority, component);
    }
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

  void _initializeComponent(Component component) {
    component.componentRegistry = this;
    component.initListeners();
    component.onLoad();
  }

  void registerListener<T extends Event>(
    EventListener<T> listener,
    Component component,
  ) {
    _retrieveListeners(listener.getType())
        .add(_ListenerReference<T>(listener, component));
  }

  List<dynamic> _retrieveListeners(Type type) {
    return _listeners.putIfAbsent(type, () => []);
  }

  void dispose() {
    // get rid of dual reference between component and registry
    components.clear();
  }
}

class _ListenerReference<T extends Event> {
  final EventListener<T> listener;
  final Component component;
  final List<T> history = [];
  _ListenerReference(this.listener, this.component);
}
