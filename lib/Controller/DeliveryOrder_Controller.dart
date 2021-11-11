import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/orderstatus_model.dart';


class DeliveryOrderController extends GetxController {
  var isLoading = true.obs;
  var deliveryOrderList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchDeliveryOrder() async {
    try {
      isLoading(true);
      final response = await ApiService.getDeliveryOrder( loginController.box.read('token'));
      if (response.data != null) {
        deliveryOrderList.clear();
        deliveryOrderList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
}