import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/orderstatus_model.dart';


class AcceptedOrderController extends GetxController {
  var isLoading = true.obs;
  var acceptedOrderList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchAcceptedOrder() async {
    try {
      isLoading(true);
      final response = await ApiService.getAcceptedOrder( loginController.box.read('token'));
      if (response.data != null) {
        acceptedOrderList.clear();
        acceptedOrderList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
}