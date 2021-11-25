import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:webshop/Controller/LoginController.dart';
import 'package:webshop/Page/LoginPage.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';


class SettingPage extends StatelessWidget {
  static const id = '/Setting-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
   return  AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, SettingPage.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Hệ thống',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text('Cấu hình hệ thống'),
            Divider(
              thickness: 5,
            ),
            Container(
              color: Colors.grey[200],
              height: 50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                      ),
                      onPressed: () {
                        loginController.box.write('token', 'chua_co_tai_khoan_dang_nhap_he_thong');
                        Get.offAllNamed('/login-screen');
                      },
                      child: Text(
                        'Đăng xuất',
                        style: TextStyle(
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}