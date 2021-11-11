import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';
import 'package:webshop/Widget/UserTable_Widget.dart';

class UserPage extends StatelessWidget {
  static const id = '/user-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, UserPage.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Tài khoản',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text('Quản lý phân quyền tài khoản'),
            Divider(
              thickness: 5,
            ),
            Container(
              color: Colors.grey[200],
              height: 50,
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(height: 10,),
            UserTable(),
            //   CategoryList(),
          ],
        ),
      ),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}
