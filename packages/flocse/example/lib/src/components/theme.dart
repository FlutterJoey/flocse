import 'package:example/src/events/theme/theme_change.dart';
import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

class ThemeComponent extends ComponentViewModel {
  ThemeComponent({required this.theme});

  ThemeData theme;

  @override
  Future<void> initListeners() async {
    registerEvent(_changeTheme);
  }

  void _changeTheme(ChangeThemeEvent event) {
    theme = event.themeData;
  }

  @override
  void onLoad() {}

  @override
  void onUnload() {}
}
