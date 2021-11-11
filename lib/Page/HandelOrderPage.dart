import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:webshop/Widget/HandleOrderTable_Widget.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';

class HandleOrderPage extends StatelessWidget{
  static const id = '/HandelOrder-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, HandleOrderPage.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Đơn hàng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text('Quản lý các đơn hàng cần được xử lý'),
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
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(height: 10,),
            HandelOrderTable()
          ],
        ),
      ),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}