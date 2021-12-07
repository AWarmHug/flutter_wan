import 'package:flutter/material.dart';
import 'package:flutter_wan/error.dart';

import '../status.dart';

typedef Footer = Widget Function(Status status);

class RefreshController {
  ValueNotifier<Status> refreshStatus = ValueNotifier(Status.LOADING);

  ValueNotifier<Status> footerStatus = ValueNotifier(Status.LOADING);

  void refreshSuccess() {
    refreshStatus.value = Status.SUCCESS;
  }

  void refreshError([int? code]) {
    if (code != null) {
      switch (code) {
        case AppError.ERROR_NO_DATA:
          refreshNoData();
          break;
        default:
          refreshStatus.value = Status.ERROR;
          break;
      }
    } else {
      refreshStatus.value = Status.ERROR;
    }
  }

  void refreshNoData() {
    refreshStatus.value = Status.NO_DATA;
  }

  void loadSuccess() {
    footerStatus.value = Status.SUCCESS;
  }

  void loadError([int? code]) {
    if (code != null) {
      switch (code) {
        case AppError.ERROR_NO_DATA:
          refreshNoData();
          break;
        default:
          footerStatus.value = Status.ERROR;
          break;
      }
    } else {
      footerStatus.value = Status.ERROR;
    }
  }

  void loadNoData() {
    footerStatus.value = Status.NO_DATA;
  }

  void dispose() {
    // refreshStatus.dispose();
    // footerStatus.dispose();
  }
}

class SmartRefresher extends StatefulWidget {
  const SmartRefresher({
    Key? key,
    required this.onRefresh,
    required this.onLoad,
    required this.refreshController,
    required this.itemBuilder,
    required this.itemCount,
    required this.footer,
  }) : super(key: key);

  final VoidCallback onRefresh;

  final VoidCallback onLoad;

  final RefreshController refreshController;

  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  final Footer footer;

  @override
  _SmartRefresherState createState() => _SmartRefresherState();
}

class _SmartRefresherState extends State<SmartRefresher> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //已经滑到底了
        debugPrint("object------加载下一页");
        // setState(() {
        widget.refreshController.footerStatus.value = Status.LOADING;
        // });
        widget.onLoad();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("object------build");

    return Container(
      child: ValueListenableBuilder<Status>(
        valueListenable: widget.refreshController.refreshStatus,
        builder: (context, value, child) {
          return StatusWidget(
            status: value,
            child: RefreshIndicator(
              displacement: 44.0,
              onRefresh: () async {
                widget.onRefresh();
              },
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index < widget.itemCount) {
                    return widget.itemBuilder(context, index);
                  } else {
                    return ValueListenableBuilder<Status>(
                      valueListenable: widget.refreshController.footerStatus,
                      builder: (context, value, child) {
                        return widget.footer(value);
                      },
                    );
                  }
                },
                itemCount: widget.itemCount == 0 ? 0 : widget.itemCount + 1,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant SmartRefresher oldWidget) {
    if (widget.refreshController != oldWidget.refreshController) {
      widget.refreshController.refreshStatus.value =
          oldWidget.refreshController.refreshStatus.value;
      widget.refreshController.footerStatus =
          oldWidget.refreshController.footerStatus;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("object------didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    widget.refreshController.dispose();
  }
}

class RefreshInheritedWidget extends InheritedWidget {
  final Status status;

  RefreshInheritedWidget({required Widget child, required this.status})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant RefreshInheritedWidget oldWidget) {
    debugPrint("object------status=${status}");
    debugPrint("object------oldWidget.status=${oldWidget.status}");

    return status != oldWidget.status;
  }

  static RefreshInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RefreshInheritedWidget>();
  }
}
