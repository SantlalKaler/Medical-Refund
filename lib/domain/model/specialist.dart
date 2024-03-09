/*

import 'dart:convert';

import 'package:lab_test_app/domain/model/position.dart';


Specialist specialistFromJson(String str) => Specialist.fromJson(json.decode(str));
String specialistToJson(Specialist data) => json.encode(data.toJson());
class Specialist {
  Specialist({
    Position? position,
    String? id,
    String? name,
    String? education,
    String? expereance,
    String? desc,
    String? officeAddress,
    String? image,
    num? avgRating,
    num? priceBefore,
    num? price,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    String? totalPatients,
    String? mobile,
    num? v,
    num? totalRating,}){
    _position = position;
    _id = id;
    _name = name;
    _education = education;
    _expereance = expereance;
    _desc = desc;
    _officeAddress = officeAddress;
    _image = image;
    _avgRating = avgRating;
    _priceBefore = priceBefore;
    _price = price;
    _active = active;
    _deleted = deleted;
    _slugHistory = slugHistory;
    _slug = slug;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _totalPatients = totalPatients;
    _mobile = mobile;
    _v = v;
    _totalRating = totalRating;
  }

  Specialist.fromJson(dynamic json) {
    _id = json['_id'];
    _position = json['position'] != null ? Position.fromJson(json['position']) : null;
    _name = json['name'];
    _education = json['education'];
    _expereance = json['expereance'];
    _desc = json['desc'];
    _officeAddress = json['officeAddress'];
    _image = json['image'];
    _avgRating = json['avgRating'];
    _priceBefore = json['priceBefore'];
    _price = json['price'];
    _active = json['active'];
    _deleted = json['deleted'];
    _slugHistory = json['slug_history'] != null ? json['slug_history'].cast<String>() : [];
    _slug = json['slug'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _totalPatients = json['totalPatients'];
    _mobile = json['mobile'];
    _v = json['__v'];
    _totalRating = json['totalRating'];
  }
  Position? _position;
  String? _id;
  String? _name;
  String? _education;
  String? _expereance;
  String? _desc;
  String? _officeAddress;
  String? _image;
  num? _avgRating;
  num? _priceBefore;
  num? _price;
  num? _active;
  num? _deleted;
  List<String>? _slugHistory;
  String? _slug;
  String? _createdAt;
  String? _updatedAt;
  String? _totalPatients;
  String? _mobile;
  num? _v;
  num? _totalRating;
  Specialist copyWith({  Position? position,
    String? id,
    String? name,
    String? education,
    String? expereance,
    String? desc,
    String? officeAddress,
    String? image,
    num? avgRating,
    num? priceBefore,
    num? price,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    String? totalPatients,
    String? mobile,
    num? v,
    num? totalRating,
  }) => Specialist(  position: position ?? _position,
    id: id ?? _id,
    name: name ?? _name,
    education: education ?? _education,
    expereance: expereance ?? _expereance,
    desc: desc ?? _desc,
    officeAddress: officeAddress ?? _officeAddress,
    image: image ?? _image,
    avgRating: avgRating ?? _avgRating,
    priceBefore: priceBefore ?? _priceBefore,
    price: price ?? _price,
    active: active ?? _active,
    deleted: deleted ?? _deleted,
    slugHistory: slugHistory ?? _slugHistory,
    slug: slug ?? _slug,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    totalPatients: totalPatients ?? _totalPatients,
    mobile: mobile ?? _mobile,
    v: v ?? _v,
    totalRating: totalRating ?? _totalRating,
  );
  Position? get position => _position;
  String? get id => _id;
  String? get name => _name;
  String? get education => _education;
  String? get expereance => _expereance;
  String? get desc => _desc;
  String? get officeAddress => _officeAddress;
  String? get image => _image;
  num? get avgRating => _avgRating;
  num? get priceBefore => _priceBefore;
  num? get price => _price;
  num? get active => _active;
  num? get deleted => _deleted;
  List<String>? get slugHistory => _slugHistory;
  String? get slug => _slug;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get totalPatients => _totalPatients;
  String? get mobile => _mobile;
  num? get v => _v;
  num? get totalRating => _totalRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_position != null) {
      map['position'] = _position?.toJson();
    }
    map['_id'] = _id;
    map['name'] = _name;
    map['education'] = _education;
    map['expereance'] = _expereance;
    map['desc'] = _desc;
    map['officeAddress'] = _officeAddress;
    map['image'] = _image;
    map['avgRating'] = _avgRating;
    map['priceBefore'] = _priceBefore;
    map['price'] = _price;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['slug_history'] = _slugHistory;
    map['slug'] = _slug;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['totalPatients'] = _totalPatients;
    map['mobile'] = _mobile;
    map['__v'] = _v;
    map['totalRating'] = _totalRating;
    return map;
  }

}*/
import 'dart:convert';
Specialist specialistFromJson(String str) => Specialist.fromJson(json.decode(str));
String specialistDToJson(Specialist data) => json.encode(data.toJson());
class Specialist {
  Specialist({
    Position? position,
    String? id,
    String? name,
    String? education,
    String? expereance,
    String? desc,
    String? officeAddress,
    String? image,
    num? avgRating,
    num? priceBefore,
    num? price,
    num? adminCommission,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    num? v,
    num? totalRating,
    String? totalPatients,
    String? mobile,
    String? city,
    String? deviceToken,
    String? deviceType,}){
    _position = position;
    _id = id;
    _name = name;
    _education = education;
    _expereance = expereance;
    _desc = desc;
    _officeAddress = officeAddress;
    _image = image;
    _avgRating = avgRating;
    _priceBefore = priceBefore;
    _price = price;
    _adminCommission = adminCommission;
    _active = active;
    _deleted = deleted;
    _slugHistory = slugHistory;
    _slug = slug;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _totalRating = totalRating;
    _totalPatients = totalPatients;
    _mobile = mobile;
    _city = city;
    _deviceToken = deviceToken;
    _deviceType = deviceType;
  }

