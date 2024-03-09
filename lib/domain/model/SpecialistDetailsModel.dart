import 'dart:convert';

import 'package:lab_test_app/domain/model/review.dart';
import 'package:lab_test_app/domain/model/specialist.dart';

SpecialistDetailsModel specialistDetailsModelFromJson(String str) =>
    SpecialistDetailsModel.fromJson(json.decode(str));

String specialistDetailsModelToJson(SpecialistDetailsModel data) =>
    json.encode(data.toJson());

class SpecialistDetailsModel {
  SpecialistDetailsModel({
    String? status,
    Result? result,
  }) {
    _status = status;
    _result = result;
  }

  SpecialistDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  String? _status;
  Result? _result;

  SpecialistDetailsModel copyWith({
    String? status,
    Result? result,
  }) =>
      SpecialistDetailsModel(
        status: status ?? _status,
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
    Specialist? detail,
    List<Reviews>? reviews,
    String? imgBaseURL,
  }) {
    _detail = detail;
    _reviews = reviews;
    _imgBaseURL = imgBaseURL;
  }

  Result.fromJson(dynamic json) {
    _detail =
        json['detail'] != null ? Specialist.fromJson(json['detail']) : null;/*
    _reviews =
        json['reviews'] != null ? Reviews.fromJson(json['reviews']) : null;*/
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
    _imgBaseURL = json['imgBaseURL'];
  }

  Specialist? _detail;
  List<Reviews>? _reviews;
  String? _imgBaseURL;

  Result copyWith({
    Specialist? detail,
    List<Reviews>? reviews,
    String? imgBaseURL,
  }) =>
      Result(
        detail: detail ?? _detail,
        reviews: reviews ?? _reviews,
        imgBaseURL: imgBaseURL ?? _imgBaseURL,
      );

  Specialist? get detail => _detail;

  List<Reviews>? get reviews => _reviews;

  String? get imgBaseURL => _imgBaseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.toJson();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
     // map['reviews'] = _reviews?.toJson();
    }
    map['imgBaseURL'] = _imgBaseURL;
    return map;
  }
}
