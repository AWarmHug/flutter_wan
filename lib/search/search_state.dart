part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateResult<T> extends SearchState {
  final Status status;

  final T? result;

  SearchStateResult(this.status, this.result);

  SearchStateResult.loading() : this(Status.LOADING, null);

  SearchStateResult.success(T hotKeys) : this(Status.SUCCESS, hotKeys);

  SearchStateResult.error() : this(Status.ERROR, null);

  @override
  List<Object?> get props => [status, result];
}
