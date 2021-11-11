class BannerModel {
  int? success;
  List<Data>? data;

  BannerModel({this.success, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  int?bannerId;
  String? content;
  String? bannerImage;

  Data({this.bannerId, this.content, this.bannerImage});

  Data.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    content = json['content'];
    bannerImage = json['bannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['content'] = this.content;
    data['bannerImage'] = this.bannerImage;
    return data;
  }
}