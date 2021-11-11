
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:cool_alert/cool_alert.dart';

class LoginPage extends StatelessWidget {
  static const String id = '/login-screen';
 final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF84c225), Colors.white],
              stops: [1.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment(0.0, 0.0))),
      child: Center(
        child: Container(
          width: 380,
          height: 380,
          child: Card(
            shape: Border.all(color: Colors.green, width: 2),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: loginController.loginKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/logo.png',
                              height: 120,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Container(
                                height: 40,
                                child: TextFormField(
                                  controller: loginController.emailController,
                                  validator: (value) {
                                    return loginController.validateEmail(value!);
                                  },
                                  onSaved: (value) {
                                    loginController.email(value);
                                  },
                                  decoration: InputDecoration(
                                    label: Text('Email'),
                                      labelStyle: TextStyle(color: Colors.green),
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Colors.green,
                                      ),
                                      hintText: "Nhập địa chỉ Email",
                                      focusColor: Theme.of(context).primaryColor,
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).primaryColor,
                                            width: 2),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Container(
                                height: 40,
                                child: TextFormField(
                                  controller: loginController.passwordController,
                                  validator: (value) {
                                    return loginController
                                        .validatePassword(value!);
                                  },
                                  onSaved: (value) {
                                    loginController.password(value);
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      label: Text('Mật khẩu'),
                                      labelStyle: TextStyle(color: Colors.green),
                                      prefixIcon: Icon(
                                        Icons.vpn_key_outlined,
                                        color: Colors.green,
                                      ),
                                      hintText: "Nhập mật khẩu",
                                      focusColor: Theme.of(context).primaryColor,
                                      contentPadding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).primaryColor,
                                            width: 2),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                        if (loginController.checkLogin() == true) {
                          loginController
                              .login(loginController.email.value,
                                  loginController.password.value)
                              .then((success) {
                            if (success == 1) {
                              CoolAlert.show(
                                width: 50,
                                backgroundColor: Colors.green,
                                context: context,
                                type: CoolAlertType.success,
                                confirmBtnColor: Colors.green,
                                text: "Đăng nhập thành công",
                                confirmBtnText: 'OK',
                                onConfirmBtnTap: () {
                                  Get.offAllNamed('/home-screen');
                                },
                              );
                              loginController.emailController.clear();
                              loginController.passwordController
                                  .clear();
                            } else {
                              if (success == 0) {
                                CoolAlert.show(
                                  width: 50,
                                  backgroundColor: Colors.redAccent,
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "${loginController.data}",
                                  confirmBtnColor: Colors.redAccent,
                                  confirmBtnText: 'OK',
                                  onConfirmBtnTap: () {
                                    Get.back();
                                  },
                                );
                              }
                            }
                          });
                        }
                          },
                          child: Text('Đăng nhập',style: TextStyle(fontSize: 30),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
