import 'dart:math';

import 'package:example/main.dart';
import 'package:example/src/components/counter_doubler.dart';
import 'package:example/src/events/theme/theme_change.dart';
import 'package:example/src/screens/navigator.dart';
import 'package:example/src/screens/theme_container.dart';
import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

import 'components/counter.dart';

class AccountApp extends StatelessWidget {
  AccountApp({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ComponentRegistryProvider(
      components: [
        CounterDoublerComponent(),
        CounterComponent(),
      ],
      child: ThemeContainer(
        child: AppNavigator(
          navigatorKey: navigatorKey,
          child: AccountBase(
            navigator: navigatorKey,
          ),
        ),
        initialTheme: ThemeData.light(),
      ),
    );
  }
}

class AccountBase extends StatelessWidget {
  const AccountBase({required this.navigator, Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigator;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      theme: Theme.of(context),
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              ComponentBuilder<CounterViewModel>(
                create: (ctx) => CounterViewModel(0),
                builder: (context, component) {
                  return ElevatedButton(
                    onPressed: () {
                      component.increment();
                    },
                    child: Text('${component.value}'),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Press'),
                onPressed: () {
                  context.getRegistry().sendEvent(
                        ChangeThemeEvent(
                          ThemeData(
                              primarySwatch: [
                            Colors.blue,
                            Colors.red,
                            Colors.blueGrey,
                            Colors.yellow,
                            Colors.green,
                            Colors.purple,
                            Colors.amber,
                          ][Random().nextInt(7)]),
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
