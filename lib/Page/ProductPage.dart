import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:webshop/Controller/Category_Controller.dart';
import 'package:webshop/Controller/Product_Controller.dart';
import 'package:webshop/Widget/ProductList_Widget.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';

class ProductPage extends StatelessWidget {
  static const id = '/product-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await categoryController.fetchCategory();
      await productController. fetchAllProduct();
    });
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, ProductPage.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Sản phẩm',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text('Quản lý thêm xóa cập nhật sản phẩm'),
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
                          title: 'Thêm sản phẩm',
                          titleStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          titlePadding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          content: Form(
                            key: productController.productKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: TextFormField(
                                      controller:
                                          productController.nameController,
                                      validator: (value) {
                                        return productController
                                            .validateName(value!);
                                      },
                                      onSaved: (value) {
                                        productController.name(value);
                                      },
                                      decoration: InputDecoration(
                                          label: Text(
                                            'Tên sản phẩm',
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          hintText: "Nhập tên sản phẩm",
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
                                  Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Thương hiệu',
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          DropdownButton<String>(
                                            value: categoryController.name1
                                                .toString(),
                                            onChanged: (String? newValue) {
                                              categoryController
                                                  .name1(newValue!);
                                            },
                                            items: categoryController.nameList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: TextFormField(
                                      controller:
                                          productController.imageController,
                                      validator: (value) {
                                        return productController
                                            .validateName(value!);
                                      },
                                      onSaved: (value) {
                                        productController.image(value);
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: TextFormField(
                                      inputFormatters: [],
                                      controller:
                                          productController.priceController,
                                      validator: (value) {
                                        return productController
                                            .validateName(value!);
                                      },
                                      onSaved: (value) {
                                        productController.price(int.parse(value.toString()));
                                      },
                                      decoration: InputDecoration(
                                          label: Text(
                                            'Giá sản phẩm',
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          hintText: "Nhập giá sản phẩm",
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: TextFormField(
                                      inputFormatters: [],
                                      controller:
                                          productController.desController,
                                      validator: (value) {
                                        return productController
                                            .validateName(value!);
                                      },
                                      onSaved: (value) {
                                        productController.des(value);
                                      },
                                      decoration: InputDecoration(
                                          label: Text(
                                            'Chi tiết sản phẩm',
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          hintText: "Nhập chi tiết sản phẩm",
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
                          ),
                          confirm: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                            ),
                            onPressed: () {
                              productController.nameController.clear();
                              productController.priceController.clear();
                              productController.desController.clear();
                              productController.imageController.clear();
                              Get.back();
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
                              if (productController.check()) {
                                productController
                                    .create(
                                        productController.name.value,
                                        categoryController.name1.value,
                                        productController.price.value,
                                        productController.des.value,
                                        productController.image.value)
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
                                            productController.fetchAllProduct();
                                          },
                                        );
                                        productController.nameController.clear();
                                        productController.priceController.clear();
                                        productController.desController.clear();
                                        productController.imageController.clear();
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
                                        productController.nameController.clear();
                                        productController.priceController.clear();
                                        productController.desController.clear();
                                        productController.imageController.clear();
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
                        'Thêm sản phẩm',
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
            ProductList(),
          ],
        ),
      ),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}
