import 'dart:convert';

import 'package:lab_test_app/domain/model/auth/user.dart';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) =>
    json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    String? status,
    String? message,
    User? result,
    String? imgBaseURL,
  }) {
    _status = status;
    _message = message;
    _result = result;
    _imgBaseURL = imgBaseURL;
  }

  UpdateProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'] != null ? User.fromJson(json['result']) : null;
    _imgBaseURL = json['imgBaseURL'];
  }

  String? _status;
  String? _message;
  User? _result;
  String? _imgBaseURL;

  UpdateProfileModel copyWith({
    String? status,
    String? message,
    User? result,
    String? imgBaseURL,
  }) =>
      UpdateProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        result: result ?? _result,
        imgBaseURL: imgBaseURL ?? _imgBaseURL,
      );

  String? get status => _status;

  String? get message => _message;

  User? get result => _result;

  String? get imgBaseURL => _imgBaseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['imgBaseURL'] = _imgBaseURL;
    return map;
  }
}
