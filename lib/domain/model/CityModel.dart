import 'dart:convert';
CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));
String cityModelToJson(CityModel data) => json.encode(data.toJson());
class CityModel {
  CityModel({
      String? status, 
      List<Result>? result,}){
    _status = status;
    _result = result;
}

  CityModel.fromJson(dynamic json) {
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
CityModel copyWith({  String? status,
  List<Result>? result,
}) => CityModel(  status: status ?? _status,
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
      String? name, 
      num? active, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _name = name;
    _active = active;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Result.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _active = json['active'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  num? _active;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Result copyWith({  String? id,
  String? name,
  num? active,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Result(  id: id ?? _id,
  name: name ?? _name,
  active: active ?? _active,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get name => _name;
  num? get active => _active;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['active'] = _active;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}