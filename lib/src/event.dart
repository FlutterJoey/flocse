/// Base class for events.
///
/// Do not use this class directly, rather extend this class and add your own
/// data.
class Event {
  bool _cancelled = false;

  void setCancelled(bool cancelled) {
    _cancelled = cancelled;
  }

  bool isCancelled() {
    return _cancelled;
  }
}
