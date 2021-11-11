import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webshop/Controller/Category_Controller.dart';
import 'package:webshop/Controller/Product_Controller.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:webshop/Controller/Storehouse_Controller.dart';
class ProductList extends StatelessWidget {
  final scrollController = ScrollController(initialScrollOffset: 0);
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());
 final StoreHouseController storeHouseController = Get.put(StoreHouseController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.isLoading.value)
        return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green)));
      else
        return Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Scrollbar(
            isAlwaysShown: true,
            controller: scrollController,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: GridView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: productController.productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    var data = productController.productList[index];
                    return Card(
                      color: Colors.white30,
                      elevation: 0,
                      margin: EdgeInsets.only(right: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 8),
                        child: Column(
                          children: [
                            Container(
                              width: 180,
                              height: 140,
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(
                                top: 12,
                                right: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: NetworkImage(data.imageUrl.toString()),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${data.categoryName}",
                              style: GoogleFonts.spartan(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 120,
                              child: Center(
                                child: Text(
                                  '${data.productName}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.spartan(
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Giá: ${data.productPrice.toVND(unit: 'VNĐ')}",
                              style: GoogleFonts.spartan(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                                  ),
                                  onPressed: () {
                                    Future.delayed(Duration.zero, () async {
                                      await storeHouseController
                                          .fetchQuantity(data.productId!);
                                      showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) =>
                                            bottomSheet(context,data.productId!)),
                                      );
                                    });
                                  },
                                  child: Text(
                                    'Kho',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  ),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: 'Cập nhật sản phẩm',
                                      titleStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      titlePadding: const EdgeInsets.symmetric(
                                          vertical: 30, horizontal: 20),
                                      content: Form(
                                        key: productController.editProductKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                child: TextFormField(
                                                  initialValue:
                                                      "${data.productName}",
                                                  onSaved: (value) {
                                                    if (value!.length > 0) {
                                                      productController
                                                          .nameEdit(value);
                                                    } else {
                                                      productController
                                                          .nameEdit(
                                                              data.productName);
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      label: Text(
                                                        'Tên sản phẩm',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      hintText:
                                                          "${data.productName}",
                                                      focusColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            width: 2),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Thương hiệu',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Obx(
                                                      () => DropdownButton<
                                                          String>(
                                                        value: productController
                                                                    .categoryEdit
                                                                    .value ==
                                                                ''
                                                            ? data.categoryName
                                                            : productController
                                                                .categoryEdit
                                                                .toString(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          productController
                                                              .categoryEdit(
                                                                  newValue!);
                                                        },
                                                        items: categoryController
                                                            .nameList
                                                            .map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                child: TextFormField(
                                                  initialValue:
                                                      "${data.imageUrl}",
                                                  onSaved: (value) {
                                                    if (value!.length > 0) {
                                                      productController
                                                          .imageEdit(value);
                                                    } else {
                                                      productController
                                                          .imageEdit(
                                                              data.imageUrl);
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      label: Text(
                                                        'Hình ảnh',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      hintText:
                                                          "${data.imageUrl}",
                                                      focusColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            width: 2),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                child: TextFormField(
                                                  initialValue:
                                                      "${data.productPrice}",
                                                  onSaved: (value) {
                                                    if (value!.length > 0) {
                                                      productController
                                                          .priceEdit(int.parse(
                                                              value
                                                                  .toString()));
                                                    } else {
                                                      productController
                                                          .priceEdit(data
                                                              .productPrice);
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      label: Text(
                                                        'Giá sản phẩm',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      hintText:
                                                          "${data.productPrice}",
                                                      focusColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            width: 2),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                child: TextFormField(
                                                  textAlignVertical: TextAlignVertical.bottom,
                                                  maxLines: 10,
                                                  minLines: 5,
                                                  initialValue:
                                                      "${data.description}",
                                                  onSaved: (value) {
                                                    if (value!.length > 0) {
                                                      productController
                                                          .desEdit(value);
                                                    } else {
                                                      productController.desEdit(
                                                          data.description);
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      label: Text(
                                                        'Chi tiết sản phẩm',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                      hintText:
                                                          "${data.description}",
                                                      focusColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 20,
                                                              right: 20,top: 20),
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Theme.of(
                                                                    context)
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
                                          productController
                                              .categoryEdit(data.categoryName);
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
                                          productController.save();
                                          if (productController
                                                  .categoryEdit.value ==
                                              '') {
                                            productController.categoryEdit(
                                                data.categoryName);
                                          }
                                          productController
                                              .updateProduct(
                                                  productController
                                                      .nameEdit.value,
                                                  productController
                                                      .priceEdit.value,
                                                  data.productId!,
                                                  productController
                                                      .desEdit.value,
                                                  productController
                                                      .imageEdit.value,
                                                  productController
                                                      .categoryEdit.value)
                                              .then((value) {
                                            if (value == 1) {
                                              Get.back();
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
                                                  productController
                                                      .fetchAllProduct();
                                                },
                                              );
                                              productController.nameEdit('');
                                              productController.priceEdit(0);
                                              productController.desEdit('');
                                              productController.imageEdit('');
                                            } else {
                                              Get.back();
                                              CoolAlert.show(
                                                width: 50,
                                                backgroundColor:
                                                    Colors.redAccent,
                                                context: context,
                                                type: CoolAlertType.error,
                                                text: "Không thể cập nhật",
                                                confirmBtnColor:
                                                    Colors.redAccent,
                                                confirmBtnText: 'OK',
                                                onConfirmBtnTap: () {
                                                  Get.back();
                                                },
                                              );
                                              productController.categoryEdit(
                                                  data.categoryName);
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
                                SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    productController
                                        .delete(data.productId!)
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
                                            productController.fetchAllProduct();
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
                    );
                  }),
            ),
          ),
        );
    });
  }

  Widget bottomSheet(BuildContext context,int productId) {
    return Obx(()
      => Container(
        height: MediaQuery.of(context).size.height / 2,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              "Xem và cập nhật kho hàng",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            SizedBox(
              height: 40,
            ),
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showBottomBorder: true,
                  dataRowHeight: 80,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                  columns: [
                    DataColumn(
                        label: Text(
                      'Kích thước 36.0',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 36.5',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 37.0',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 37.5',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 38.0',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 38.5',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 39.0',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 39.5',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 40.0',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 40.5',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 41.0',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 41.5',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 42.0',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 42.5',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      'Kích thước 43',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                  ],
                  rows: storeHouseController.quantityList
                      .map((data) => DataRow(cells: [
                            DataCell(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Số lượng: ${data.i36} Đôi",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.spartan(
                                      textStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                 ElevatedButton(
                                   style: ButtonStyle(
                                     backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                   ),
                                    onPressed: () {
                                      Get.defaultDialog(
                                          title: 'Cập nhật số lượng',
                                          titleStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          titlePadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 30, horizontal: 30),
                                          content: Form(
                                            key: storeHouseController
                                                .editQuantityKey,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 70),
                                              child: TextFormField(
                                                initialValue: "${data.i36}",
                                                onSaved: (value) {
                                                  if (value!.length > 0) {
                                                    storeHouseController.editQuantity(int.parse(value.toString()));
                                                  } else {
                                                    storeHouseController.editQuantity(data.i36);
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    label: Text(
                                                      'Nhập số lượng',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                    focusColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    border:
                                                        OutlineInputBorder(),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          width: 2),
                                                    )),
                                              ),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cancel: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                            ),
                                            onPressed: () {
                                              storeHouseController.save();
                                              storeHouseController.updateQuantity(productId, 36.0, storeHouseController.editQuantity.value)
                                                  .then((value) {
                                                if (value == 1) {
                                                  storeHouseController.fetchQuantity(productId);
                                                  Get.back();
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

                                                    },
                                                  );
                                                } else {
                                                  Get.back();
                                                  CoolAlert.show(
                                                    width: 50,
                                                    backgroundColor:
                                                    Colors.redAccent,
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    text: "Không thể cập nhật",
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      'Cập nhật',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i365} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i365}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i365);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 36.5, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i37} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i37}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i37);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 37.0, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i375} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                         ElevatedButton(
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                           ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i375}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i375);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 37.5, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i38} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i38}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i38);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 38.0, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i385} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i385}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i385);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 38.5, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i39} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i39}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i39);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 39.0, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i395} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i395}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i395);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
                                    ),
                                  ),
                                  confirm:ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Hủy bỏ',
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 39.5, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i40} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i40}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i40);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 40.0, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i405} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i405}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i405);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
                                    ),
                                  ),
                                  confirm:ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Hủy bỏ',
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 40.5, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i41} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                         ElevatedButton(
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                           ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i41}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i41);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 41.0, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i415} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i415}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i415);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 41.5, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i42} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i42}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i42);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
                                    ),
                                  ),
                                  confirm:ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Hủy bỏ',
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 42.0, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i425} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i425}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i425);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 42.5, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Số lượng: ${data.i43} Đôi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spartan(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Cập nhật số lượng',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 30),
                                  content: Form(
                                    key: storeHouseController
                                        .editQuantityKey,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 70),
                                      child: TextFormField(
                                        initialValue: "${data.i43}",
                                        onSaved: (value) {
                                          if (value!.length > 0) {
                                            storeHouseController.editQuantity(int.parse(value.toString()));
                                          } else {
                                            storeHouseController.editQuantity(data.i43);
                                          }
                                        },
                                        decoration: InputDecoration(
                                            label: Text(
                                              'Nhập số lượng',
                                              style: TextStyle(
                                                  color:
                                                  Colors.redAccent),
                                            ),
                                            focusColor:
                                            Theme.of(context)
                                                .primaryColor,
                                            contentPadding:
                                            EdgeInsets.only(
                                                left: 20,
                                                right: 20),
                                            border:
                                            OutlineInputBorder(),
                                            focusedBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  width: 2),
                                            )),
                                      ),
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  cancel: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ),
                                    onPressed: () {
                                      storeHouseController.save();
                                      storeHouseController.updateQuantity(productId, 43.0, storeHouseController.editQuantity.value)
                                          .then((value) {
                                        if (value == 1) {
                                          storeHouseController.fetchQuantity(productId);
                                          Get.back();
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

                                            },
                                          );
                                        } else {
                                          Get.back();
                                          CoolAlert.show(
                                            width: 50,
                                            backgroundColor:
                                            Colors.redAccent,
                                            context: context,
                                            type: CoolAlertType.error,
                                            text: "Không thể cập nhật",
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
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ));
                            },
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                          ]))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
