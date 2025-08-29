import 'package:flocse/flocse.dart';

class NavigateEvent extends Event {
  final String route;

  final bool root;

  final bool push;

  final dynamic additionalData;

  NavigateEvent(this.route, this.root, this.push, [this.additionalData]);

  factory NavigateEvent.push(String route, [dynamic additionalData]) {
    return NavigateEvent(route, false, true, additionalData);
  }

  factory NavigateEvent.replace(String route, [dynamic additionalData]) {
    return NavigateEvent(route, false, false, additionalData);
  }

  factory NavigateEvent.root(String route, [dynamic additionalData]) {
    return NavigateEvent(route, true, true, additionalData);
  }
}
