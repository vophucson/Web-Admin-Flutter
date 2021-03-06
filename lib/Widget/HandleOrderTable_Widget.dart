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
                              'M?? ????n h??ng',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Ng??y ?????t v?? nh???n',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Kh??ch h??ng',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              '????n h??ng',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'T???ng ti???n',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Ch???c n??ng',
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
                                "Ng??y ?????t: ${data.orderDate}",
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
                                "H??? v?? t??n: ${data.username}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              Text(
                                "S??? ??i???n tho???i: ${data.phone}",
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
                                  "?????a ch???: ${data.address}",
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
                                "Gi??: ${data.productPrice.toVND(unit: 'VN??/SP')}",
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
                            data.totalPrice.toString().toVND(unit: 'VN??'),
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
                                    title: 'Giao ????n h??ng cho nh??n vi??n',
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
                                        'H???y b???',
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
                                              text: "Giao cho nh??n vi??n th??nh c??ng",
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
                                              text: "Kh??ng th??? giao cho nhanh vi??n",
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
                                        'X??c nh???n',
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Giao h??ng',
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
                                        text: "X??a ????n h??ng th??nh c??ng",
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
                                        text: "X??a ????n h??ng kh??ng th??nh c??ng",
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
                                  'X??a',
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
