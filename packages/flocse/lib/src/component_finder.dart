import 'package:flocse/src/registry_provider.dart';
import 'package:flocse_core/flocse_core.dart';
import 'package:flutter/material.dart';

extension ComponentFinder on BuildContext {
  ComponentRegistry getRegistry() {
    var widget = dependOnInheritedWidgetOfExactType<InheritedRegistry>();
    if (widget == null) {
      throw FlutterError(
        'You cannot find a componentRegistry in your context '
        'if none were ever provided',
      );
    }
    return widget.componentRegistry;
  }
}
