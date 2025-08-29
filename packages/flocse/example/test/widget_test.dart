import 'package:example/main.dart';
import 'package:example/src/components/counter_doubler.dart';
import 'package:flocse/flocse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter doubler', () {
    late ComponentHarness harness;
    late CounterDoublerComponent sut;

    setUp(() {
      sut = CounterDoublerComponent();
      harness = ComponentHarness.mount(component: sut);
    });

    test('should double the counter', () async {
      var event = IncrementEvent(2);

      await harness.sendTest(event);

      expect(harness.noEvents(), isTrue);

      expect(event.value, equals(4));
    });
  });
}
