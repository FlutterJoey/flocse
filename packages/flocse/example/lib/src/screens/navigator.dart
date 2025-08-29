import 'package:example/src/events/navigation/navigate.dart';
import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator(
      {required this.navigatorKey, required this.child, Key? key})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EventSubscriber<NavigateEvent>(
      child: child,
      onEventReceived: (event, state) {
        if (state.mounted) {
          var navigator = Navigator.of(state.context);
          navigator.pushNamedAndRemoveUntil(event.route, (route) => false);
        }
      },
    );
  }
}
