import 'package:equatable/equatable.dart';

import 'status.dart';

abstract class CommonState extends Equatable {
  const CommonState();
}

class CommonInitial extends CommonState {
  @override
  List<Object?> get props => [];
}

class CommonStateResult<T> extends CommonState {
  final Status status;

  final T? result;

  CommonStateResult(this.status, this.result);

  CommonStateResult.loading() : this(Status.LOADING, null);

  CommonStateResult.success(T value) : this(Status.SUCCESS, value);

  CommonStateResult.error() : this(Status.ERROR, null);

  @override
  List<Object?> get props => [status, result];
}
