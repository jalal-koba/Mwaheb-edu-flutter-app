class ConfirmOTP {
  Data? data;
  int? code;

  ConfirmOTP({this.data, this.code});

  ConfirmOTP.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class Data {
  String? code;
  bool? isValid;

  Data({this.code, this.isValid});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    isValid = json['is_valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['is_valid'] = isValid;
    return data;
  }
}
