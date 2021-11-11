class LoginResponseModel {
  int? success;
  String? token;
  int? idUser;
  String? data;

  LoginResponseModel({this.success, this.token, this.idUser, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    idUser = json['IdUser'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['IdUser'] = this.idUser;
    return data;
  }
}
