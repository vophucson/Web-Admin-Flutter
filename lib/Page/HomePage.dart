import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';


class HomePage extends StatelessWidget {
  static const id = '/home-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, HomePage.id),
      body: Center(child: Text('WEB QUẢN TRỊ',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}