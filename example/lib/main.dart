import 'package:example/src/app.dart';
import 'package:flocse/flocse.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(AccountApp());
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ComponentBuilder<CounterViewModel>(
      create: (_) => CounterViewModel(0),
      builder: (context, component) {
        return Scaffold(
          body: Center(
            child: Text('Counter is at: ${component.value}'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: component.increment,
          ),
        );
      },
    );
  }
}

class CounterViewModel extends ComponentViewModel {
  int _value;

  CounterViewModel(int value) : _value = value;

  int get value => _value;

  @override
  void initListeners() {
    registerEvent(_onCounterUpdate);
  }

  void _onCounterUpdate(CounterUpdateEvent event) {
    _value = event.value;
  }

  void increment() {
    send(IncrementEvent(1));
  }

  void decrement() {
    send(DecrementEvent(1));
  }

  @override
  void onLoad() {}

  @override
  void onUnload() {}
}

class IncrementEvent extends Event {
  int value;

  IncrementEvent(this.value);
}

class DecrementEvent extends Event {
  int value;

  DecrementEvent(this.value);
}

class CounterUpdateEvent extends Event {
  int value;

  CounterUpdateEvent(this.value);
}

class SetCounterEvent extends Event {
  int value;

  SetCounterEvent(this.value);
}
