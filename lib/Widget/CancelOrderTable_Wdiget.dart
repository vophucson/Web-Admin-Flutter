import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:webshop/Controller/CancelOrder_Controller.dart';

class CancelOrderTable extends StatelessWidget {
  final scrollController = ScrollController(initialScrollOffset: 0);
  final CancelOrderController orderController =
  Get.put(CancelOrderController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await orderController.fetchCancelOrder();
    });
    return Container(
      child: Obx(() {
        if (orderController.isLoading.value)
          return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)));
        else
          return Container(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width / 1.5,
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
                      headingRowColor:
                      MaterialStateProperty.all(Colors.grey[200]),
                      columns: [
                        DataColumn(
                            label: Text(
                              'M?? ????n h??ng',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Ng??y ?????t v?? nh???n',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Kh??ch h??ng',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'Nh??n vi??n giao h??ng',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              '????n h??ng',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'T???ng ti???n',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        DataColumn(
                            label: Text(
                              'T??nh tr???ng',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                      ],
                      rows: orderController.cancelOrderList
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                              ),
                              Text(
                                "Ng??y giao: ${data.expireDate}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "H??? v?? t??n: ${data.shipperName}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              Text(
                                "S??? ??i???n tho???i: ${data.shipperPhone}",
                                style: GoogleFonts.spartan(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
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
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                      data.imageUrl.toString(),
                                      fit: BoxFit.scaleDown,
                                    ),
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
                            data.totalPrice
                                .toString()
                                .toVND(unit: 'VN??'),
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
                          Text(
                            "${data.status}",
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                        ),
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