  Specialist.fromJson(dynamic json) {
    _position = json['position'] != null ? Position.fromJson(json['position']) : null;
    _id = json['_id'];
    _name = json['name'];
    _education = json['education'];
    _expereance = json['expereance'];
    _desc = json['desc'];
    _officeAddress = json['officeAddress'];
    _image = json['image'];
    _avgRating = json['avgRating'];
    _priceBefore = json['priceBefore'];
    _price = json['price'];
    _adminCommission = json['adminCommission'];
    _active = json['active'];
    _deleted = json['deleted'];
    _slugHistory = json['slug_history'] != null ? json['slug_history'].cast<String>() : [];
    _slug = json['slug'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _totalRating = json['totalRating'];
    _totalPatients = json['totalPatients'];
    _mobile = json['mobile'];
    _city = json['city'];
    _deviceToken = json['deviceToken'];
    _deviceType = json['deviceType'];
  }
  Position? _position;
  String? _id;
  String? _name;
  String? _education;
  String? _expereance;
  String? _desc;
  String? _officeAddress;
  String? _image;
  num? _avgRating;
  num? _priceBefore;
  num? _price;
  num? _adminCommission;
  num? _active;
  num? _deleted;
  List<String>? _slugHistory;
  String? _slug;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  num? _totalRating;
  String? _totalPatients;
  String? _mobile;
  String? _city;
  String? _deviceToken;
  String? _deviceType;
  Specialist copyWith({  Position? position,
    String? id,
    String? name,
    String? education,
    String? expereance,
    String? desc,
    String? officeAddress,
    String? image,
    num? avgRating,
    num? priceBefore,
    num? price,
    num? adminCommission,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    num? v,
    num? totalRating,
    String? totalPatients,
    String? mobile,
    String? city,
    String? deviceToken,
    String? deviceType,
  }) => Specialist(  position: position ?? _position,
    id: id ?? _id,
    name: name ?? _name,
    education: education ?? _education,
    expereance: expereance ?? _expereance,
    desc: desc ?? _desc,
    officeAddress: officeAddress ?? _officeAddress,
    image: image ?? _image,
    avgRating: avgRating ?? _avgRating,
    priceBefore: priceBefore ?? _priceBefore,
    price: price ?? _price,
    adminCommission: adminCommission ?? _adminCommission,
    active: active ?? _active,
    deleted: deleted ?? _deleted,
    slugHistory: slugHistory ?? _slugHistory,
    slug: slug ?? _slug,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    v: v ?? _v,
    totalRating: totalRating ?? _totalRating,
    totalPatients: totalPatients ?? _totalPatients,
    mobile: mobile ?? _mobile,
    city: city ?? _city,
    deviceToken: deviceToken ?? _deviceToken,
    deviceType: deviceType ?? _deviceType,
  );
  Position? get position => _position;
  String? get id => _id;
  String? get name => _name;
  String? get education => _education;
  String? get expereance => _expereance;
  String? get desc => _desc;
  String? get officeAddress => _officeAddress;
  String? get image => _image;
  num? get avgRating => _avgRating;
  num? get priceBefore => _priceBefore;
  num? get price => _price;
  num? get adminCommission => _adminCommission;
  num? get active => _active;
  num? get deleted => _deleted;
  List<String>? get slugHistory => _slugHistory;
  String? get slug => _slug;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  num? get totalRating => _totalRating;
  String? get totalPatients => _totalPatients;
  String? get mobile => _mobile;
  String? get city => _city;
  String? get deviceToken => _deviceToken;
  String? get deviceType => _deviceType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_position != null) {
      map['position'] = _position?.toJson();
    }
    map['_id'] = _id;
    map['name'] = _name;
    map['education'] = _education;
    map['expereance'] = _expereance;
    map['desc'] = _desc;
    map['officeAddress'] = _officeAddress;
    map['image'] = _image;
    map['avgRating'] = _avgRating;
    map['priceBefore'] = _priceBefore;
    map['price'] = _price;
    map['adminCommission'] = _adminCommission;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['slug_history'] = _slugHistory;
    map['slug'] = _slug;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['totalRating'] = _totalRating;
    map['totalPatients'] = _totalPatients;
    map['mobile'] = _mobile;
    map['city'] = _city;
    map['deviceToken'] = _deviceToken;
    map['deviceType'] = _deviceType;
    return map;
  }

}

Position positionFromJson(String str) => Position.fromJson(json.decode(str));
String positionToJson(Position data) => json.encode(data.toJson());
class Position {
  Position({
    String? type,
    List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
  }

  Position.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
  Position copyWith({  String? type,
    List<num>? coordinates,
  }) => Position(  type: type ?? _type,
    coordinates: coordinates ?? _coordinates,
  );
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}