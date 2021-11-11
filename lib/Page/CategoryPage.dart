import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webshop/Controller/Category_Controller.dart';
import 'package:webshop/Widget/CategoryList_Widget.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';

class CategoryPage extends StatelessWidget {
  static const id = '/category-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, CategoryPage.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Thương hiệu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text('Quản lý thêm xóa  cập nhật thương hiệu'),
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
                            key: categoryController.categoryKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  child: TextFormField(
                                    controller:
                                        categoryController.nameController,
                                    validator: (value) {
                                      return categoryController
                                          .validateName(value!);
                                    },
                                    onSaved: (value) {
                                      categoryController.name(value);
                                    },
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Tên thương hiệu',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        hintText: "Nhập tên thương hiệu",
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
                                        categoryController.imageController,
                                    validator: (value) {
                                      return categoryController
                                          .validateName(value!);
                                    },
                                    onSaved: (value) {
                                      categoryController.image(value);
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
                              categoryController.nameController.clear();
                              categoryController.imageController.clear();
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
                              if (categoryController.check()) {
                                categoryController
                                    .create(categoryController.name.value,
                                        categoryController.image.value)
                                    .then((value) {
                                  if (value == 1) {
                                    Get.back();
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
                                        categoryController.fetchCategory();
                                      },
                                    );
                                    categoryController.nameController.clear();
                                    categoryController.imageController.clear();
                                  } else {
                                    Get.back();
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
                        'Thêm thương hiệu',
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
            CategoryList(),
          ],
        ),
      ),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}
