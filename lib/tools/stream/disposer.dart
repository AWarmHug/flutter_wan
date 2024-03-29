import 'dart:async';

import 'package:flutter/material.dart';

class Disposer {
  final List<StreamSubscription> _subscriptions = [];

  final List<Listenable> _listenables = [];
  final List<VoidCallback> _listeners = [];

  /// Track a stream subscription to be automatically cancelled on dispose.
  void autoDispose(StreamSubscription subscription) {
    if (subscription == null) return;
    _subscriptions.add(subscription);
  }

  /// Add a listener to a Listenable object that is automatically removed when
  /// cancel is called.
  void addAutoDisposeListener(Listenable listenable,
      {required VoidCallback listener}) {
    if (listenable == null || listener == null) return;
    _listenables.add(listenable);
    _listeners.add(listener);
    listenable.addListener(listener);
  }

  /// Cancel all listeners added & stream subscriptions.
  ///
  /// It is fine to call this method and then add additional listeners.
  void cancel() {
    for (StreamSubscription subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();

    assert(_listenables.length == _listeners.length);
    for (int i = 0; i < _listenables.length; ++i) {
      _listenables[i].removeListener(_listeners[i]);
    }
    _listenables.clear();
    _listeners.clear();
  }
}

mixin AutoDisposeMixin<T extends StatefulWidget> on State<T>
    implements Disposer {
  final Disposer _delegate = Disposer();

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  void addAutoDisposeListener(Listenable listenable,
      {required VoidCallback listener}) {
    // TODO: implement addAutoDisposeListener
    _delegate.addAutoDisposeListener(listenable, listener:listener);
  }

  @override
  void autoDispose(StreamSubscription subscription) {
    _delegate.autoDispose(subscription);
  }

  @override
  void cancel() {
    _delegate.cancel();
  }
}
