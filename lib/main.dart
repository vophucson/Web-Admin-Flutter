import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webshop/Page/AcceptedOrderPage.dart';
import 'package:webshop/Page/AccountAdminPage.dart';
import 'package:webshop/Page/AccountShipperPage.dart';
import 'package:webshop/Page/AccountUserPage.dart';
import 'package:webshop/Page/BannerPage.dart';
import 'package:webshop/Page/CancelOrderPage.dart';
import 'package:webshop/Page/CategoryPage.dart';
import 'package:webshop/Page/DeliveryOrderPage.dart';
import 'package:webshop/Page/HandelOrderPage.dart';
import 'package:webshop/Page/HomePage.dart';
import 'package:webshop/Page/LoginPage.dart';
import 'package:webshop/Page/ProductPage.dart';
import 'package:webshop/Page/SettingPage.dart';
import 'package:webshop/Page/ShipServicePage.dart';
import 'package:webshop/Page/UserPage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life Kicks Admin',
      theme: ThemeData(
        primaryColor: Color(0xFF84c225),
      ),
      home: new LoginPage(),
      routes: {
        HomePage.id: (BuildContext context) => new HomePage(),
        BannerPage.id: (BuildContext context) => new BannerPage(),
        LoginPage.id: (BuildContext context) => LoginPage(),
        CategoryPage.id: (BuildContext context) => new CategoryPage(),
        ProductPage.id: (BuildContext context) => new ProductPage(),
        UserPage.id: (BuildContext context) => new UserPage(),
        ShipServicePage.id: (BuildContext context) => new ShipServicePage(),
        HandleOrderPage.id: (BuildContext context) => new HandleOrderPage(),
        DeliveryOrderPage.id: (BuildContext context) => new DeliveryOrderPage(),
        AcceptedOrderPage.id: (BuildContext context) => new AcceptedOrderPage(),
        CancelOrderPage.id: (BuildContext context) => new CancelOrderPage(),
        AccountAdminPage.id: (BuildContext context) => new AccountAdminPage(),
        AccountShipperPage.id: (BuildContext context) =>
            new AccountShipperPage(),
        AccountUserPage.id: (BuildContext context) => new AccountUserPage(),
        SettingPage.id: (BuildContext context) => new  SettingPage(),
        '/login' :(BuildContext context) => new  LoginPage(),
      },
    );
  }
}
