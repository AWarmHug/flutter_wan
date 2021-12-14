import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/author.dart';
import 'package:flutter_wan/data/zhihu/feed_item.dart';
import 'package:flutter_wan/data/zhihu/target.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/network_image.dart';


class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key? key, required this.target}) : super(key: key);
  final Target target;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExceptWidget(
          target: target,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "${target.voteupCount!} 赞同",
              style: AppTextStyles.black_14.size(12).color2(Colors.black54),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "${target.commentCount!} 评论",
              style: AppTextStyles.black_14.size(12).color2(Colors.black54),
            ),
          ],
        )
      ],
    );
  }
}

class AuthorWidget extends StatelessWidget {
  const AuthorWidget({Key? key, required this.author}) : super(key: key);
  final Author author;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: AppNetworkImage(
            imageUrl: author.avatarUrl!,
            width: 16,
            height: 16,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          author.name!,
          style: AppTextStyles.black_12.bold,
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: Text(
            author.headline!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyles.black_12.color2(Colors.black54),
          ),
        ),
      ],
    );
  }
}

class ExceptWidget extends StatelessWidget {
  const ExceptWidget({Key? key, required this.target}) : super(key: key);
  final Target target;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              AuthorWidget(
                author: target.author!,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                target.excerpt!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.black_14.color2(Colors.black87),
              ),
            ],
          ),
        ),
        image(),
      ],
    );
  }

  image() {
    return (target.thumbnail != null &&
        target.thumbnail!.isNotEmpty)
        ? ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: AppNetworkImage(
        imageUrl: target.thumbnail!,
        width: 92,
        height: 64,
        fit: BoxFit.fill,
      ),
    )
        : SizedBox();
  }
}
