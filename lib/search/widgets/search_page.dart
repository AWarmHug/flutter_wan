import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan/data/search.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/search/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../status.dart';
import 'search_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    SearchBloc bloc = context.read();
    bloc.add(SearchEventHot());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 32,
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 16),
                    hintStyle: TextStyle(color: Colors.white60),
                    hintText: "想搜什么就搜什么~~~",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIcon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.6),
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                  ),
                  onEditingComplete: () {
                    Get.toNamed("/search/content",
                        arguments: {"name": _controller.text});
                  },
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Text("取消",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 6, right: 6),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchStateResult) {
              if (state.status == Status.LOADING) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status == Status.SUCCESS) {
                List<HotKey> hotKeys = state.result!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "热门搜索词",
                        style: AppTextStyles.black_18_bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return GridView.count(
                            crossAxisCount: constraints.maxWidth < 600 ? 3 : 5,
                            children: hotKeys.map((e) {
                              return SearchItem(e);
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                );
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
