import 'package:example/src/components/theme.dart';
import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

class ThemeContainer extends StatelessWidget {
  const ThemeContainer({
    required this.child,
    required this.initialTheme,
    Key? key,
  }) : super(key: key);

  final ThemeData initialTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ComponentBuilder<ThemeComponent>(
      create: (ctx) => ThemeComponent(
        theme: initialTheme,
      ),
      builder: (context, component) {
        return Theme(data: component.theme, child: child);
      },
    );
  }
}
