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
      onEvent: (event) {
        var navigator = navigatorKey.currentState;
        navigator?.pushNamedAndRemoveUntil(event.route, (route) => false);
      },
    );
  }
}
