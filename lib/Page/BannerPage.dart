import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:webshop/Controller/Banner_Controller.dart';
import 'package:webshop/Widget/BannerList_Widget.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';

class BannerPage extends StatelessWidget {
  static const id = '/banner-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  final BannerController bannerController = Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, BannerPage.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Quảng cáo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text('Quản lý thêm xóa cập nhật quảng cáo'),
            Divider(
              thickness: 5,
            ),
            Container(
              color: Colors.grey[200],
              height: 50,
              child:  Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Thêm thương hiệu',
                          titleStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          titlePadding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          content: Form(
                            key: bannerController.bannerKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  child: TextFormField(
                                    controller:
                                    bannerController.nameController,
                                    validator: (value) {
                                      return bannerController
                                          .validateName(value!);
                                    },
                                    onSaved: (value) {
                                    bannerController.name(value);
                                    },
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Nội dung quảng cáo',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        hintText: "Nhập nội dung quảng cáo",
                                        focusColor:
                                        Theme.of(context).primaryColor,
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  child: TextFormField(
                                    controller:
                                    bannerController.imageController,
                                    validator: (value) {
                                      return bannerController
                                          .validateName(value!);
                                    },
                                    onSaved: (value) {
                                      bannerController.image(value);
                                    },
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Hình ảnh',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        hintText: "Nhập Hình ảnh(URL)",
                                        focusColor:
                                        Theme.of(context).primaryColor,
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          confirm: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                            ),
                            onPressed: () {
                              Get.back();
                              bannerController.nameController.clear();
                             bannerController.imageController.clear();
                            },
                            child: Text(
                              'Hủy bỏ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          cancel: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              if (bannerController.check()) {
                                bannerController
                                    .create(bannerController.name.value,
                                    bannerController.image.value)
                                    .then((value) {
                                  if (value == 1) {
                                    CoolAlert.show(
                                      width: 50,
                                      backgroundColor: Colors.green,
                                      context: context,
                                      type: CoolAlertType.success,
                                      confirmBtnColor: Colors.green,
                                      text: "Thêm thương hiệu thành công",
                                      confirmBtnText: 'OK',
                                      onConfirmBtnTap: () {
                                        Get.back();
                                        Get.back();
                                        bannerController.fetchBanner();
                                      },
                                    );
                                    bannerController.nameController.clear();
                                    bannerController.imageController.clear();
                                  } else {
                                    CoolAlert.show(
                                      width: 50,
                                      backgroundColor: Colors.redAccent,
                                      context: context,
                                      type: CoolAlertType.error,
                                      text: "Không thể thêm",
                                      confirmBtnColor: Colors.redAccent,
                                      confirmBtnText: 'OK',
                                      onConfirmBtnTap: () {
                                        Get.back();
                                        Get.back();
                                      },
                                    );
                                  }
                                });
                              }
                            },
                            child: Text(
                              'Xác nhận',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Thêm quảng cáo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: 10,
            ),
            BannerList(),
            Divider(
              thickness: 5,
            ),
          ],
        ),
      ),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}
