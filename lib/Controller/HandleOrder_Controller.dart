import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/handelorder_model.dart';


class HandleOrderController extends GetxController {
  var isLoading = true.obs;
  var handleOrderList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchHandleOrder() async {
    try {
      isLoading(true);
      final response = await ApiService.getHandleOrder( loginController.box.read('token'));
      if (response.data != null) {
        handleOrderList.clear();
        handleOrderList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
  Future<int?> shipOrder(int shipperId,String orderId) async {
    final response = await ApiService.shipOrder(loginController.box.read('token'), shipperId, orderId);
    return response.success;
  }
  Future<int?> deleteOrder(String orderId) async {
    final response = await ApiService.deleteOrder(loginController.box.read('token'), orderId);
    return response.success;
  }
}