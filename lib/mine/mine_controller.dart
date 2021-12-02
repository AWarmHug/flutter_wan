import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/user.dart';
import 'package:get/get.dart';

import '../global.dart';
import '../http.dart';
import '../status.dart';

class MineController extends GetxController {
  Rx<Resource<User>> userResource = Rx(Resource.loading());
  Rx<Resource> logoutResource = Rx(Resource.loading());

  @override
  void onInit() {
    super.onInit();
    Global.isLogin2().then((value) {
      Global.isLogin.value = value;
    });

    Global.isLogin.listen((value) {
      if(value){
        loadUser();
      }else{
        userResource.value = Resource.error("失败");
      }
    });
  }

  void loadUser() async {
    userResource.value = Resource.loading();

    ResponseWan<User> user = await Http.get<User>("user/lg/userinfo/json");
    if (user.isSuccess) {
      userResource.value = Resource.success(user.data!);
    } else {
      userResource.value = Resource.error("失败");
    }
    update();
  }

  void logout() async {
    logoutResource.value = Resource.loading();

    ResponseWan logout = await Http.get("user/logout/json");
    if (logout.isSuccess) {
      logoutResource.value = Resource.success(logout.data);
      Global.isLogin.value = false;
    } else {
      logoutResource.value = Resource.error("失败");
      Global.isLogin.value = true;
    }
    update();
  }
}
