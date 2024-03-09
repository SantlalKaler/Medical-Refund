

import 'dart:convert';

import 'auth/user.dart';

Reviews reviewsFromJson(String str) => Reviews.fromJson(json.decode(str));
String reviewsToJson(Reviews data) => json.encode(data.toJson());
class Reviews {
  Reviews({
    String? id,
    String? lab,
    User? user,
    num? rating,
    String? message,
    bool? approved,
    String? createdAt,
    String? updatedAt,
    num? v,}){
    _id = id;
    _lab = lab;
    _user = user;
    _rating = rating;
    _message = message;
    _approved = approved;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Reviews.fromJson(dynamic json) {
    _id = json['_id'];
    _lab = json['lab'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _rating = json['rating'];
    _message = json['message'];
    _approved = json['approved'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _lab;
  User? _user;
  num? _rating;
  String? _message;
  bool? _approved;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  Reviews copyWith({  String? id,
    String? lab,
    User? user,
    num? rating,
    String? message,
    bool? approved,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) => Reviews(  id: id ?? _id,
    lab: lab ?? _lab,
    user: user ?? _user,
    rating: rating ?? _rating,
    message: message ?? _message,
    approved: approved ?? _approved,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    v: v ?? _v,
  );
  String? get id => _id;
  String? get lab => _lab;
  User? get user => _user;
  num? get rating => _rating;
  String? get message => _message;
  bool? get approved => _approved;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['lab'] = _lab;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['rating'] = _rating;
    map['message'] = _message;
    map['approved'] = _approved;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}