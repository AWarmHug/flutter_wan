import 'package:flutter/material.dart';

import '../status.dart';

typedef Footer = Widget Function(Status status);

class RefreshController {
  ValueNotifier<Status> refreshStatus = ValueNotifier(Status.LOADING);

  ValueNotifier<Status> footerStatus = ValueNotifier(Status.LOADING);

  void refreshSuccess() {
    refreshStatus.value = Status.SUCCESS;
  }

  void refreshError() {
    footerStatus.value = Status.ERROR;
  }


  void loadSuccess() {
    footerStatus.value = Status.SUCCESS;
  }

  void loadError() {
    footerStatus.value = Status.ERROR;
  }

  void dispose() {
    // refreshStatus.dispose();
    // footerStatus.dispose();
  }
}

class SmartRefresh extends StatefulWidget {
  const SmartRefresh(
      {Key? key,
      required this.onRefresh,
      required this.onLoad,
      required this.refreshController,
      required this.itemBuilder,
      required this.itemCount,
      required this.footer})
      : super(key: key);

  final VoidCallback onRefresh;

  final VoidCallback onLoad;

  final RefreshController refreshController;

  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  final Footer footer;

  @override
  _SmartRefreshState createState() => _SmartRefreshState();
}

class _SmartRefreshState extends State<SmartRefresh> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //已经滑到底了
        widget.refreshController.footerStatus.value = Status.LOADING;
        widget.onLoad();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
            return widget.footer(widget.refreshController.footerStatus.value);
          }
        },
        itemCount: widget.itemCount + 1,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant SmartRefresh oldWidget) {
    if (widget.refreshController != oldWidget.refreshController) {
      widget.refreshController.refreshStatus.value =
          oldWidget.refreshController.refreshStatus.value;
      widget.refreshController.footerStatus.value =
          oldWidget.refreshController.footerStatus.value;
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


