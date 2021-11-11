import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/user_model.dart';

class AccountShipperController extends GetxController {
  var isLoading = true.obs;
  var shipperList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  var nameShipperList = <String>[].obs;
  var selectShipper =''.obs;
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> fetchAccountShipper() async {
    try {
      isLoading(true);
      final response = await ApiService.getAccountShipper( loginController.box.read('token'));
      if (response.data != null) {
        shipperList.clear();
        shipperList.addAll(response.data!);
        nameShipperList.clear();
        for(int i =0;i< response.data!.length;i++)
          {
            nameShipperList.add("${response.data![i].id}:${response.data![i].username}");
          }
        selectShipper(nameShipperList[0]);
      }
    } finally {
      isLoading(false);
    }
  }
}