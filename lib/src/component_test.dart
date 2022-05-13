import 'dart:async';

import 'package:flocse/flocse.dart';
import 'package:flutter/foundation.dart';

class _MockComponent extends Component {
  @override
  FutureOr<void> initListeners() async {}
}

class ComponentHarness {
  ComponentHarness._(this.sut) {
    _harnessRegistry = _HarnessRegistry(eventHandler: events.add);
    _harnessRegistry.registerComponent(sut);
  }

  factory ComponentHarness.mount({required Component component}) {
    var harness = ComponentHarness._(component);
    return harness;
  }

  late final _HarnessRegistry _harnessRegistry;
  final Component sut;
  final List<Event> events = [];

  void mockEvent<T extends Event>(EventListener<T> event) {
    _harnessRegistry.registerListener(event, _MockComponent());
  }

  Future<void> sendTest<T extends Event>(T event) async {
    return await _harnessRegistry.sendEvent(event, true);
  }

  bool eventOfTypes(List<Type> types) {
    return listEquals(events.map((e) => e.runtimeType).toList(), types);
  }

  bool eventOfType<T extends Event>() {
    return eventOfTypes([T]);
  }

  bool noEvents() {
    return events.isEmpty;
  }

  bool exactEvent<T extends Event>(T event, [int count = 1]) {
    return events.where((element) => element == event).length == count;
  }

  bool exactEvents(List<Event> events) {
    return listEquals(events, this.events);
  }

  bool atLeastEvents(List<Event> events) {
    return events.every((element) => this.events.contains(element));
  }

  bool atLeastEventsInOrder(List<Event> events) {
    int eventIndex = 0;
    for (var i = 0; i < this.events.length; i++) {
      if (eventIndex == events.length) {
        return true;
      }
      if (this.events[i] == events[eventIndex]) {
        eventIndex++;
      }
    }
    return eventIndex == events.length;
  }
}

class _HarnessRegistry extends ComponentRegistry {
  void Function(Event onEvent) eventHandler;

  _HarnessRegistry({
    required this.eventHandler,
  });

  @override
  FutureOr<void> sendEvent<T extends Event>(T event,
      [bool disableLog = false]) async {
    if (!disableLog) {
      eventHandler.call(event);
    }
    return await super.sendEvent(event);
  }
}
