import 'dart:async';

import 'package:flocse/flocse.dart';
import 'package:flocse_core/flocse_core.dart';
import 'package:flutter/material.dart';

/// Used for listening to events
///
/// Can be useful to listen to an event with a required context without
/// having to set up [ComponentViewModel] boilerplate
class EventSubscriber<T extends Event> extends StatefulWidget {
  const EventSubscriber({
    this.onEventReceived,
    @Deprecated("on event does not contain state, use onEventReceived instead")
    this.onEvent,
    required this.child,
    super.key,
  });

  final EventListener<T>? onEvent;
  final FutureOr<void> Function(T, State<EventSubscriber<T>>)? onEventReceived;
  final Widget child;

  @override
  State<EventSubscriber<T>> createState() => _EventSubscriberState<T>();
}

class _EventSubscriberState<T extends Event> extends State<EventSubscriber<T>>
    with Component {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.getRegistry().registerComponent(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initListeners() {
    registerEvent<T>((T event) {
      widget.onEventReceived?.call(event, this);
      widget.onEvent?.call(event);
    });
  }

  @override
  void onLoad() {}

  @override
  void onUnload() {}
}
