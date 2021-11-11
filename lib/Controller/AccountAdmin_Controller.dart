import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/user_model.dart';

class AccountAdminController extends GetxController {
  var isLoading = true.obs;
  var adminList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchAccountAdmin() async {
    try {
      isLoading(true);
      final response = await ApiService.getAccountAdmin( loginController.box.read('token'));
      if (response.data != null) {
        adminList.clear();
        adminList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
}