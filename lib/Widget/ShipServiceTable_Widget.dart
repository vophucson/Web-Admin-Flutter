import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webshop/Controller/ShipService_Controller.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
class ShipServiceTable extends StatelessWidget {
  final ShipServiceController serviceController = Get.put(ShipServiceController());
  final scrollController = ScrollController(initialScrollOffset: 0);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await   serviceController.fetchShipService();
    });
    return Container(
      child: Obx(() {
        if (serviceController .isLoading.value)
          return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)));
        else
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            width:  MediaQuery.of(context).size.width / 1.5,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: scrollController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: scrollController,
                  child: DataTable(
                    showBottomBorder: true,
                    dataRowHeight: 50,
                    headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                    columns: [
                      DataColumn(
                          label: Text(
                            'Mã dịch vụ',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          )),
                      DataColumn(
                          label: Text(
                            'Tên dịch vụ',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          )),
                      DataColumn(
                          label: Text(
                            'Thời gian giao hàng',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          )),
                      DataColumn(
                          label: Text(
                            'Mức giá dịch vụ',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          )),
                      DataColumn(
                          label: Text(
                            'Chức năng',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          )),

                    ],
                    rows: serviceController.serviceList
                        .map((data) => DataRow(cells: [
                      DataCell(
                        Text(
                          data.id.toString(),
                          style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          data.shipName.toString(),
                          style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          "${data.shipDay} Ngày",
                          style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          "${data.shipPrice.toVND(unit: 'VNĐ/ĐH')}",
                          style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  ),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: 'Cập nhật dịch vụ giao hàng',
                                      titleStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      titlePadding: const EdgeInsets.symmetric(
                                          vertical: 30, horizontal: 20),
                                      content: Form(
                                        key: serviceController.editServiceKey,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 20),
                                              child: TextFormField(
                                                initialValue: '${data.shipName}',
                                                onSaved: (value) {
                                                  if (value!.length > 0) {
                                                    serviceController
                                                        .nameEdit(value);
                                                  } else {
                                                    serviceController.nameEdit(
                                                        data.shipName);
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    label: Text(
                                                      'Tên dịch vụ',
                                                      style: TextStyle(
                                                          color: Colors.redAccent),
                                                    ),
                                                    focusColor: Theme.of(context)
                                                        .primaryColor,
                                                    contentPadding: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    border: OutlineInputBorder(),
                                                    focusedBorder:
                                                    OutlineInputBorder(
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
                                                initialValue: '${data.shipDay}',
                                                onSaved: (value) {
                                                  if (value!.length > 0) {
                                                    serviceController.timeEdit(value);
                                                  } else {
                                                    serviceController.timeEdit(
                                                        data.shipDay.toString());
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    label: Text(
                                                      'Thời gian',
                                                      style: TextStyle(
                                                          color: Colors.redAccent),
                                                    ),
                                                    focusColor: Theme.of(context)
                                                        .primaryColor,
                                                    contentPadding: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    border: OutlineInputBorder(),
                                                    focusedBorder:
                                                    OutlineInputBorder(
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
                                                initialValue: '${data.shipPrice}',
                                                onSaved: (value) {
                                                  if (value!.length > 0) {
                                                    serviceController.priceEdit(value);
                                                  } else {
                                                    serviceController.priceEdit(
                                                        data.shipDay.toString());
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    label: Text(
                                                      'Giá dịch vụ',
                                                      style: TextStyle(
                                                          color: Colors.redAccent),
                                                    ),
                                                    focusColor: Theme.of(context)
                                                        .primaryColor,
                                                    contentPadding: EdgeInsets.only(
                                                        left: 20, right: 20),
                                                    border: OutlineInputBorder(),
                                                    focusedBorder:
                                                    OutlineInputBorder(
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
                                          Get.back();
                                          serviceController.save();
                                          serviceController.updateService(data.id!, serviceController.nameEdit.value, serviceController.timeEdit.value, serviceController.priceEdit.value)
                                              .then((value) {
                                            if (value == 1) {
                                              CoolAlert.show(
                                                width: 50,
                                                backgroundColor: Colors.green,
                                                context: context,
                                                type: CoolAlertType.success,
                                                confirmBtnColor: Colors.green,
                                                text: "Cập nhật thành công",
                                                confirmBtnText: 'OK',
                                                onConfirmBtnTap: () {
                                                  Get.back();
                                                  serviceController.fetchShipService();
                                                },
                                              );
                                            } else {
                                              Get.back();
                                              CoolAlert.show(
                                                width: 50,
                                                backgroundColor: Colors.redAccent,
                                                context: context,
                                                type: CoolAlertType.error,
                                                text: "Không thể cập nhật",
                                                confirmBtnColor: Colors.redAccent,
                                                confirmBtnText: 'OK',
                                                onConfirmBtnTap: () {
                                                  Get.back();
                                                },
                                              );
                                            }
                                          });
                                        },
                                        child: Text(
                                          'Xác nhận',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sửa',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                  ),
                                  onPressed: () {
                                   serviceController
                                        .delete(data.id!)
                                        .then((value) {
                                      if (value == 1) {
                                        CoolAlert.show(
                                          width: 50,
                                          backgroundColor: Colors.green,
                                          context: context,
                                          type: CoolAlertType.success,
                                          confirmBtnColor: Colors.green,
                                          text: "Xóa thành công",
                                          confirmBtnText: 'OK',
                                          onConfirmBtnTap: () {
                                            Get.back();
                                            serviceController.fetchShipService();
                                          },
                                        );
                                      } else {
                                        CoolAlert.show(
                                          width: 50,
                                          backgroundColor: Colors.redAccent,
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: "Không thể Xóa",
                                          confirmBtnColor: Colors.redAccent,
                                          confirmBtnText: 'OK',
                                          onConfirmBtnTap: () {
                                            Get.back();
                                          },
                                        );
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Xóa',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]))
                        .toList(),
                  ),
                ),
              ),
            ),
          );
      }),
    );
  }
}
