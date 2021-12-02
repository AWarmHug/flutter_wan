part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchEventHot extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchEventQuery extends SearchEvent {
  final String k;
  final int pageNum;

  SearchEventQuery(this.k, this.pageNum);

  @override
  List<Object?> get props => [k, pageNum];
}
