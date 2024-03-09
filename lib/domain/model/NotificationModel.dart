import 'dart:convert';
NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));
String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());
class NotificationModel {
  NotificationModel({
      String? status, 
      List<Result>? result,}){
    _status = status;
    _result = result;
}

  NotificationModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  String? _status;
  List<Result>? _result;
NotificationModel copyWith({  String? status,
  List<Result>? result,
}) => NotificationModel(  status: status ?? _status,
  result: result ?? _result,
);
  String? get status => _status;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? id, 
      String? users, 
      String? message, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _users = users;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Result.fromJson(dynamic json) {
    _id = json['_id'];
    _users = json['users'];
    _message = json['message'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _users;
  String? _message;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Result copyWith({  String? id,
  String? users,
  String? message,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Result(  id: id ?? _id,
  users: users ?? _users,
  message: message ?? _message,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get users => _users;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['users'] = _users;
    map['message'] = _message;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}