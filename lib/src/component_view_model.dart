import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

abstract class ComponentViewModel extends Component with ChangeNotifier {
  late final BuildContext context;

  @override
  void registerEvent<T extends Event>(EventListener<T> onEvent) {
    super.registerEvent<T>((T event) async {
      await onEvent(event);
      notifyListeners();
    });
  }
}
