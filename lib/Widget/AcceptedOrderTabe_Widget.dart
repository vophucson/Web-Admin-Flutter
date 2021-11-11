import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webshop/Controller/AcceptedOrder_Controller.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class AcceptedOrderTable extends StatelessWidget {
  final scrollController = ScrollController(initialScrollOffset: 0);
  final AcceptedOrderController orderController =
      Get.put(AcceptedOrderController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await orderController.fetchAcceptedOrder();
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
                          'Mã đơn hàng',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'Ngày đặt và nhận',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'Khách hàng',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'Nhân viên giao hàng',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'Đơn hàng',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'Dịch vụ giao hàng',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'Tổng tiền',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          'Tình trạng',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                      ],
                      rows: orderController.acceptedOrderList
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
                                        "Ngày đặt: ${data.orderDate}",
                                        style: GoogleFonts.spartan(
                                          textStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Ngày giao: ${data.expireDate}",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Họ và tên: ${data.shipperName}",
                                        style: GoogleFonts.spartan(
                                          textStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Số điện thoại: ${data.shipperPhone}",
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Dịch vụ: ${data.shipName}",
                                        style: GoogleFonts.spartan(
                                          textStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Thời gian: ${data.shipDay} ngày",
                                        style: GoogleFonts.spartan(
                                          textStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Giá: ${data.shipPrice.toVND(unit: 'VNĐ/ĐH')}",
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
                                        .toVND(unit: 'VNĐ'),
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
