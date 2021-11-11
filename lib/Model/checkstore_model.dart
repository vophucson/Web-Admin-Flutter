class CheckStoreModel {
  int? success;
  List<Data>? data;

  CheckStoreModel({this.success, this.data});

  CheckStoreModel.fromJson(Map<String, dynamic> json) {
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
  int? i36;
  int? i37;
  int? i38;
  int? i39;
  int? i40;
  int? i41;
  int? i42;
  int? i43;
  int? i365;
  int? i375;
  int? i385;
  int? i395;
  int? i405;
  int? i415;
  int? i425;

  Data(
      {this.i36,
        this.i37,
        this.i38,
        this.i39,
        this.i40,
        this.i41,
        this.i42,
        this.i43,
        this.i365,
        this.i375,
        this.i385,
        this.i395,
        this.i405,
        this.i415,
        this.i425});

  Data.fromJson(Map<String, dynamic> json) {
    i36 = json['36'];
    i37 = json['37'];
    i38 = json['38'];
    i39 = json['39'];
    i40 = json['40'];
    i41 = json['41'];
    i42 = json['42'];
    i43 = json['43'];
    i365 = json['36.5'];
    i375 = json['37.5'];
    i385 = json['38.5'];
    i395 = json['39.5'];
    i405 = json['40.5'];
    i415 = json['41.5'];
    i425 = json['42.5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['36'] = this.i36;
    data['37'] = this.i37;
    data['38'] = this.i38;
    data['39'] = this.i39;
    data['40'] = this.i40;
    data['41'] = this.i41;
    data['42'] = this.i42;
    data['43'] = this.i43;
    data['36.5'] = this.i365;
    data['37.5'] = this.i375;
    data['38.5'] = this.i385;
    data['39.5'] = this.i395;
    data['40.5'] = this.i405;
    data['41.5'] = this.i415;
    data['42.5'] = this.i425;
    return data;
  }
}