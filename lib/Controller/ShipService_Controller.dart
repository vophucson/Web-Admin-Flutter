import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/shipservice_model.dart';


class ShipServiceController extends GetxController {
  var isLoading = true.obs;
  var serviceList = <Data>[].obs;
  final GlobalKey<FormState> serviceKey = GlobalKey<FormState>();
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> editServiceKey = GlobalKey<FormState>();
  var nameController;
  var timeController;
  var priceController;
  var name = ''.obs;
  var time = ''.obs;
  var price = ''.obs;
  var nameEdit =''.obs;
  var timeEdit = ''.obs;
  var priceEdit =''.obs;
  @override
  void onInit() {
    super.onInit();
    nameController = new TextEditingController();
    timeController = new TextEditingController();
    priceController = new TextEditingController();
    @override
    void dispose() {
      super.dispose();
      nameController.dispose();
      timeController.dispose();
      priceController.dispose();
    }
  }
  Future<void> fetchShipService() async {
    try {
      isLoading(true);
      final response =
      await ApiService.getShipService();
      if (response.data != null) {
        serviceList.clear();
        serviceList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
  Future<int?> create(String shipName,String shipDay,String shipPrice) async {
    final response = await ApiService.createService(
        shipName,shipDay,shipPrice,loginController.box.read('token'));
    return response.success;
  }
  Future<int?> delete(int shipServiceId) async {
    final response = await ApiService.deleteService(
        shipServiceId, loginController.box.read('token'));
    return response.success;
  }
  Future<int?> updateService(int shipServiceId,String shipName,String shipDay,String shipPrice) async {
    final response = await ApiService.updateService(loginController.box.read('token'),shipServiceId,shipName,shipDay,shipPrice);
    return response.success;
  }
  String? validateName(String value) {
    if (value.length == 0) {
      return "Không được để trống";
    }
    return null;
  }

  bool check() {
    final form = serviceKey.currentState;
    if (form!.validate() == true) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
  void save()
  {
    final form = editServiceKey.currentState;
    form!.save();
  }
}