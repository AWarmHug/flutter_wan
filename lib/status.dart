import 'package:flutter/material.dart';

enum Status { LOADING, SUCCESS, ERROR }

extension StatusEx on Status {
  get name {
    switch (this) {
      case Status.LOADING:
        return "LOADING";
      case Status.SUCCESS:
        return "SUCCESS";
      case Status.ERROR:
        return "ERROR";
    }
  }
}

class Resource<T> {
  final Status status;
  final T? data;
  final String? message;

  Resource(this.status, {this.data, this.message});

  Resource.loading() : this(Status.LOADING);

  Resource.loadingMore(T? data) : this(Status.LOADING, data: data);

  Resource.success(T? data) : this(Status.SUCCESS, data: data, message: null);

  Resource.error(String? message)
      : this(Status.ERROR, data: null, message: message);

  bool isSuccess() {
    return status == Status.SUCCESS;
  }
}

class StatusWidget extends StatelessWidget {
  final Status status;
  final WidgetBuilder builder;

  const StatusWidget({
    Key? key,
    required this.status,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.LOADING:
        return Center(
          child: CircularProgressIndicator(),
        );
      case Status.ERROR:
        return Center(
          child: Text("发生错误"),
        );
      case Status.SUCCESS:
        return builder(context);
      default:
        return builder(context);
    }
  }
}

class StatusResourceWidget extends StatelessWidget {
  final Resource resource;
  final WidgetBuilder builder;

  StatusResourceWidget({required this.resource, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StatusWidget(
      status: resource.status,
      builder: builder,
    );
  }
}

class StatusMoreWidget extends StatelessWidget {
  final Status status;

  final WidgetBuilder? builder;

  const StatusMoreWidget({Key? key, required this.status, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("status = ${status.name}");
    switch (status) {
      case Status.LOADING:
        return builder != null
            ? builder!(context)
            : Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text("加载中...")
                  ],
                ),
              );
      case Status.ERROR:
        return Center(
          child: Text("发生错误"),
        );
      default:
        return Center(
          child: Text("加载成功"),
        );
    }
  }
}
