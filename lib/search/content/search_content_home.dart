import 'package:flutter/material.dart';
import 'package:flutter_wan/search/content/widgets/search_content_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../search_bloc.dart';

class SearchContentHome extends StatelessWidget {
  const SearchContentHome({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: SearchContentPage(Get.arguments["name"]),
    );
  }
}
