import 'package:flocse_core/flocse_core.dart';
import 'package:flutter/material.dart';

class ComponentRegistryProvider extends StatefulWidget {
  const ComponentRegistryProvider(
      {required this.child, required this.components, this.logger, super.key});

  final List<Component> components;
  final Widget child;
  final EventLogger? logger;

  @override
  State<ComponentRegistryProvider> createState() =>
      _ComponentRegistryProviderState();
}

class _ComponentRegistryProviderState extends State<ComponentRegistryProvider> {
  late final ComponentRegistry _componentRegistry;

  @override
  void initState() {
    super.initState();
    _componentRegistry = ComponentRegistry(logger: widget.logger);
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
      {super.key,
      required super.child,
      required ComponentRegistry componentRegistry})
      : _componentRegistry = componentRegistry;

  @override
  bool updateShouldNotify(covariant InheritedRegistry oldWidget) {
    return false;
  }
}
