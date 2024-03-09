
import 'dart:convert';

import 'package:lab_test_app/domain/model/position.dart';


Lab labFromJson(String str) => Lab.fromJson(json.decode(str));
String detailToJson(Lab data) => json.encode(data.toJson());
class Lab {
  Lab({
    Position? position,
    String? id,
    String? name,
    String? description,
    String? email,
    String? phone,
    String? openFrom,
    String? openTo,
    String? officeAddress,
    String? image,
    num? avgRating,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    num? v,
    num? totalRating,}){
    _position = position;
    _id = id;
    _name = name;
    _description = description;
    _email = email;
    _phone = phone;
    _openFrom = openFrom;
    _openTo = openTo;
    _officeAddress = officeAddress;
    _image = image;
    _avgRating = avgRating;
    _active = active;
    _deleted = deleted;
    _slugHistory = slugHistory;
    _slug = slug;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _totalRating = totalRating;
  }

  Lab.fromJson(dynamic json) {
    _position = json['position'] != null ? Position.fromJson(json['position']) : null;
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _email = json['email'];
    _phone = json['phone'];
    _openFrom = json['openFrom'];
    _openTo = json['openTo'];
    _officeAddress = json['officeAddress'];
    _image = json['image'];
    _avgRating = json['avgRating'];
    _active = json['active'];
    _deleted = json['deleted'];
    _slugHistory = json['slug_history'] != null ? json['slug_history'].cast<String>() : [];
    _slug = json['slug'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _totalRating = json['totalRating'];
  }
  Position? _position;
  String? _id;
  String? _name;
  String? _description;
  String? _email;
  String? _phone;
  String? _openFrom;
  String? _openTo;
  String? _officeAddress;
  String? _image;
  num? _avgRating;
  num? _active;
  num? _deleted;
  List<String>? _slugHistory;
  String? _slug;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  num? _totalRating;
  Lab copyWith({  Position? position,
    String? id,
    String? name,
    String? description,
    String? email,
    String? phone,
    String? openFrom,
    String? openTo,
    String? officeAddress,
    String? image,
    num? avgRating,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    num? v,
    num? totalRating,
  }) => Lab(  position: position ?? _position,
    id: id ?? _id,
    name: name ?? _name,
    description: description ?? _description,
    email: email ?? _email,
    phone: phone ?? _phone,
    openFrom: openFrom ?? _openFrom,
    openTo: openTo ?? _openTo,
    officeAddress: officeAddress ?? _officeAddress,
    image: image ?? _image,
    avgRating: avgRating ?? _avgRating,
    active: active ?? _active,
    deleted: deleted ?? _deleted,
    slugHistory: slugHistory ?? _slugHistory,
    slug: slug ?? _slug,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    v: v ?? _v,
    totalRating: totalRating ?? _totalRating,
  );
  Position? get position => _position;
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get email => _email;
  String? get phone => _phone;
  String? get openFrom => _openFrom;
  String? get openTo => _openTo;
  String? get officeAddress => _officeAddress;
  String? get image => _image;
  num? get avgRating => _avgRating;
  num? get active => _active;
  num? get deleted => _deleted;
  List<String>? get slugHistory => _slugHistory;
  String? get slug => _slug;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  num? get totalRating => _totalRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_position != null) {
      map['position'] = _position?.toJson();
    }
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['email'] = _email;
    map['phone'] = _phone;
    map['openFrom'] = _openFrom;
    map['openTo'] = _openTo;
    map['officeAddress'] = _officeAddress;
    map['image'] = _image;
    map['avgRating'] = _avgRating;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['slug_history'] = _slugHistory;
    map['slug'] = _slug;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['totalRating'] = _totalRating;
    return map;
  }

}