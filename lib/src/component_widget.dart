import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

/// a widget that takes a component
/// viewmodel and build based on the events it listens to.
class ComponentBuilder<T extends ComponentViewModel> extends StatefulWidget {
  const ComponentBuilder({
    required this.builder,
    this.create,
    this.instance,
    Key? key,
  })  : assert(create != null || instance != null),
        super(key: key);

  final T Function(BuildContext)? create;
  final T? instance;
  final Widget Function(BuildContext, T) builder;

  @override
  State<ComponentBuilder<T>> createState() => _ComponentBuilderState<T>();
}

class _ComponentBuilderState<T extends ComponentViewModel>
    extends State<ComponentBuilder<T>> {
  T? component;

  T getComponent(BuildContext context) {
    if (widget.instance != null) {
      return widget.instance!;
    }
    if (component == null) {
      component = widget.create?.call(context);
      component!.context = context;
    }
    return component!;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.getRegistry().registerComponent(getComponent(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: getComponent(context),
        builder: (context, child) {
          return widget.builder.call(context, getComponent(context));
        });
  }

  @override
  void dispose() {
    super.dispose();
    component?.componentRegistry.unregister(component!);
  }
}
