import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/data/banner.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';

class BannerItemView extends StatelessWidget {
  final BannerItem banner;

  const BannerItemView(this.banner, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(alignment: Alignment.center, children: [
        CachedNetworkImage(
          imageUrl: banner.imagePath ?? "",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black26),
            padding:
                const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
            child: Text(
              banner.title!,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ]),
    );
  }
}
