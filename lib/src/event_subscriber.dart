import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

class EventSubscriber<T extends Event> extends StatefulWidget {
  const EventSubscriber({
    required this.onEvent,
    required this.child,
    Key? key,
  }) : super(key: key);

  final EventListener<T> onEvent;
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
    registerEvent(widget.onEvent);
  }

  @override
  void onLoad() {}

  @override
  void onUnload() {}
}
