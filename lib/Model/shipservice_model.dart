class ShipServiceModel {
  int? success;
  List<Data>? data;

  ShipServiceModel({this.success, this.data});

  ShipServiceModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? shipName;
  int? shipDay;
  int? shipPrice;

  Data({this.id, this.shipName, this.shipDay, this.shipPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    shipName = json['shipName'];
    shipDay = json['shipDay'];
    shipPrice = json['ShipPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['shipName'] = this.shipName;
    data['shipDay'] = this.shipDay;
    data['ShipPrice'] = this.shipPrice;
    return data;
  }
}