import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webshop/Controller/HandleOrder_Controller.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:webshop/Controller/Shipper_Controller.dart';
class HandelOrderTable extends StatelessWidget {
  final scrollController = ScrollController(initialScrollOffset: 0);
  final HandleOrderController orderController = Get.put(HandleOrderController());
  final AccountShipperController accountShipperController = Get.put(AccountShipperController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await   orderController.fetchHandleOrder();
      await accountShipperController.fetchAccountShipper();
    });
    return Container(
      child: Obx(() {
        if (orderController .isLoading.value)
          return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)));
        else
          return Container(
            height: MediaQuery.of(context).size.height / 1.8,
            width:  MediaQuery.of(context).size.width /1.5,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Scrollbar(
                  controller: scrollController,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    child: DataTable(
                      showBottomBorder: true,
                      dataRowHeight: 100,
                      headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                      columns: [
                        DataColumn(
                            label: Text(
                              'Mã đơn hàng',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Ngày đặt và nhận',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Khách hàng',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Đơn hàng',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Tổng tiền',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Chức năng',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),

                      ],
                      rows:  orderController.handleOrderList
                          .map((data) => DataRow(cells: [
                        DataCell(
                          Text(
                            data.orderId.toString(),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ngày đặt: ${data.orderDate}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Họ và tên: ${data.username}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              Text(
                                "Số điện thoại: ${data.phone}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  "Địa chỉ: ${data.address}",
                                  style: GoogleFonts.spartan(
                                    textStyle: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(
                                data.productName.toString(),
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(data.imageUrl.toString(),fit: BoxFit.scaleDown,),
                                  ),
                                  Text(
                                    "${data.productSize}x${data.quantity}",
                                    style: GoogleFonts.spartan(
                                      textStyle: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Giá: ${data.productPrice.toVND(unit: 'VNĐ/SP')}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            data.totalPrice.toString().toVND(unit: 'VNĐ'),
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
                          Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'Giao đơn hàng cho nhân viên',
                                    titleStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    titlePadding:
                                    const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    content: Obx(
                                          () => DropdownButton<String>(
                                        value: accountShipperController.selectShipper.toString(),
                                        onChanged: (String? newValue) {
                                          accountShipperController.selectShipper(newValue!);
                                        },
                                        items: accountShipperController.nameShipperList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                      ),
                                    ),
                                    confirm: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<
                                            Color>(Colors.redAccent),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                        accountShipperController.selectShipper(accountShipperController.nameShipperList[0]);
                                      },
                                      child: Text(
                                        'Hủy bỏ',
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    cancel: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<
                                            Color>(Colors.green),
                                      ),
                                      onPressed: () {
                                        var id =  accountShipperController.selectShipper.value.split(':');
                                       orderController.shipOrder(int.parse(id[0]), data.orderId.toString())
                                            .then((value) {
                                          if (value == 1) {
                                            Get.back();
                                            CoolAlert.show(
                                              width: 50,
                                              backgroundColor: Colors.green,
                                              context: context,
                                              type: CoolAlertType.success,
                                              confirmBtnColor: Colors.green,
                                              text: "Giao cho nhân viên thành công",
                                              confirmBtnText: 'OK',
                                              onConfirmBtnTap: () {
                                                Get.back();
                                                orderController.fetchHandleOrder();
                                              },
                                            );
                                          } else {
                                            CoolAlert.show(
                                              width: 50,
                                              backgroundColor:
                                              Colors.redAccent,
                                              context: context,
                                              type: CoolAlertType.error,
                                              text: "Không thể giao cho nhanh viên",
                                              confirmBtnColor:
                                              Colors.redAccent,
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
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Giao hàng',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                ),
                                onPressed: () {
                                  orderController.deleteOrder(data.orderId.toString())
                                      .then((value) {
                                    if (value == 1) {
                                   //   Get.back();
                                      CoolAlert.show(
                                        width: 50,
                                        backgroundColor: Colors.green,
                                        context: context,
                                        type: CoolAlertType.success,
                                        confirmBtnColor: Colors.green,
                                        text: "Xóa đơn hàng thành công",
                                        confirmBtnText: 'OK',
                                        onConfirmBtnTap: () {
                                         Get.back();
                                         orderController.fetchHandleOrder();
                                  //        Get.toNamed("/HandelOrder-screen");
                                        },
                                      );
                                    } else {
                                      CoolAlert.show(
                                        width: 50,
                                        backgroundColor:
                                        Colors.redAccent,
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: "Xóa đơn hàng không thành công",
                                        confirmBtnColor:
                                        Colors.redAccent,
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
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )
                      ]))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          );
      }),
    );
  }
}
