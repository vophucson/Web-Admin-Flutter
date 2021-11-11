import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webshop/Api/api_service.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Model/product_model.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Data>[].obs;
  var nameController;
  var desController;
  var priceController;
  var imageController;
  final GlobalKey<FormState> productKey = GlobalKey<FormState>();
  final GlobalKey<FormState> editProductKey = GlobalKey<FormState>();
  var name = ''.obs;
  var des = ''.obs;
  var price = 0.obs;
  var image = ''.obs;
  var nameEdit = ''.obs;
  var desEdit = ''.obs;
  var priceEdit = 0.obs;
  var imageEdit = ''.obs;
  var categoryEdit = ''.obs;
  LoginController loginController = Get.put(LoginController());
  @override
  void onInit() {
    super.onInit();
    nameController = new TextEditingController();
    desController = new TextEditingController();
    priceController = new TextEditingController();
    imageController = new TextEditingController();
  }

  Future<void> fetchAllProduct() async {
    try {
      isLoading(true);
      final response = await ApiService.getProduct();
      if (response.data != null) {
        productList.clear();
        productList.addAll(response.data!);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<int?> create(String productName, String categoryName, int productPrice,
      String description, String imageUrl) async {
    final response = await ApiService.createProduct(productName, categoryName,
        productPrice, description, imageUrl, loginController.box.read('token'));
    return response.success;
  }

  String? validateName(String value) {
    if (value.length == 0) {
      return "Không được để trống";
    }
    return null;
  }

  Future<int?> delete(int productId) async {
    final response = await ApiService.deleteProduct(
        productId, loginController.box.read('token'));
    return response.success;
  }

  Future<int?> updateProduct(
      String productName,
      int productPrice,
      int productId,
      String description,
      String imageUrl,
      String categoryName) async {
    final response = await ApiService.updateProduct(
        loginController.box.read('token'),
        productName,
        productPrice,
        productId,
        description,
        imageUrl,
        categoryName);
    return response.success;
  }

  bool check() {
    final form = productKey.currentState;
    if (form!.validate() == true) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
  void save()
  {
    final form = editProductKey.currentState;
    form!.save();
  }
}
