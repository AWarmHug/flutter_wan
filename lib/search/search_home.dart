import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan/search/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/search_page.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: SearchPage(),
    );
  }
}
