import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/category_model.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = <Data>[].obs;
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> categoryKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editKey = GlobalKey<FormState>();
  var nameController;
  var imageController;
  var name = ''.obs;
  var image = ''.obs;
  var nameEdit = ''.obs;
  var imageEdit = ''.obs;
  var nameList = <String>[].obs;
  var name1 = ''.obs;
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

  Future<void> fetchCategory() async {
    try {
      isLoading(true);
      final response = await ApiService.getCategory();
      if (response.data != null) {
        categoryList.clear();
        categoryList.addAll(response.data!);
        nameList.clear();
        for(int i =0 ;i< response.data!.length;i++)
          {
            nameList.add(response.data![i].categoryName.toString());
          }
        name1(response.data![0].categoryName.toString());
      }
      print(nameList);
    } finally {
      isLoading(false);
    }
  }

  Future<int?> create(String categoryName, String categoryImage) async {
    final response = await ApiService.createCategory(
        categoryName, categoryImage, loginController.box.read('token'));
    return response.success;
  }

  String? validateName(String value) {
    if (value.length == 0) {
      return "Không được để trống";
    }
    return null;
  }

  bool check() {
    final form = categoryKey.currentState;
    if (form!.validate() == true) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
  void save()
  {
    final form = editKey.currentState;
    form!.save();
  }

  Future<int?> delete(int categoryId) async {
    final response = await ApiService.deleteCategory(
        categoryId, loginController.box.read('token'));
    return response.success;
  }
  Future<int?> updateCategory(int categoryId,String categoryName,String categoryImage) async {
    final response = await ApiService.updateCategory(loginController.box.read('token'), categoryId, categoryName, categoryImage);
    return response.success;
  }
}
