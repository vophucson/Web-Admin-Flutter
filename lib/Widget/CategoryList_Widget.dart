import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webshop/Controller/Category_Controller.dart';

class CategoryList extends StatelessWidget {
  final scrollController = ScrollController(initialScrollOffset: 0);
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await   categoryController.fetchCategory();
    });
    return Obx(() {
      if (categoryController.isLoading.value)
        return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green)));
      else
        return Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Scrollbar(
            isAlwaysShown:
                categoryController.categoryList.length > 10 ? true : false,
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
                  itemCount: categoryController.categoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    var data = categoryController.categoryList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          width: 150,
                          height: 150,
                          alignment: Alignment.center,
                          child: Image(
                            image: NetworkImage(data.categoryImage.toString()),
                            fit: BoxFit.scaleDown,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 5),
                                    blurRadius: 15)
                              ]),
                        ),
                        Text(
                          '${data.categoryName}',
                          style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
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
                               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                             ),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Cập nhật thương hiệu',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 20),
                                  content: Form(
                                    key: categoryController.editKey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                          child: TextFormField(
                                            initialValue: '${data.categoryName}',
                                            onSaved: (value) {
                                              if (value!.length > 0) {
                                                categoryController
                                                    .nameEdit(value);
                                              } else {
                                                categoryController.nameEdit(
                                                    data.categoryName);
                                              }
                                            },
                                            decoration: InputDecoration(
                                                label: Text(
                                                  'Tên thương hiệu',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                                hintText:
                                                    "${data.categoryName}",
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
                                            initialValue: '${data.categoryImage}',
                                            onSaved: (value) {
                                              if (value!.length > 0) {
                                                categoryController
                                                    .imageEdit(value);
                                              } else {
                                                categoryController.imageEdit(
                                                    data.categoryImage);
                                              }
                                            },
                                            decoration: InputDecoration(
                                                label: Text(
                                                  'Hình ảnh(URL)',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                                hintText:
                                                    "${data.categoryImage}",
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
                                      categoryController.save();
                                      categoryController
                                          .updateCategory(
                                              data.categoryId!,
                                              categoryController.nameEdit.value,
                                              categoryController
                                                  .imageEdit.value)
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
                                              categoryController
                                                  .fetchCategory();
                                            },
                                          );
                                          categoryController.nameEdit('');
                                          categoryController.imageEdit('');
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
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                              ),
                              onPressed: () {
                                categoryController
                                    .delete(data.categoryId!)
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
                                        categoryController.fetchCategory();
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
                    );
                  }),
            ),
          ),
        );
    });
  }
}
