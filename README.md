<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A new approach to business logic by having all logic be independent components.
Unlike Bloc, state is not managed by sending states but by viewmodels, which are
components as well. 

## Features
* Seperate your logic from your widgets.
* Testable and easy to integrate.
* Easy to learn

## Getting started

At the top level of your app, provide a ComponentRegistry, then anywhere in your app use a
ComponentBuilder with your own ComponentViewModel. 
Register your eventhandlers and add components in the componentregistry.

**W.I.P.** A proper example will follow. This is a short description...

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
class CounterComponent extends Component {
  late int counter;

  @override
  void initListeners() {
    // called before onLoad, use this to register the events
    registerEvent(onIncrement);
    registerEvent(onDecrement);
  }

  Future<void> onIncrement(IncrementEvent e) async {
    // can be fully asynchronous
    await Future.delayed(Duration(milliseconds: Random().nextInt(2000)));
    counter = counter + e.value;
    send(CounterUpdateEvent(counter));
  }

  void onDecrement(DecrementEvent e) {
    // or sync, but will only be called if this exact event is sent
    counter = counter - e.value;
    send(CounterUpdateEvent(counter));
  }

  @override
  void onLoad() {
    // called after register listeners, use this set up your component
    counter = 0;
  }

  @override
  void onUnload() {
      // called right after the listeners are unregistered
  }
}
```

## Additional information

More information soon to come
