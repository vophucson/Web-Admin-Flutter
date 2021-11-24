import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:webshop/Controller/ShipService_Controller.dart';
import 'package:webshop/Widget/ShipServiceTable_Widget.dart';
import 'package:webshop/Widget/SideBar_Widget.dart';

class ShipServicePage extends StatelessWidget {
  static const id = '/shipService-screen';
  final SideBarWidget _sideBar = SideBarWidget();
  final ShipServiceController serviceController = Get.put(ShipServiceController());
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
        backgroundColor: Colors.green,
      ),
      sideBar: _sideBar.sideBarMenus(context, ShipServicePage.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Dịch vụ giao hàng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Text('Quản lý thêm xóa cập nhật dịch vụ giao hàng'),
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
                          title: 'Thêm dịch vụ giao hàng',
                          titleStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          titlePadding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          content: Form(
                            key: serviceController.serviceKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  child: TextFormField(
                                    controller:
                                    serviceController.nameController,
                                    validator: (value) {
                                      return serviceController
                                          .validateName(value!);
                                    },
                                    onSaved: (value) {
                                      serviceController.name(value);
                                    },
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Tên dịch vụ',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        hintText: "Nhập tên dịch vụ",
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
                                    serviceController.timeController,
                                    validator: (value) {
                                      return serviceController
                                          .validateName(value!);
                                    },
                                    onSaved: (value) {
                                      serviceController.time(value);
                                    },
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Thời gian',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        hintText: "Nhập thời gian",
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
                                    controller:
                                    serviceController.priceController,
                                    validator: (value) {
                                      return serviceController
                                          .validateName(value!);
                                    },
                                    onSaved: (value) {
                                      serviceController.price(value);
                                    },
                                    decoration: InputDecoration(
                                        label: Text(
                                          'Giá dịch vụ',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                        hintText: "Nhập giá dịch vụ",
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
                             serviceController.nameController.clear();
                              serviceController.timeController.clear();
                              serviceController.priceController.clear();
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
                              if (serviceController.check()) {
                                serviceController.create(serviceController.name.value, serviceController.time.value, serviceController.price.value)
                                    .then((value) {
                                  if (value == 1) {
                                    Get.back();
                                    CoolAlert.show(
                                      width: 50,
                                      backgroundColor: Colors.green,
                                      context: context,
                                      type: CoolAlertType.success,
                                      confirmBtnColor: Colors.green,
                                      text: "Thêm dịch vụ thành công",
                                      confirmBtnText: 'OK',
                                      onConfirmBtnTap: () {

                                        Get.back();
                                        serviceController.fetchShipService();
                                      },
                                    );
                                    serviceController.nameController.clear();
                                    serviceController.timeController.clear();
                                    serviceController.priceController.clear();
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
                        'Thêm dịch vụ',
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
            SizedBox(height: 10,),
            ShipServiceTable(),
          ],
        ),
      ),
      //    body: _mapWidget['$selectedRoute'],
    );
  }
}
