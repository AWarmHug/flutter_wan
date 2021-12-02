import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/search.dart';
import 'package:flutter_wan/http.dart';
import 'package:flutter_wan/status.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchEventHot) {
      yield SearchStateResult.loading();
      ResponseWan<List<HotKey>> responseWan =
          await Http.get<List<HotKey>>("hotkey/json");
      if (responseWan.isSuccess) {
        yield SearchStateResult.success(responseWan.data);
      } else {
        yield SearchStateResult.error();
      }
    }

    if (event is SearchEventQuery) {
      yield SearchStateResult.loading();
      ResponseWan<ListData<Article>> responseWan = await Http.post<ListData<Article>>(
          "article/query/${event.pageNum}/json", {"k": event.k});
      if (responseWan.isSuccess) {
        yield SearchStateResult.success(responseWan.data);
      } else {
        yield SearchStateResult.error();
      }
    }
  }
}
