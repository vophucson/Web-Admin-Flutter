import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/user_model.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  var selectRole = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUser() async {
    try {
      isLoading(true);
      final response =
          await ApiService.getUser(loginController.box.read('token'));
      if (response.data != null) {
        userList.clear();
        userList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
  Future<int?> setRole(int id,String role) async {
    final response = await ApiService.setRole(id, role, loginController.box.read('token'));
    return response.success;
  }
}
