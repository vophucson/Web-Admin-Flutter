import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/user_model.dart';

class AccountUserController extends GetxController {
  var isLoading = true.obs;
  var userList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchAccountShipper() async {
    try {
      isLoading(true);
      final response = await ApiService.getAccountUser( loginController.box.read('token'));
      if (response.data != null) {
        userList.clear();
        userList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
}