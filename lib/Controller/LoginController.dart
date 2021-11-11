import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webshop/Api/api_service.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  var emailController;
  var passwordController;
  var isLoading = true.obs;
  var data =''.obs;
  var email =''.obs;
  var password = ''.obs;
  var idUser =0.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
  }
  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
  Future<int?> login(String email, String password) async {
      try {
        isLoading(true);
        final response = await ApiService.login(email, password);
        data(response.data);
        box.write('token', response.token);
        idUser(response.idUser);
        return response.success;
      }
      finally {
        isLoading(false);
      }
  }
  String? validateEmail (String value){
    if(!GetUtils.isEmail(value))
    {
      return "Địa chỉ Email không hợp lệ";
    }
    return null;

  }
  String? validatePassword (String value){
    if(value.length < 6)
    {
      return "Mật khẩu phải từ 6 ký tự trở lên";
    }
    return null;
  }
  bool checkLogin(){
    final form = loginKey.currentState;
    if(form!.validate() ==true) {
      form.save();
      return true;
    }
    else
    {
      return false;
    }
  }
}
