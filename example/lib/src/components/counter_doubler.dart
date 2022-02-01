import 'package:example/main.dart';
import 'package:example/src/events/navigation/navigate.dart';
import 'package:flocse/flocse.dart';

class CounterDoublerComponent extends Component {
  @override
  void initListeners() {
    registerEvent((IncrementEvent event) => event.value *= 2);
    registerEvent((CounterUpdateEvent event) {
      if (event.value < 10) {
        event.value *= 3;
      } else if (event.value < 20) {
        event.value = 10;
      }
      if (event.value > 30) {
        send(NavigateEvent.root('other'));
      }
    });
  }

  @override
  void onLoad() {}

  @override
  void onUnload() {}
}
