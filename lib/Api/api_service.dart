import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:webshop/Config.dart';
import 'package:webshop/Model/banner_model.dart';
import 'package:webshop/Model/category_model.dart';
import 'package:webshop/Model/checkstore_model.dart';
import 'package:webshop/Model/handelorder_model.dart';
import 'package:webshop/Model/login_model.dart';
import 'package:webshop/Model/orderstatus_model.dart';
import 'package:webshop/Model/product_model.dart';
import 'package:webshop/Model/shipservice_model.dart';
import 'package:webshop/Model/truefalse_model.dart';
import 'package:webshop/Model/user_model.dart';

class ApiService {
  static var client = http.Client();
  static Future<LoginResponseModel> login(String email, String password) async {
    var url = Uri.parse(Config.url + Config.login);
    final response = await client.post(url, body: {
      "email": email.trim(),
      "password": password.trim(),
    }, headers: {});
    print(response.statusCode);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 401) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<CategoryModel> getCategory() async {
    var url = Uri.parse(Config.url + Config.category + Config.allCategory);
    final response = await client.get(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return CategoryModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<ProductModel> getProduct() async {
    var url = Uri.parse(Config.url + Config.product + Config.allProduct);
    final response = await client.get(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<UserModel> getUser(String token) async {
    var url = Uri.parse(Config.url + Config.user + Config.allUser);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<BannerModel> getBanner() async {
    var url = Uri.parse(Config.url + Config.banner + Config.allBanner);
    final response = await client.get(url);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return BannerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> createCategory(
      String categoryName, String categoryImage, String token) async {
    var url = Uri.parse(Config.url + Config.category + Config.createCategory);
    final body = {
      "categoryName": categoryName.trim(),
      "categoryImage": categoryImage.trim(),
    };
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.post(url, body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> deleteCategory(
      int categoryId, String token) async {
    var url = Uri.parse(
        Config.url + Config.category + Config.deleteCategory + '$categoryId');
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> updateCategory(String token, int categoryId,
      String categoryName, String categoryImage) async {
    var url = Uri.parse(Config.url + Config.category + Config.updateCategory);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final body = {
      'categoryId': categoryId,
      'categoryName': categoryName.trim(),
      'categoryImage': categoryImage.trim()
    };
    final response =
        await client.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> createBanner(
      String bannerName, String bannerImage, String token) async {
    var url = Uri.parse(Config.url + Config.banner + Config.createBanner);
    final body = {
      "content": bannerName.trim(),
      "bannerImage": bannerImage.trim(),
    };
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.post(url, body: body, headers: headers);
    if (response.statusCode == 201 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> deleteBanner(int bannerId, String token) async {
    var url = Uri.parse(
        Config.url + Config.banner + Config.deleteBanner + '$bannerId');
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> updateBanner(
      String token, int bannerId, String bannerName, String bannerImage) async {
    var url = Uri.parse(Config.url + Config.banner + Config.updateBanner);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final body = {
      'bannerId': bannerId,
      'content': bannerName.trim(),
      'bannerImage': bannerImage.trim()
    };
    final response =
        await client.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> createProduct(
      String productName,
      String categoryName,
      int productPrice,
      String description,
      String imageUrl,
      String token) async {
    var url = Uri.parse(Config.url + Config.product + Config.createProduct);
    final body = {
      "productName": productName.trim(),
      "categoryName": categoryName.trim(),
      "productPrice": "$productPrice",
      "description": description.trim(),
      "imageUrl": imageUrl.trim()
    };
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.post(url, body: body, headers: headers);
    if (response.statusCode == 201 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> deleteProduct(
      int productId, String token) async {
    var url = Uri.parse(
        Config.url + Config.product + Config.deleteProduct + '$productId');
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> updateProduct(
      String token,
      String productName,
      int productPrice,
      int productId,
      String description,
      String imageUrl,
      String categoryName) async {
    var url = Uri.parse(Config.url + Config.product + Config.updateProduct);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final body = {
      "productName": productName,
      "productPrice": "$productPrice",
      "productId": "$productId",
      "description": description,
      "imageUrl": imageUrl,
      "categoryName": categoryName
    };
    print(body);
    final response =
        await client.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<CheckStoreModel> checkQuantity(
      int productId, String token) async {
    var url = Uri.parse(
        Config.url + Config.storeHouse + Config.checkQuantity + '$productId');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return CheckStoreModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> updateQuantity(
      String token, int productId, double productSize, int quantity) async {
    var url = Uri.parse(Config.url + Config.storeHouse + Config.updateQuantity);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final body = {
      'productId': productId,
      'productSize': productSize,
      'quantity': quantity,
    };
    final response =
        await client.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<TrueFalseModel> setRole(
      int id, String role, String token) async {
    var url = Uri.parse(Config.url + Config.user + Config.setRole);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final body = {"Id": id, "role": role};
    print(body);
    final response =
        await client.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<ShipServiceModel> getShipService() async {
    var url = Uri.parse(Config.url + Config.shipService + Config.allShipService);
    final response = await client.get(url);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return ShipServiceModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<HandelOrderModel> getHandleOrder( String token) async {
    var url = Uri.parse(
        Config.url + Config.order + Config.handleOrder);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return HandelOrderModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<OrderStatusModel> getDeliveryOrder( String token) async {
    var url = Uri.parse(
        Config.url + Config.order + Config.deliveryOrder);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return OrderStatusModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<OrderStatusModel> getAcceptedOrder( String token) async {
    var url = Uri.parse(
        Config.url + Config.order + Config.acceptedOrder);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return OrderStatusModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<OrderStatusModel> getCancelOrder( String token) async {
    var url = Uri.parse(
        Config.url + Config.order + Config.cancelOrder);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return OrderStatusModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<UserModel> getAccountShipper( String token) async {
    var url = Uri.parse(
        Config.url + Config.shipper + Config.allShipper);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<UserModel> getAccountUser( String token) async {
    var url = Uri.parse(
        Config.url + Config.user + Config.allAccountUser);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<UserModel> getAccountAdmin( String token) async {
    var url = Uri.parse(
        Config.url + Config.user + Config.allAccountAdmin);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json", // or whateverz
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.get(url, headers: headers);
    print(url);
    if (response.statusCode == 200 || response.statusCode == 401) {
      print(response.statusCode);
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<TrueFalseModel> createService(
      String shipName, String shipDay,String shipPrice, String token) async {
    var url = Uri.parse(Config.url + Config.shipService + Config.createService);
    final body = {
      "shipName": shipName.trim(),
      "shipDay": shipDay.trim(),
      "ShipPrice":shipPrice.trim(),
    };
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.post(url, body: body, headers: headers);
    if (response.statusCode == 201 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<TrueFalseModel> deleteService(
      int shipServiceId, String token) async {
    var url = Uri.parse(
        Config.url + Config.shipService + Config.deleteService + '$shipServiceId');
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final response = await client.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<TrueFalseModel> updateService(String token, int shipServiceId,
      String shipName, String shipDay,String shipPrice) async {
    var url = Uri.parse(Config.url + Config.shipService + Config.updateService);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final body = {
      "Id":shipServiceId,
      "shipName": shipName.trim(),
      "shipDay": shipDay.trim(),
      "ShipPrice": shipPrice.trim()
    };
    final response =
    await client.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<TrueFalseModel> shipOrder(String token,int shipperId,String orderId) async {
    var url = Uri.parse(Config.url + Config.order + Config.shipOrder);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final body = {
      "shipperId": shipperId,
      "orderId": orderId
    };
    final response =
    await client.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
  static Future<TrueFalseModel> deleteOrder(String token,String orderId) async {
    var url = Uri.parse(Config.url + Config.order + Config.deleteOrder + orderId);
    print(url);
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json", //
    };
    final response =
    await client.delete(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return TrueFalseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

}
