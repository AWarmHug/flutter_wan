import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:get/get.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/search");
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Text("搜索一下~~",style: AppTextStyles.white_14,),
      ),
    );
  }
}
