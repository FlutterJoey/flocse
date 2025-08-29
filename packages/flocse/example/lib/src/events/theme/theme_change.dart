import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

class ChangeThemeEvent extends Event {
  ChangeThemeEvent(this.themeData);
  final ThemeData themeData;
}
