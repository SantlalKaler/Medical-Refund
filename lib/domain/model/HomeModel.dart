import 'dart:convert';

import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:lab_test_app/domain/model/test.dart';

import 'Lab.dart';
HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));
String homeModelToJson(HomeModel data) => json.encode(data.toJson());
class HomeModel {
  HomeModel({
      String? status, 
      Result? result,}){
    _status = status;
    _result = result;
}

  HomeModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _status;
  Result? _result;
HomeModel copyWith({  String? status,
  Result? result,
}) => HomeModel(  status: status ?? _status,
  result: result ?? _result,
);
  String? get status => _status;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<Sliders>? sliders, 
      List<Test>? tests,
      List<Lab>? labs,
      List<Specialist>? specialist,}){
    _sliders = sliders;
    _tests = tests;
    _labs = labs;
    _specialist = specialist;
}

  Result.fromJson(dynamic json) {
    if (json['sliders'] != null) {
      _sliders = [];
      json['sliders'].forEach((v) {
        _sliders?.add(Sliders.fromJson(v));
      });
    }
    if (json['tests'] != null) {
      _tests = [];
      json['tests'].forEach((v) {
        _tests?.add(Test.fromJson(v));
      });
    }
    if (json['labs'] != null) {
      _labs = [];
      json['labs'].forEach((v) {
        _labs?.add(Lab.fromJson(v));
      });
    }
    if (json['specialist'] != null) {
      _specialist = [];
      json['specialist'].forEach((v) {
        _specialist?.add(Specialist.fromJson(v));
      });
    }
  }
  List<Sliders>? _sliders;
  List<Test>? _tests;
  List<Lab>? _labs;
  List<Specialist>? _specialist;
Result copyWith({  List<Sliders>? sliders,
  List<Test>? tests,
  List<Lab>? labs,
  List<Specialist>? specialist,
}) => Result(  sliders: sliders ?? _sliders,
  tests: tests ?? _tests,
  labs: labs ?? _labs,
  specialist: specialist ?? _specialist,
);
  List<Sliders>? get sliders => _sliders;
  List<Test>? get tests => _tests;
  List<Lab>? get labs => _labs;
  List<Specialist>? get specialist => _specialist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sliders != null) {
      map['sliders'] = _sliders?.map((v) => v.toJson()).toList();
    }
    if (_tests != null) {
      map['tests'] = _tests?.map((v) => v.toJson()).toList();
    }
    if (_labs != null) {
      map['labs'] = _labs?.map((v) => v.toJson()).toList();
    }
    if (_specialist != null) {
      map['specialist'] = _specialist?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


Sliders slidersFromJson(String str) => Sliders.fromJson(json.decode(str));
String slidersToJson(Sliders data) => json.encode(data.toJson());
class Sliders {
  Sliders({
      String? image,}){
    _image = image;
}

  Sliders.fromJson(dynamic json) {
    _image = json['image'];
  }
  String? _image;
Sliders copyWith({  String? image,
}) => Sliders(  image: image ?? _image,
);
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }

}