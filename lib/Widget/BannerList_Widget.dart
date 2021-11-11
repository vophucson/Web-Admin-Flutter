import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webshop/Controller/Banner_Controller.dart';

class BannerList extends StatelessWidget {
  final scrollController = ScrollController(initialScrollOffset: 0);
  final BannerController bannerController = Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await bannerController.fetchBanner();
    });
    return Obx(() {
      if (bannerController.isLoading.value)
        return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green)));
      else
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Scrollbar(
          isAlwaysShown: true,
          controller: scrollController,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: bannerController.bannerList.length,
                itemBuilder: (context, index) {
                  var data =  bannerController.bannerList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(children: [
                          SizedBox(
                              height: 200,
                              child: Card(
                                elevation: 10,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(data.bannerImage.toString(),
                                    fit: BoxFit.fill,
                                   ),
                                ),
                              )),
                        ]),
                        Text(
                          '${data.content}',
                          style: GoogleFonts.spartan(
                            textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
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
                                  title: 'Cập nhật quảng cáo',
                                  titleStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  titlePadding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 20),
                                  content: Form(
                                    key: bannerController.editBannerKey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                          child: TextFormField(
                                            initialValue: "${data.content}",
                                            onSaved: (value) {
                                              if (value!.length > 0) {
                                                bannerController
                                                    .nameEdit(value);
                                              } else {
                                                bannerController.nameEdit(
                                                    data.content);
                                              }
                                            },
                                            decoration: InputDecoration(
                                                label: Text(
                                                  'Nội dung quảng cáo',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                                hintText:
                                                "${data.content}",
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
                                            initialValue: "${data.bannerImage}",
                                            onSaved: (value) {
                                              if (value!.length > 0) {
                                                bannerController
                                                    .imageEdit(value);
                                              } else {
                                                bannerController.imageEdit(
                                                    data.bannerImage);
                                              }
                                            },
                                            decoration: InputDecoration(
                                                label: Text(
                                                  'Hình ảnh(URL)',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                                hintText:
                                                "${data.bannerImage}",
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
                                      bannerController.save();
                                      bannerController
                                          .updateBanner(
                                          data.bannerId!,
                                          bannerController.nameEdit.value,
                                          bannerController
                                              .imageEdit.value)
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
                                              bannerController.fetchBanner();
                                            },
                                          );
                                          bannerController.nameEdit('');
                                          bannerController.imageEdit('');
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
                                bannerController
                                    .delete(data.bannerId!)
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
                                       bannerController.fetchBanner();
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
                  );
                }),
          ),
        ),
      );
    });
  }
}
