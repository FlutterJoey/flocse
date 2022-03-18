import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

abstract class ComponentViewModel extends Component with ChangeNotifier {
  late final BuildContext context;

  bool _loaded = false;

  bool get loaded => _loaded;

  @override
  void registerEvent<T extends Event>(EventListener<T> onEvent,
      [int? priority]) {
    super.registerEvent<T>(
      (T event) async {
        await onEvent(event);
        notifyListeners();
      },
      priority,
    );
  }

  @override
  void onLoad() {
    _loaded = true;
    notifyListeners();
  }

  @override
  void onUnload() {}

  @override
  Future<void> initListeners();
}
