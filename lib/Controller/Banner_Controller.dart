import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/banner_model.dart';

class BannerController extends GetxController {
  var isLoading = true.obs;
  var bannerList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> bannerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editBannerKey = GlobalKey<FormState>();
  var nameController;
  var imageController;
  var name = ''.obs;
  var image = ''.obs;
  var nameEdit = ''.obs;
  var imageEdit = ''.obs;
  @override
  void onInit() {
    super.onInit();
    nameController = new TextEditingController();
    imageController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    imageController.dispose();
  }

  Future<void> fetchBanner() async {
    try {
      isLoading(true);
      final response = await ApiService.getBanner();
      if (response.data != null) {
        bannerList.clear();
        bannerList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }
  Future<int?> create(String bannerName, String bannerImage) async {
    final response = await ApiService.createBanner(bannerName,bannerImage ,loginController.box.read('token'));
    return response.success;
  }

  String? validateName(String value) {
    if (value.length == 0) {
      return "Không được để trống";
    }
    return null;
  }

  bool check() {
    final form = bannerKey.currentState;
    if (form!.validate() == true) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
  void save()
  {
    final form = editBannerKey.currentState;
    form!.save();
  }
  Future<int?> delete(int bannerId) async {
    final response = await ApiService.deleteBanner(bannerId, loginController.box.read('token'));
    return response.success;
  }
  Future<int?> updateBanner(int bannerId,String bannerName,String bannerImage) async {
    final response = await ApiService.updateBanner(loginController.box.read('token'), bannerId, bannerName, bannerImage);
    return response.success;
  }
}
