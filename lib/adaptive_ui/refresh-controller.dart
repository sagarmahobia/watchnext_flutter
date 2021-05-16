class RefreshControl {
  List<RefreshEventListener> listeners = [];

  void addListener(RefreshEventListener listener) {
    listeners.add(listener);
  }

  void onRefresh() {
    listeners.forEach((element) {
      element.refresh();
    });
  }
}

class RefreshEventListener {
  void refresh() {}
}
