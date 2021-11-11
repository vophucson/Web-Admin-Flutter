class UserModel {
  int? success;
  List<Data>? data;

  UserModel({this.success, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? password;
  String? phone;
  String? email;
  String? role;
  String? address;
  String? userimage;

  Data(
      {this.id,
        this.username,
        this.password,
        this.phone,
        this.email,
        this.role,
        this.address,
        this.userimage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    address = json['address'];
    userimage = json['userimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['role'] = this.role;
    data['address'] = this.address;
    data['userimage'] = this.userimage;
    return data;
  }
}