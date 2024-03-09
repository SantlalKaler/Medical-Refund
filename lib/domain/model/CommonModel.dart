import 'dart:convert';
CommonModel commonModelFromJson(String str) => CommonModel.fromJson(json.decode(str));
String commonModelToJson(CommonModel data) => json.encode(data.toJson());
class CommonModel {
  CommonModel({
      String? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  CommonModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  String? _status;
  String? _message;
CommonModel copyWith({  String? status,
  String? message,
}) => CommonModel(  status: status ?? _status,
  message: message ?? _message,
);
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}