import 'package:flocse/src/component.dart';
import 'package:flocse/src/component_registry.dart';
import 'package:flutter/material.dart';

class ComponentRegistryProvider extends StatefulWidget {
  const ComponentRegistryProvider(
      {required this.child, required this.components, Key? key})
      : super(key: key);

  final List<Component> components;
  final Widget child;

  @override
  State<ComponentRegistryProvider> createState() =>
      _ComponentRegistryProviderState();
}

class _ComponentRegistryProviderState extends State<ComponentRegistryProvider> {
  late final ComponentRegistry _componentRegistry;

  @override
  void initState() {
    super.initState();
    _componentRegistry = ComponentRegistry();
    widget.components.forEach(_componentRegistry.registerComponent);
  }

  @override
  Widget build(BuildContext context) {
    return InheritedRegistry(
      componentRegistry: _componentRegistry,
      child: widget.child,
    );
  }
}

class InheritedRegistry extends InheritedWidget {
  final ComponentRegistry _componentRegistry;

  ComponentRegistry get componentRegistry {
    return _componentRegistry;
  }

  const InheritedRegistry(
      {Key? key,
      required Widget child,
      required ComponentRegistry componentRegistry})
      : _componentRegistry = componentRegistry,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedRegistry oldWidget) {
    return false;
  }
}
