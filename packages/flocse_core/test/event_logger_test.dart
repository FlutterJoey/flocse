import 'package:flocse_core/flocse_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class _Logger {
  void log(String string);
}

class _LoggerMock extends Mock implements _Logger {}

class _EventMock extends Mock implements Event {}

class _ComponentMock extends Mock implements Component {}

void main() {
  group('EventLogger', () {
    late EventLogger sut;
    late _LoggerMock logger;

    setUp(() {
      logger = _LoggerMock();
      sut = EventLogger(logger.log);
    });

    group('logEvent', () {
      test('should log the event with given logger', () {
        sut.logEvent(EventLog(Event(), null));

        verify(() => logger.log(any(that: isA<String>()))).called(1);
      });
    });
  });

  group('EventLog', () {
    group('toString', () {
      test('mentions registry when no component is given', () {
        var sut = EventLog(Event(), null);
        var expected = 'An event of type Event was fired by registry';

        var actual = sut.toString();

        expect(actual, equals(expected));
      });

      test('mentions component runtimetype when a component is given', () {
        var sut = EventLog(Event(), _ComponentMock());
        var expected = 'An event of type Event was fired by _ComponentMock';

        var actual = sut.toString();

        expect(actual, equals(expected));
      });

      test('mentions event runtimetype', () {
        var sut = EventLog(_EventMock(), null);
        var expected = 'An event of type _EventMock was fired by registry';

        var actual = sut.toString();

        expect(actual, equals(expected));
      });
    });
  });
}
