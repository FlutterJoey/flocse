import 'dart:async';

import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

/// This class is the core connection between the component business logic
/// architecture and the flutter widget environment.
///
/// The main purpose of this class is to contain a snapshot of the state for
/// the widget. This is not the place to edit state or execute business logic.
/// You should use your own implementation of a [Component] for that.
///
/// Preferably register a few events that contain the full state, so
/// mutation of this viewmodel is kept to a minimum.
abstract class ComponentViewModel extends Component with ChangeNotifier {
  late final BuildContext context;

  bool _loaded = false;

  bool get loaded => _loaded;

  /// register an event that triggers a rebuild. Provides a
  /// [ComponentViewmodelEvent] as a wrapper of the event.
  ///
  /// You can control rebuilds by marking the event as unchanged if your event
  /// did not result in a state change.
  ///
  /// If you want to listen to an event without ever triggering a rebuild,
  /// then using the method [Component.registerEvent] should be the proper way.
  void onEvent<T extends Event>(ComponentViewmodelEventListener<T> onEvent,
      [int? priority]) {
    super.registerEvent<T>(
      (T event) async {
        var wrapped = ComponentViewmodelEvent(event);
        await onEvent(wrapped);
        if (!wrapped._unchanged) {
          notifyListeners();
        }
      },
      priority,
    );
  }

  @override
  void onLoad() {
    _loaded = true;
    notifyListeners();
  }
}

class ComponentViewmodelEvent<T extends Event> {
  T event;

  ComponentViewmodelEvent(this.event);

  bool _unchanged = false;

  /// marks this current handled event as not changing internal state.
  ///
  /// In general, its better to use your own [Component] to handle events that
  /// do not result in UI changes. The main purpose is to handle when two
  /// different events enter after each other whilst both sending the same
  /// information
  void markUnchanged() {
    _unchanged = true;
  }
}

typedef ComponentViewmodelEventListener<T extends Event> = FutureOr<void>
    Function(ComponentViewmodelEvent<T> event);
