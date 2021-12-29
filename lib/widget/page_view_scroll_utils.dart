import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PageViewScrollUtils {
  final PageController pageController;
  ScrollDragController? _drag;

  PageViewScrollUtils(this.pageController);

  DragStartDetails? dragStartDetails;

  bool handleNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      dragStartDetails = notification.dragDetails;
    }

    if (notification is OverscrollNotification) {
      if (_drag == null) {
        ScrollPositionWithSingleContext a =
            pageController.position as ScrollPositionWithSingleContext;
        _drag = a.drag(dragStartDetails!, () {
          _drag = null;
        }) as ScrollDragController;
      }

      if (notification.dragDetails != null) {
        _drag?.update(notification.dragDetails!);
      }
    }

    if (notification is ScrollUpdateNotification) {
      return false;
    }

    if (notification is ScrollEndNotification) {
      dragStartDetails = null;
      if (notification.dragDetails != null) {
        _drag?.end(notification.dragDetails!);
      }
    }

    if (notification is UserScrollNotification) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          debugPrint("---------------------forward------------------------");
          break;
        case ScrollDirection.idle:
          _drag?.cancel();
          debugPrint("---------------------idle------------------------");
          break;
        case ScrollDirection.reverse:
          debugPrint("---------------------forward------------------------");
          break;
      }
    }

    debugPrint("---------context = ${notification.context}");

    debugPrint("---------${notification}");
    return true;
  }
}
