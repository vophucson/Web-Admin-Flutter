import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/checkstore_model.dart';

class StoreHouseController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> editQuantityKey = GlobalKey<FormState>();
  var quantityList = <Data>[].obs;
  var editController;
  var editQuantity = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchQuantity(int productId) async {
    final response = await ApiService.checkQuantity(
        productId, loginController.box.read('token'));
    if (response.data != null) {
      quantityList.clear();
      quantityList.addAll(response.data!);
    }
  }

  Future<int?> updateQuantity(
      int productId, double productSize, int quantity) async {
    final response = await ApiService.updateQuantity(
        loginController.box.read('token'), productId, productSize, quantity);
    return response.success;
  }

  void save() {
    final form = editQuantityKey.currentState;
    form!.save();
  }
}
