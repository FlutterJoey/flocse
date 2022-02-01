class Event {
  bool _cancelled = false;

  void setCancelled(bool cancelled) {
    _cancelled = cancelled;
  }

  bool isCancelled() {
    return _cancelled;
  }
}
