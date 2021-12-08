import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
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
import 'package:webshop/Page/ProductPage.dart';
import 'package:webshop/Page/SettingPage.dart';
import 'package:webshop/Page/UserPage.dart';

class   SideBarWidget{
  sideBarMenus(context,selectedRoute){
    return SideBar(
      activeIconColor: Colors.redAccent,
      backgroundColor: Colors.white38,
      iconColor: Colors.green,
      textStyle: TextStyle(color: Colors.grey),
      activeTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent),
      items: const [
        MenuItem(
          title: 'Trang chính',
          route: HomePage.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Thương hiệu',
          route: CategoryPage.id,
          icon: Icons.category_outlined,
        ),
        MenuItem(
          title: 'Sản phẩm',
          route: ProductPage.id,
          icon: CupertinoIcons.cube_fill,
        ),
        MenuItem(
            title: 'Tài khoản',
            //  route: BannerPage.id,
            icon: CupertinoIcons.person_3_fill,
            children: [
              MenuItem(
                title: 'Tất cả tài khoản',
                route: UserPage.id,
                icon: CupertinoIcons.person_2_fill,
              ),
              MenuItem(
                title: 'Tài khoản người dùng',
                   route: AccountUserPage.id,
                icon: Icons.person,
              ),
              MenuItem(
                title: 'Tài khoản shipper',
                   route: AccountShipperPage.id,
                icon: Icons.run_circle_outlined,
              ),
              MenuItem(
                title: 'Tài khoản quản trị',
                    route: AccountAdminPage.id,
                icon: CupertinoIcons.wrench_fill,
              ),
            ]),
        MenuItem(
          title: 'Đơn hàng',
          icon: Icons.shopping_cart_outlined,
          children: [
            MenuItem(
              title: 'Đơn hàng cần xử lý',
              route: HandleOrderPage.id,
              icon: CupertinoIcons.arrow_2_circlepath,
            ),
            MenuItem(
              title: 'Đơn hàng đang giao',
              route: DeliveryOrderPage.id,
              icon: Icons.directions_run_rounded
            ),
            MenuItem(
                title: 'Đơn hàng đã nhận',
                route: AcceptedOrderPage.id,
                icon: CupertinoIcons.checkmark,
            ),
            MenuItem(
              title: 'Đơn hàng đã hủy',
              route: CancelOrderPage.id,
              icon: CupertinoIcons.clear,
            ),
          ],
        ),
        MenuItem(
          title: 'Quảng cáo',
          route: BannerPage.id,
          icon: CupertinoIcons.photo,
        ),
        MenuItem(
          title: 'Hệ thống',
          route: SettingPage.id,
          icon: CupertinoIcons.selection_pin_in_out,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xff444444),
        child: Center(
          child: Text(
            'Danh sách chức năng',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Color(0xff444444),
        child: Center(
          child: Text(
            'Flutter web',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}