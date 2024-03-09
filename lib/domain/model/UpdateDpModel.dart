import 'dart:convert';
UpdateDpModel updateDpModelFromJson(String str) => UpdateDpModel.fromJson(json.decode(str));
String updateDpModelToJson(UpdateDpModel data) => json.encode(data.toJson());
class UpdateDpModel {
  UpdateDpModel({
      String? status, 
      String? message, 
      String? image,}){
    _status = status;
    _message = message;
    _image = image;
}

  UpdateDpModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _image = json['image'];
  }
  String? _status;
  String? _message;
  String? _image;
UpdateDpModel copyWith({  String? status,
  String? message,
  String? image,
}) => UpdateDpModel(  status: status ?? _status,
  message: message ?? _message,
  image: image ?? _image,
);
  String? get status => _status;
  String? get message => _message;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['image'] = _image;
    return map;
  }

}