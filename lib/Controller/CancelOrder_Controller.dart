import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/orderstatus_model.dart';


class CancelOrderController extends GetxController {
  var isLoading = true.obs;
  var cancelOrderList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchCancelOrder() async {
    try {
      isLoading(true);
      final response = await ApiService.getCancelOrder( loginController.box.read('token'));
      if (response.data != null) {
        cancelOrderList.clear();
        cancelOrderList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
}