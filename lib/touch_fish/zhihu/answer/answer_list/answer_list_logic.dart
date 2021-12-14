import 'package:flutter/foundation.dart';
import 'package:flutter_wan/data/zhihu/answer_list_item.dart';
import 'package:flutter_wan/data/zhihu/paging.dart';
import 'package:flutter_wan/extensions.dart';
import 'package:get/get.dart';

import '../../../../error.dart';
import '../../../../http.dart';
import 'answer_list_state.dart';

class AnswerListLogic extends GetxController {
  final AnswerListState state = AnswerListState();

  Paging? paging;

  @override
  void onInit() {
    super.onInit();
    refreshFeedList();
  }


  void refreshFeedList() {
    _loadFeedList().then((value) {
      debugPrint("--------成功");
    }).catchAppError((appError) {
      debugPrint("--------错误");
    });
  }

  void loadFeedList() {
    _loadFeedList().then((value) {}).catchAppError((appError) {});
  }

  Future<void> _loadFeedList() async {
    String path;

    if (paging == null) {
      path =
      "v4/questions/${state.question!.id!}/answers?include=data%5B*%5D.is_normal%2Cadmin_closed_comment%2Creward_info%2Cis_collapsed%2Cannotation_action%2Cannotation_detail%2Ccollapse_reason%2Cis_sticky%2Ccollapsed_by%2Csuggest_edit%2Ccomment_count%2Ccan_comment%2Ccontent%2Ceditable_content%2Cattachment%2Cvoteup_count%2Creshipment_settings%2Ccomment_permission%2Ccreated_time%2Cupdated_time%2Creview_info%2Crelevant_info%2Cquestion%2Cexcerpt%2Cis_labeled%2Cpaid_info%2Cpaid_info_content%2Crelationship.is_authorized%2Cis_author%2Cvoting%2Cis_thanked%2Cis_nothelp%2Cis_recognized%3Bdata%5B*%5D.mark_infos%5B*%5D.url%3Bdata%5B*%5D.author.follower_count%2Cvip_info%2Cbadge%5B*%5D.topics%3Bdata%5B*%5D.settings.table_of_content.enabled&offset=0&limit=20";
    } else {
      path = paging!.next!;
    }

    var response = await Http.get<List<AnswerListItem>>(path);
    if (response.isSuccess) {
      if (response.data != null && response.data!.isNotEmpty) {
        state.answers = response.data!;
        update();
      } else {
        return Future.error(AppError.noData());
      }
    } else {
      return Future.error(response.error!);
    }
  }

}
