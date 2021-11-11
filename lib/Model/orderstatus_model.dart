class OrderStatusModel {
  int? success;
  List<Data>? data;

  OrderStatusModel({this.success, this.data});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? orderId;
  String? username;
  String? address;
  String? phone;
  String? orderDate;
  String? expireDate;
  int? totalPrice;
  String? productName;
  String? imageUrl;
  dynamic productSize;
  int? quantity;
  int? productPrice;
  String? shipName;
  int? shipPrice;
  int? shipDay;
  String? shipperName;
  String? shipperPhone;
  String? status;
  Data(
      {this.orderId,
        this.username,
        this.address,
        this.phone,
        this.orderDate,
        this.expireDate,
        this.totalPrice,
        this.productName,
        this.imageUrl,
        this.productSize,
        this.quantity,
        this.productPrice,
        this.shipName,
        this.shipPrice,
        this.shipDay,
        this.shipperName,
        this.shipperPhone,this.status});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    username = json['username'];
    address = json['address'];
    phone = json['phone'];
    orderDate = json['orderDate'];
    expireDate = json['expireDate'];
    totalPrice = json['totalPrice'];
    productName = json['productName'];
    imageUrl = json['imageUrl'];
    productSize = json['productSize'];
    quantity = json['quantity'];
    productPrice = json['productPrice'];
    shipName = json['shipName'];
    shipPrice = json['ShipPrice'];
    shipDay = json['shipDay'];
    shipperName = json['shipperName'];
    shipperPhone = json['shipperPhone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['username'] = this.username;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['orderDate'] = this.orderDate;
    data['expireDate'] = this.expireDate;
    data['totalPrice'] = this.totalPrice;
    data['productName'] = this.productName;
    data['imageUrl'] = this.imageUrl;
    data['productSize'] = this.productSize;
    data['quantity'] = this.quantity;
    data['productPrice'] = this.productPrice;
    data['shipName'] = this.shipName;
    data['ShipPrice'] = this.shipPrice;
    data['shipDay'] = this.shipDay;
    data['shipperName'] = this.shipperName;
    data['shipperPhone'] = this.shipperPhone;
    return data;
  }
}