import 'dart:math';

import 'package:flocse/flocse.dart';

import '../../main.dart';

class Backend {}

class CounterComponent extends Component {
  late int counter;

  @override
  void initListeners() {
    registerEvent(onIncrement);
    registerEvent(onDecrement);
  }

  Future<void> onIncrement(IncrementEvent e) async {
    await Future.delayed(Duration(milliseconds: Random().nextInt(2000)));
    counter = counter + e.value;
    send(CounterUpdateEvent(counter));
  }

  void onDecrement(DecrementEvent e) {
    counter = counter - e.value;
    send(CounterUpdateEvent(counter));
  }

  @override
  void onLoad() {
    counter = 0;
  }

  @override
  void onUnload() {}
}
