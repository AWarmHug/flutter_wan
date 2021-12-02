import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../status.dart';
import '../../search_bloc.dart';
import 'search_content_item.dart';

class SearchContentPage extends StatefulWidget {
  final String name;

  const SearchContentPage(this.name, {Key? key}) : super(key: key);

  @override
  _SearchContentPageState createState() => _SearchContentPageState();
}

class _SearchContentPageState extends State<SearchContentPage> {
  @override
  void initState() {
    super.initState();
    SearchBloc bloc = context.read();
    bloc.add(SearchEventQuery(widget.name, 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.name),
      ),
      body: Container(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchStateResult) {
              if (state.status == Status.LOADING) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status == Status.SUCCESS) {
                if (state.result is ListData<Article>) {
                  ListData<Article> result = state.result;
                  return StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(left: 8, top: 16, right: 8),
                    crossAxisCount: 4,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    itemBuilder: (context, index) {
                      return SearchContentItem(result.datas[index]);
                    },
                    itemCount: result.datas.length,
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.fit(
                          2); //第一个参数是横轴所占的单元数，第二个参数是主轴所占的单元数
                    },
                  );
                } else {
                  return Center(
                    child: Text("失败2222"),
                  );
                }
              } else {
                return Center(
                  child: Text("失败"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
